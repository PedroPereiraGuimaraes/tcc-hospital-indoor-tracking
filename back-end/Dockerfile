FROM python:3.9

WORKDIR /api

COPY ./src /api/src

RUN pip install -r "/api/src/requirements.txt"

CMD ["python", "src/main.py"]

