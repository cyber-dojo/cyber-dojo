# these are in a dependency order
CD_SERVICE_REPOS=(starter storer zipper differ runner_stateful runner_stateless collector commander web nginx)
CD_MONITORING_REPOS=(prometheus grafana)
CYBER_DOJO_REPOS=("${CD_SERVICE_REPOS[@]}" "${CD_MONITORING_REPOS[@]}")
