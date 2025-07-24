#!/usr/bin/env bash
# run_specs.sh — convenience script to run all specs for Tailor marketplace
#
# This script executes both the Elixir backend (tailor_api) and the
# React/Next.js frontend (tailor-frontend) test suites so that you can verify
# the entire stack in one go.
#
# Usage:
#   ./run_specs.sh          # installs deps (if missing) and runs all tests
#   CI=true ./run_specs.sh  # skips interactive npm output in CI environments
#
set -euo pipefail

section() {
  echo -e "\n\033[1;32m==> $*\033[0m"
}

########################################
# Backend (Elixir / Phoenix)
########################################
section "Running Tailor API specs"
(
  cd tailor_api

  # Ensure test dependencies are present
  mix deps.get --only test > /dev/null

  # Prepare the test database (silences output for cleaner logs)
  MIX_ENV=test mix ecto.create --quiet
  MIX_ENV=test mix ecto.migrate --quiet

  # Execute the test suite
  mix test "$@"
)

########################################
# Frontend (React / Next.js)
########################################
section "Running Tailor Frontend specs"
(
  cd tailor-frontend

  # Install NPM deps only if node_modules is missing (saves time in CI)
  if [ ! -d node_modules ]; then
    npm ci --silent
  fi

  # Run tests; in CI we disable watch mode to avoid hanging
  if [[ ${CI:-false} == "true" ]]; then
    npm test -- --runInBand --ci
  else
    npm test
  fi
)

section "✅ All specs finished successfully" 