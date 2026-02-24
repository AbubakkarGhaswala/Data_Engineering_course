# Get Python from offical Python image
FROM python:3.10-slim

# folder inside docker container
WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# if we want to run the code we need to have that code so we are copying that 
COPY app.py .

EXPOSE 5000

# we need to run this code which we have copied 
CMD ["python", "app.py"]