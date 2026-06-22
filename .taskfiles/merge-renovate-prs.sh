#!/bin/bash

refs=$(curl \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/zekker6/helm-charts/pulls | jq -r '.[] | select(.user.login |  contains("renovate[bot]")) | .head.ref')

echo $refs

git fetch --all --prune
set -ex
for ref in $refs; do
  echo checking $ref

  # if contains changes to library charts then skip
  files_diff=$(git diff --name-only origin/main...origin/$ref | tr ' ' '\n')
  files_changed=$(git diff --name-only origin/main...origin/$ref | tr ' ' '\n' | wc -l)
  if [[ $files_changed != "2" ]]; then
    # It is expected to have only Chart.yaml and values.yaml changed
    echo "Skipping $ref as it contains more than two files"
    continue
  fi

  if echo $files_diff | grep "charts/library"; then
    echo "Skipping $ref"
    continue
  fi

  echo "Merging $ref"
  # Delete the branch if it exists locally before checking it out
  # this is to ensure we are working with the latest changes
  git branch -D $ref || true
  git checkout $ref
  git pull --rebase

  # Update chart version, app version and artifacthub.io/changes
  # get commit message
  commit_message=$(git log --format=%B -n 1 origin/$ref | awk -F ': ' '{print $2}')

  chart_file=$(echo $files_diff | sed 's/values.yaml/Chart.yaml/' | awk -F ' ' '{print $1}')

  task charts:bump CHART_FILE="$chart_file" DESCRIPTION="$commit_message"

  git diff
  git commit -am "chore: bump chart version"
  git push
done

git checkout main
