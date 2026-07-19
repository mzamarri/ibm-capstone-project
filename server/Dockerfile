    FROM python:3.12.0-slim-bookworm

    ENV PYTHONBUFFERED 1
    ENV PYTHONWRITEBYTECODE 1

    ENV APP=/app

    # Change the workdir.
    WORKDIR $APP

    # Install the requirements
    COPY requirements.txt $APP

    RUN pip3 install -r requirements.txt

    # Copy the rest of the files
    COPY ./db.sqlite3 $APP
    COPY ./entrypoint.sh $APP
    COPY manage.py $APP
    COPY ./djangoproj/ $APP/djangoproj/
    COPY ./djangoapp/ $APP/djangoapp/
    COPY ./frontend/build/ $APP/frontend/build/
    COPY ./frontend/static $APP/frontend/static/

    EXPOSE 8000

    RUN chmod +x /app/entrypoint.sh

    ENTRYPOINT ["/bin/bash","/app/entrypoint.sh"]

    CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "djangoproj.wsgi"]
