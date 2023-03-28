FROM python:3.10.10-slim

ENV POETRY_VERSION=1.4.1
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /opt
COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false \
    && poetry install --no-root

COPY . .

ENTRYPOINT ["bash", "entrypoint.sh"]

EXPOSE 8000

CMD ["gunicorn", "todolist.wsgi", "-w", "4", "-b", "0.0.0.0:8000"]


