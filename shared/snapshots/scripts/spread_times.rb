# Spreads a group's traffic-light times over a ~1 hour session ending now, so the
# dashboard's minute columns look like a real practice session.
# Runs inside the saver container. A kata is a git repo read via its main branch
# (not its working tree), so events.json is rewritten onto main with git plumbing.
# A group is plain files, so its manifest.json is rewritten in place.
# Usage: ruby spread_times.rb <group_id> <kata_id> [<kata_id> ...]
require 'json'
require 'open3'

SESSION_SECONDS = 62 * 60
T0 = Time.now - SESSION_SECONDS - 120

# Returns the dir for a saver id under the given kind (katas/groups).
def repo(kind, id) = "/cyber-dojo/#{kind}/#{id[0, 2]}/#{id[2, 2]}/#{id[4, 2]}"

# Runs a git command in dir and returns its stdout, raising if it fails.
def git(dir, *args, stdin: nil, env: {})
  out, err, st = Open3.capture3(env, 'git', '-C', dir, *args, stdin_data: stdin)
  raise "git #{args.join(' ')}: #{err}" unless st.success?
  out.strip
end

# Commits new content for one file onto main without touching the working tree.
def commit_file(dir, filename, content, message)
  idx = "/tmp/idx-#{rand(1_000_000)}"
  env = { 'GIT_INDEX_FILE' => idx, 'GIT_AUTHOR_NAME' => 'saver', 'GIT_AUTHOR_EMAIL' => 'saver@cyber-dojo',
          'GIT_COMMITTER_NAME' => 'saver', 'GIT_COMMITTER_EMAIL' => 'saver@cyber-dojo' }
  git(dir, 'read-tree', 'main', env: env)
  blob = git(dir, 'hash-object', '-w', '--stdin', stdin: content)
  git(dir, 'update-index', '--cacheinfo', "100644,#{blob},#{filename}", env: env)
  tree = git(dir, 'write-tree', env: env)
  commit = git(dir, 'commit-tree', tree, '-p', 'main', '-m', message, env: env)
  git(dir, 'update-ref', 'refs/heads/main', commit)
  File.delete(idx) if File.exist?(idx)
end

# Returns a saver time array for a Time.
def time_a(t) = [t.year, t.month, t.day, t.hour, t.min, t.sec, rand(1_000_000)]

group_id, *kata_ids = ARGV

# The dashboard's minute columns count from the group's created time.
gpath = "#{repo('groups', group_id)}/manifest.json"
manifest = JSON.parse(File.read(gpath))
manifest['created'] = time_a(T0)[0..5] + [0]
File.write(gpath, JSON.generate(manifest))

kata_ids.each do |kata_id|
  kdir = repo('katas', kata_id)
  events = JSON.parse(git(kdir, 'show', 'main:events.json'))
  lights = events.count { |e| %w[red amber green].include?(e['colour']) }
  # Raw gaps per light: ~20% under a minute, the rest 1-4 minutes; then scale to fit the session.
  gaps = Array.new(lights) { rand < 0.2 ? rand(20..59) : rand(60..240) }
  start = T0 + rand(0..150)
  budget = SESSION_SECONDS - (start - T0) - rand(0..300)
  scale = [1.0, budget.to_f / gaps.sum].min
  gaps.map! { |g| [g * scale, 15].max }
  t = start
  light_n = 0
  events.each_with_index do |e, i|
    if i.zero?
      e['time'] = time_a(start - 30)
    elsif %w[red amber green].include?(e['colour'])
      t += gaps[light_n]
      light_n += 1
      e['time'] = time_a(t)
    else
      # Non-light events (file edits, option sets) sit just after the previous light,
      # which keeps them before the next light since every gap is at least 15s.
      e['time'] = time_a(t + 5)
    end
  end
  commit_file(kdir, 'events.json', JSON.pretty_generate(events), 'spread session times')
  puts "#{kata_id}: #{lights} lights from #{start.strftime('%H:%M')} to #{t.strftime('%H:%M')}"
end
