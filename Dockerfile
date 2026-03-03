FROM python:3.9

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install mysqlclient

# Copy full project
COPY . .

# Expose port
EXPOSE 8000

# Start Django properly
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
