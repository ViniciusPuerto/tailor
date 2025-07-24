# Tailor – Monorepo (Phoenix API + Next.js Front-end)

This repository contains the **Tailor System** (`tailor_api`) and front-end (`tailor-frontend`).
Everything is pre-containerised, so you can run the entire stack with a single Docker command—no Elixir, Node, or Postgres needed on your machine.
</br><small>Observation: It’s a very simple application—just a CRUD and a login with a pre-seeded user.</small>

---
## Live Demo

Access the production environment → [http://ec2-18-229-255-81.sa-east-1.compute.amazonaws.com:3000/login](http://ec2-18-229-255-81.sa-east-1.compute.amazonaws.com:3000/login)

---
## 1. Prerequisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop/) **or** Docker Engine + `docker compose` plugin (v2+).
* ~4 GB of RAM & ~4 GB of free disk space for the images.

---
## 2. Clone the repo
```bash
git clone https://github.com/ViniciusPuerto/tailor.git
cd tailor
```

---
## 3. One-liner: start everything

```bash
./start.sh --fresh   # first time (removes old volumes, sets up DB)
# OR
./start.sh           # subsequent runs (keeps DB data)
```

Script actions:
1. Builds the Docker images (Phoenix API, Next.js front-end, Postgres)
2. Runs database migrations & seeds
3. Starts the stack in attached mode (`docker compose up`)

Press `Ctrl-C` to stop the services. They will shut down gracefully.

---
## 4. Manual docker-compose commands (optional)

If you prefer plain `docker compose`:

```bash
# Build images
docker compose build

# Start services (detached)
docker compose up -d

# Stop services
docker compose down
```

---
## 5. End-points

* API (Phoenix)     → http://localhost:4000/api
* Front-end (Next)  → http://localhost:3000

Seed credentials (created by `priv/repo/seeds.exs`):
```text
Email:    admin@example.com
Password: supersecret
```

---
## 6. Useful extras

* **Reset the database**
  ```bash
  ./start.sh --reset   # drops, recreates, migrates, seeds
  ```
* **Live logs**
  ```bash
  docker compose logs -f tailor_api          # API logs
  docker compose logs -f tailor-frontend     # Front-end logs
  ```
* **Run tests**
  ```bash
  docker compose run --rm tailor_api mix test
  docker compose run --rm tailor-frontend npm test
  ```

---
Happy hacking! 🚀 