FROM python:3.9

WORKDIR /app

COPY ./src /app/src

RUN pip install -r "/app/src/requirements.txt"

CMD ["python", "src/main.py"]

