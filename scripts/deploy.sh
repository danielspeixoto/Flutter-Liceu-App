#!/usr/bin/env bash
set -e
set -x

rm .env

echo "
ENV=production
URL=https://protected-river-16209.herokuapp.com/v2
API_KEY=8y/B?E(H+MbQeThWmYq3t6w9z\$C&F)J@
" > .env

fastlane android beta