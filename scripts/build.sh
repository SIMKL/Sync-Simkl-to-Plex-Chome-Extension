#!/usr/bin/env bash

set -ex

rm -rf dist
# bug with gha?
if [ -n "${CI}" ]; then
  sudo rm -rf src/_metadata
fi
cp -R -p src dist

# minify assets
if ! command -v minify; then
  go install github.com/tdewolff/minify/cmd/minify@latest
fi

# remove dev stuff
# comment one of the following lines to enable debugging
# this will disable console logs
# sed -i "s/DEVELOPMENT=true/DEVELOPMENT=false/g" dist/js/common.js
# this will disable uploading to logger
#sed -i -r "s/const DEVELOPMENT_FETCH_REQS=(true|false);//g" dist/js/common.js
# this will remove the loggin logic entirely
# sed -i -r "s/const devLoggerSetup=\(.*\};/const devloggerSetup=_=>_=>\{\}\;/g" dist/js/common.js

# prevent tests from bundling
rm -rf dist/tests
rm -f dist/js/vendor/qunit-2.23.1.js
rm -f dist/css/vendor/qunit-2.18.2-dark.css

minify -r -o dist/ src

set +ex

if [ ! -f dist/js/background/env.js ]; then
  cat <<HEREDOC >dist/js/background/env.js
const SimklClientID = "$SIMKL_CLIENT_ID";
const SimklClientSecret = "$SIMKL_CLIENT_SECRET";
HEREDOC
fi

find dist -type f -name "*.js" -print0 | while IFS= read -r -d '' i; do
  # removing consoledebug calls
  # sed -i -r "s/consoledebug\([^;]*\)\(\);/;/g" "$i"
  # sed -i -r "s/console.debug\([^;]*\);/;/g" "$i"
  minify -o "$i" "$i"
  # validate generated js files for syntax
  echo + "node -c $i"
  if ! env NO_COLOR=1 node -c "$i"; then
    exit 1 # fail fast
  fi
done

set -ex
