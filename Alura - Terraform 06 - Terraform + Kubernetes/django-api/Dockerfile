# docker build . -t producao:v1
FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /home/ubuntu/projeto01

COPY . /home/ubuntu/projeto01/

RUN python -m pip install --upgrade pip \
    && pip install -r requirements.txt \
    && sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*'\]/g" /home/ubuntu/projeto01/setup/settings.py \
    && python manage.py migrate \
    && python manage.py loaddata clientes.json

ENTRYPOINT python manage.py runserver 0.0.0.0:8000
EXPOSE 8000