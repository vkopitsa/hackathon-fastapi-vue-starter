FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y libpq-dev git tree gcc build-essential --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Disable pip version check and set Python unbuffered environment variable
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1

# Create and switch to a non-root user
RUN useradd -m -u 1000 python
USER python

ENV PATH="/home/python/.local/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the requirements files
COPY ./requirements.txt .
COPY ./requirements-dev.txt .

# Install Python dependencies
ARG INSTALL_DEV=false
RUN if [ "$INSTALL_DEV" = "true" ]; then \
        pip install --no-cache-dir -r requirements-dev.txt; \
    else \
        pip install --no-cache-dir -r requirements.txt; \
    fi

COPY . /app

# Set the Python path environment variable
ENV PYTHONPATH=/app/

# Command to run the application
CMD ["uvicorn", "--workers", "2", "--backlog", "100", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
