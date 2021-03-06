#!/bin/bash

set -e

doc_dir=inst/web

# adapted from https://github.com/tjmahr/rprime/blob/1e756aea85677ebcbe785e4d3bd65e3b367e0660/deploy-pages.sh
# and https://github.com/RyanHope/gazetools/blob/master/staticdocs-gh_pages.sh
# and https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
#
# For local testing use:
# TRAVIS_OS_NAME=linux TRAVIS_PULL_REQUEST=false TRAVIS_BRANCH=production TRAVIS_REPO_SLUG=rstats-db/DBI TRAVIS_COMMIT=$(git rev-parse HEAD) GITHUB_PAT=<your-PAT> scripts/deploy-pages.sh

if [ "$TRAVIS_OS_NAME" == "linux" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "production" ] && [ "$GITHUB_PAT" != "" ]; then
  # Query name and e-mail of current author
  # https://gist.github.com/l15n/3103708
  user_email=$(git show --format="%ae" | head -n 1)
  user_name=$(git show --format="%an" | head -n 1)

  rm -rf $doc_dir
  mkdir -p $doc_dir

  # Clone the current docs.
  git clone --quiet --branch=gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG} $doc_dir > /dev/null

  # Clean current docs and build anew.
  echo -e "Building staticdocs...\n"
  rm -r $doc_dir/*
  R -q -e "staticdocs::build_site()"

  echo -e "Publishing staticdocs...\n"
  cd $doc_dir

  # Reuse the name and e-mail of the author of the last commit
  git config user.email $user_email
  git config user.name $user_name

  # Include .nojekyll as a directive for github
  touch .nojekyll

  # Commit and publish
  git add -A

  git commit --allow-empty -F /dev/stdin <<EOF
Deploy pages from Travis build ${TRAVIS_BUILD_NUMBER}

Build URL: https://travis-ci.org/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_ID}
Commit: ${TRAVIS_COMMIT}
EOF

  git push --quiet origin gh-pages

  echo -e "Published staticdocs to gh-pages.\n"
fi
