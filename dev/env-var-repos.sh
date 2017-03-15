# these are in a dependency order
CYBER_DOJO_BASE_REPOS=(ruby sinatra docker web_base nginx)
CYBER_DOJO_SERVICE_REPOS=(storer zipper differ runner collector commander web)
CYBER_DOJO_MONITORING_REPOS=(prometheus grafana)
CYBER_DOJO_REPOS=("${CYBER_DOJO_BASE_REPOS[@]}" "${CYBER_DOJO_SERVICE_REPOS[@]}" "${CYBER_DOJO_MONITORING_REPOS[@]}")
