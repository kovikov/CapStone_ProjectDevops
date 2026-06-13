# Zuri Market Backend

This backend uses Node.js, Express, CORS, and dotenv.

## Setup

1. Install dependencies:
   ```bash
   npm install
   ```
2. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```
3. Run the app in development:
   ```bash
   npm run dev
   ```

## Docker

Build the image:
```bash
docker build -t zuri-market-backend .
```

Run the container:
```bash
docker run -p 4000:4000 --env-file .env zuri-market-backend
```
