###############################
# Base image
###############################
FROM node:20-alpine AS base

# Create app directory
WORKDIR /app

# Install app dependencies early for better layer caching
COPY package.json package-lock.json* pnpm-lock.yaml* ./
RUN npm install --legacy-peer-deps --silent

###############################
# Development image – hot-reload
###############################
FROM base AS dev

# Copy source code
COPY . .

ENV NODE_ENV=development

# Next.js dev server port
EXPOSE 3000

CMD ["npm", "run", "dev"]

###############################
# Build image – production build
###############################
FROM base AS builder

# Inject API URLs at build time so Next.js can embed them
ARG NEXT_PUBLIC_API_URL
ARG API_INTERNAL_URL
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV API_INTERNAL_URL=${API_INTERNAL_URL}

COPY . .
RUN npm run build

###############################
# Production runtime image
###############################
FROM node:20-alpine AS production
WORKDIR /app

# Expected at runtime for SSR
ENV NODE_ENV=production

# Copy compiled output and node_modules from builder stage
COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"] 