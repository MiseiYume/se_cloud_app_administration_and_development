FROM python:latest

WORKDIR /webpage

COPY /requirements.txt /webpage/

RUN pip install -r requirements.txt

COPY /PiAAC/static /webpage/cloud
COPY /PiAAC/templates /webpage/templates
COPY /PiAAC/.idea /webpage/.idea
COPY /PiAAC/.github /webpage/.github
COPY /PiAAC/run.py .
COPY /PiAAC/contact.html .
COPY /PiAAC/gallery.html .
COPY /PiAAC/README.md .

EXPOSE 5000

CMD ["python", "./run.py"]