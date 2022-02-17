export PATH=$PATH:/usr/local/go/bin
export HUGO_HOST=${HUGO_HOST:-"127.0.0.1"}
export HUGO_PORT=${HUGO_PORT:-"4547"}
export HUGO_BASE_URL=${HUGO_BASE_URL:-"http://${HUGO_HOST}:${HUGO_PORT}"}
export WITH_GO=${WITH_GO:-"true"}
if [ "${WITH_GO}" == "true" ]; then
  echo "project does require Golang"
  export PATH=$PATH:/usr/local/go/bin && go version
fi;
export DEPLOYMENT_BASE_URL=${DEPLOYMENT_BASE_URL:-"https://doctothonio.github.io/rubbish/"}
