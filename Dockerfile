# vim:set ft=dockerfile
FROM debian:jessie

# system update
RUN apt-get update \
    && apt-get upgrade -y

# Only installs ansible's minimal required dependencies.

RUN apt-get install -y \
    python-dev \
    python-pip  \
    libffi-dev \
    libssl-dev \
    sudo

# walk-around for the error:
# ImportError: No module named setuptools_ext
RUN pip install --upgrade cffi

RUN pip install \
    ansible \
    setuptools \
    packaging \
    pyparsing \
    appdirs

RUN pip install cryptography==1.5 # required for Ansible 2.4

# Execute ansible playbook(s).

COPY provisioning/ provisioning
RUN ansible-playbook provisioning/site.yml -c local

EXPOSE 5222 5269
