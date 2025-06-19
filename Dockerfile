# Step 1: Base Image
FROM python:3.11-bookworm

# Step 2: Set Working Directory
WORKDIR /app

# Step 3: Install System Dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Step 4: Install Python Dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Copy Application Code
COPY ./app ./app

# Step 6: Expose Port (match app port, not random)
EXPOSE 8000

# Step 7: Run the Server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
