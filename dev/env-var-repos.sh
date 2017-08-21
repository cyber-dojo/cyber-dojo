# these are in a dependency order
CD_BASE_REPOS=(ruby sinatra docker web_base nginx)
CD_SERVICE_REPOS=(storer zipper differ runner runner_stateless collector commander web)
CD_MONITORING_REPOS=(prometheus grafana)
CYBER_DOJO_REPOS=("${CD_BASE_REPOS[@]}" "${CD_SERVICE_REPOS[@]}" "${CD_MONITORING_REPOS[@]}")
