# Use the latest Elixir image
FROM elixir:1.15-alpine

# Install Hex, Rebar, Node.js, and build tools
RUN mix local.hex --force && \
    mix local.rebar --force && \
    apk add --no-cache build-base git nodejs npm

# Set working directory
WORKDIR /app

# Copy mix files and install Elixir dependencies
COPY mix.exs mix.lock ./
COPY config ./config
RUN mix deps.get

# Copy the rest of the application code
COPY . .

# Expose the Phoenix port
EXPOSE 4000

# Default command: get deps, migrate DB, run seeds, start server
CMD ["sh", "-c", "mix deps.get && mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs && mix phx.server"]