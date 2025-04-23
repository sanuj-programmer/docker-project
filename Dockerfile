# Stage 1: Build the Vite app
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with `serve`
FROM node:18-alpine

WORKDIR /app

# Install 'serve'
RUN npm install -g serve

# Copy built output from builder
COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]
