# Python base image 

FROM python:3.9-slim 

 

# Set the working directory inside the container 

WORKDIR /app 

 

# Copy the Python script into the container 

COPY code_1.py . 

 

# Install any necessary dependencies 

RUN pip install pandas matplotlib scikit-learn 

 

# Command to run the Python script when the container starts 

CMD ["python", "code_1.py"] 
