# Use a lightweight Python base image
FROM python:3.9-slim-buster as base

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements file to the working directory
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create a new stage for the final image
FROM python:3.9-slim-buster

# Copy the installed dependencies from the base stage
COPY --from=base /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/

# Copy the Python application files to the working directory
COPY app.py .

# Expose the port on which the application will run (default Flask port is 5000)
EXPOSE 5000

# Set the command to run the application
CMD ["python", "app.py"]
