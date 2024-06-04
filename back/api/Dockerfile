FROM python:3.9

WORKDIR /app

COPY ./src /app/src
COPY main.py .

RUN pip install -r "/app/src/requirements.txt"

CMD ["python", "main.py"]

