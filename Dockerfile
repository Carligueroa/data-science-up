# Start from a core stack version
FROM quay.io/jupyter/datascience-notebook
# FROM quay.io/jupyter/jupyter/scipy-notebook
# FROM quay.io/jupyter/base-notebook

ARG env_name=python310
ARG py_ver=3.10

EXPOSE 8888

# Install in the default python3 environment
RUN pip install --no-cache-dir 'flake8' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install from the requirements.txt file
# COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
# RUN pip install --no-cache-dir --requirement /tmp/requirements.txt && \
    # fix-permissions "${CONDA_DIR}" && \
    # fix-permissions "/home/${NB_USER}"

ENV JUPYTER_ENABLE_LAB=yes

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/
RUN pip install --quiet --no-cache-dir --requirement /tmp/requirements.txt
