# 1. Use a clean, modern base image
FROM python:3.10-slim-buster

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Install essential Linux build tools needed for sentence-transformers
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy and install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of your application code
COPY . .

# 6. Expose port 8000 for your FastAPI application
EXPOSE 8080

# 7. Start the server using Uvicorn mapped to all network interfaces
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
