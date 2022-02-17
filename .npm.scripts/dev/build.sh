#!/bin/bash

# -
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -- [$0]"
echo "# ------ --  Build Hugo project : "
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
ls -alh ./.npm.scripts/dev/env.sh
source ./.npm.scripts/dev/env.sh
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -  PATH=[${PATH}]"
echo "# ------ -  HUGO_HOST=[${HUGO_HOST}]"
echo "# ------ -  HUGO_PORT=[${HUGO_PORT}]"
echo "# ------ -  HUGO_BASE_URL=[${HUGO_BASE_URL}]"
echo "# ------ -  DEPLOYMENT_BASE_URL=[${DEPLOYMENT_BASE_URL}]"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"



if [ -d ./public ]; then
  rm -fr ./public
fi;

mkdir -p  ./public

hugo -b ${DEPLOYMENT_BASE_URL}

exit 0

# // for the Github pages deployment : done by the parent package.json, as the Orb release



npm run build-doc:prod # cd documentation/hugo/ && npm run build:prod


if [ -d ./../docs ]; then
  rm -fr ./../docs
fi;
mkdir -p  ./../docs
cp -fr ./public/* ./../docs/



exit 0

# --- ---- ------
# -- PARENT -- PROJECT --
# --- ---- ------
npm run test:dev # run the dev test of the circle ci orb
npm run test:prod # run the prod test of the circle ci orb

npm run build:dev # packs the circle ci orb
npm run build:prod # packs the circle ci orb: there is no such thing as a production build for Circle CI ORb

npm run preps:dev # (force re-) installs all npm project dependencies
npm run preps:g # (force re-) installs npm global dependencies
npm run preps:all # (force re-) installs both npm global and npm project dependencies
npm run preps # short for 'npm run preps:all'

npm run doc:preps:dev # cd documentation/hugo/ && npm run preps:dev
npm run doc:preps:g # cd documentation/hugo/ && npm run preps:g
npm run doc:preps:all # cd documentation/hugo/ && npm run preps:all
npm run doc:preps # cd documentation/hugo/ && npm run preps

npm run doc:test:dev # cd documentation/hugo/ && npm run test:dev
npm run doc:test:prod # cd documentation/hugo/ && npm run test:prod

npm run doc:build:dev # cd documentation/hugo/ && npm run build:dev
npm run doc:build:prod # cd documentation/hugo/ && npm run build:prod
npm run doc:release:gh_pages # source ./.npm.scripts/release/env.sh && ./.npm.scripts/release/gh_pages.sh
npm run doc:release:heroku # source ./.npm.scripts/release/env.sh && ./.npm.scripts/release/heroku.sh


npm run doc:start # cd documentation/hugo/ && npm start

exit 0
npm init --yes
mkdir -p ./.npm.scripts/release/
touch ./.npm.scripts/release/env.sh
touch ./.npm.scripts/release/heroku.sh
touch ./.npm.scripts/release/gh_pages.sh
mkdir -p ./.npm.scripts/dev/
touch ./.npm.scripts/dev/env.sh
touch ./.npm.scripts/dev/test.sh
touch ./.npm.scripts/dev/build.sh
touch ./.npm.scripts/dev/start.sh
touch ./.npm.scripts/dev/stop.sh
touch ./.npm.scripts/dev/prepare.sh
touch ./.npm.scripts/dev/prepare-g.sh
touch ./.npm.scripts/dev/prepare-dev.sh

mkdir -p ./.npm.scripts/prod/
touch ./.npm.scripts/prod/env.sh
touch ./.npm.scripts/prod/test.sh
touch ./.npm.scripts/prod/build.sh

touch ./.npm.scripts/clean.sh

chmod +x ./.npm.scripts/*.sh ./.npm.scripts/**/*.sh
chmod +x *.sh ./**/*.sh ./.npm.scripts/*.sh ./.npm.scripts/**/*.sh
