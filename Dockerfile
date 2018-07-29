FROM jupyter/scipy-notebook

RUN $CONDA_DIR/bin/conda update --all -y

RUN $CONDA_DIR/bin/pip install -U \
    environment_kernels \
    nbgrader

RUN $CONDA_DIR/bin/jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN $CONDA_DIR/bin/jupyter nbextension enable --sys-prefix --py nbgrader
RUN $CONDA_DIR/bin/jupyter serverextension enable --sys-prefix --py nbgrader
RUN $CONDA_DIR/bin/jupyter nbextension disable --sys-prefix create_assignment/main
RUN $CONDA_DIR/bin/jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader

ADD nbgrader_config.py /etc/jupyter/
ADD jupyter_notebook_config.py /etc/jupyter/env_kernels.py
RUN cat /etc/jupyter/env_kernels.py >> /etc/jupyter/jupyter_notebook_config.py

RUN $CONDA_DIR/bin/conda update --all
RUN $CONDA_DIR/bin/pip install -U jupyterlab ipywidgets 
RUN $CONDA_DIR/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN $CONDA_DIR/bin/conda install bqplot
