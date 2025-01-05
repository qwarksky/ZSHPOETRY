## Debian slim
## Pyenv/Poetry
## Python 3.13
## Venv créer depuis pyproject.toml
## pandas, polars,numpy,seaborn,matplotlib,ipykerne,ipython, notebook,scikit-learn,scipy

FROM debian:stable-slim
LABEL maintainer="Ezio Qwarksky"

## Package Debian de base
RUN apt update && apt full-upgrade -y
RUN apt install -y vim neovim nano man zsh curl git

## Définir le $HOME et utiliser le shell ZSH
ENV HOME=/root
RUN chsh -s /bin/zsh

## Installation de PYENV depuis le git et de POETRY depuis curl
WORKDIR $HOME
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
RUN apt install -y build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
	liblzma-dev
RUN curl -vsSL https://install.python-poetry.org | python3 -
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Définir pyenv comme une commande
ENV PYENV_ROOT=$HOME/.pyenv
ENV pyenv=$PYENV_ROOT/bin
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$HOME/.local/bin:pyenv:$PATH"

## Création avec POETRY d'un venv avec python 3.13
WORKDIR $HOME
RUN mkdir PROJECTS
RUN mkdir PROJECTS/pyproject
COPY pyproject.toml PROJECTS/pyproject

WORKDIR $HOME/PROJECTS/pyproject
RUN pyenv install 3.13
RUN pyenv local 3.13
RUN poetry install --dry-run
RUN poetry env use $(pyenv which python)
RUN poetry update --sync
