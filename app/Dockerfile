# Use slim Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Create non-root user — security best practice
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY main.py .

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]