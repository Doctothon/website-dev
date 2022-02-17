#!/bin/bash

# -
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -- [$0]"
echo "# ------ --  Start Hugo project : "
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
ls -alh ./.npm.scripts/dev/env.sh
source ./.npm.scripts/dev/env.sh
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ -  PATH=[${PATH}]"
echo "# ------ -  HUGO_HOST=[${HUGO_HOST}]"
echo "# ------ -  HUGO_PORT=[${HUGO_PORT}]"
echo "# ------ -  HUGO_BASE_URL=[${HUGO_BASE_URL}]"
echo "# ------ -  HUGO_BASE_URL=[${HUGO_BASE_URL}]"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
echo "# ------ ------ ------ ------ ------ ------ ------ #"
hugo serve -b ${HUGO_BASE_URL} -p ${HUGO_PORT} --bind ${HUGO_HOST} -w
