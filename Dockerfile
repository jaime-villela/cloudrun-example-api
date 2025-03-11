# syntax=docker/dockerfile:1

FROM python:3.12.0-slim

# Set environment variables
ENV POETRY_VERSION=2.1.1 \
    PORT=5000

# Install Poetry
RUN pip install "poetry==$POETRY_VERSION"

# Set the working directory
WORKDIR /code

# Copy the poetry files
COPY pyproject.toml poetry.lock /code/

# Project initialization
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root

    # Copy the rest of the code
COPY app.py /code/

# Expose the port
CMD gunicorn app:app -w 2 --threads 2 -b 0.0.0.0:${PORT}