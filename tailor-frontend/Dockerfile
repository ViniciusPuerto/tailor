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
COPY . .
RUN npm run build

###############################
# Production runtime image
###############################
FROM node:20-alpine AS production
WORKDIR /app

# Copy compiled output and node_modules from builder stage
COPY --from=builder /app .

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npm", "start"] 