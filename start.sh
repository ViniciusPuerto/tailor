#!/usr/bin/env bash
# start.sh — convenience script to bootstrap the Tailor marketplace stack
#
# - builds Docker images
# - runs database migrations & seeds
# - starts API and frontend services
#
# Usage:
#   ./start.sh            # build + up (detached)
#   ./start.sh --fresh    # also removes existing volumes for a clean DB
#
set -euo pipefail

PROJECT_NAME="$(basename "$PWD")"

fresh=false
if [[ "${1:-}" == "--fresh" ]]; then
  fresh=true
fi

reset=false
if [[ "${1:-}" == "--reset" ]]; then
  reset=true
fi

info() { echo -e "\033[1;34m→ $*\033[0m"; }

info "Building Docker images…"
docker compose build

if $fresh; then
  info "Removing existing volumes (fresh start)…"
  docker compose down -v --remove-orphans || true
fi

if $reset; then
  info "Resetting database…"
  docker compose run --rm tailor_api mix ecto.reset
fi

info "Setting up database…"
docker compose run --rm tailor_api mix ecto.setup

info "Starting API and Frontend services…"
docker compose up

info "All services are up!"
info "  API:      http://localhost:4000"
info "  Frontend: http://localhost:3000" 