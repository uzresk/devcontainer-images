FROM python:3.12
USER root

RUN apt-get update && \
    apt-get -y install --reinstall ca-certificates && \
    apt-get -y install software-properties-common && \
    pip install --upgrade pip

# Install Basic Packages
#RUN pip install ipykernel jupyter
RUN pip install pyyaml==6.0.1 openpyxl==3.1.2 pandas==2.1.4
