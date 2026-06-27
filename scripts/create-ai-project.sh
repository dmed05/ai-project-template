#!/usr/bin/env bash
set -euo pipefail

if (($# < 2 || $# > 3)); then
  printf 'Usage: %s REPOSITORY_NAME DESCRIPTION [public|private]\n' "$0" >&2
  exit 2
fi

repository_name="$1"
description="$2"
visibility="${3:-public}"
owner="${GITHUB_OWNER:-dmed05}"
template="${GITHUB_TEMPLATE:-dmed05/ai-project-template}"
root="$(git rev-parse --show-toplevel)"

case "$visibility" in
  public) visibility_flag='--public' ;;
  private) visibility_flag='--private' ;;
  *)
    printf 'Visibility must be public or private.\n' >&2
    exit 2
    ;;
esac

gh auth status >/dev/null

gh repo create "$owner/$repository_name" \
  "$visibility_flag" \
  --template "$template" \
  --description "$description"

gh api \
  --method POST \
  "repos/$owner/$repository_name/rulesets" \
  --input "$root/.github/rulesets/portfolio-policy.json" >/dev/null

gh repo clone "$owner/$repository_name"
git -C "$repository_name" config user.email \
  '75545911+dmed05@users.noreply.github.com'

printf '\nCreated %s/%s from the portfolio template.\n' "$owner" "$repository_name"
printf 'Customize README.md, remove .portfolio-template-marker, run the policy check, and open a pull request.\n'
