# these are in a dependency order
CYBER_DOJO_BASE_REPOS=(ruby sinatra docker web_base nginx)
CYBER_DOJO_SERVICE_REPOS=(storer zipper differ runner puller collector commander web)
CYBER_DOJO_WIP_REPOS=(prometheus)
CYBER_DOJO_REPOS=("${CYBER_DOJO_BASE_REPOS[@]}" "${CYBER_DOJO_SERVICE_REPOS[@]}" "${CYBER_DOJO_WIP_REPOS[@]}")

