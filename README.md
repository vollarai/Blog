# Blog

A platform for publishing original articles. Includes an administrator panel for creating and managing content, and user accounts for browsing and commenting on published articles.

## Running with Docker

Prerequisites: Docker and Docker Compose installed.

1. Copy the example env file and fill in the required values:

   ```bash
   cp app/.env.example app/.env
   ```

2. Start the app:

   ```bash
   docker compose up
   ```

3. Open [http://localhost](http://localhost) in your browser.
