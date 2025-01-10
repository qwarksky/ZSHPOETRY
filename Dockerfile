## Debian slim
## Pyenv/Poetry
## Python 3.13
## Venv créer depuis pyproject.toml
## pandas, polars,numpy,seaborn,matplotlib,ipykerne,ipython, notebook,scikit-learn,scipy

FROM debian:12.8-slim
LABEL maintainer="Ezio Qwarksky"

## VARS ENVS
ENV HOME=/root
ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"

## Install Package Debian de base
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    vim \
    neovim \
    nano \
    man \
    zsh \
    tmux \
    curl \
    git \
    pipx \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/apt/archives/* \
 && chsh -s $(which zsh) \
 && pipx install poetry \
 && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
 && curl -fsSL https://pyenv.run | bash \
 && mkdir $HOME/PROJECTS $HOME/PROJECTS/pyproject

## Poetry toml copy
COPY pyproject.toml $HOME/PROJECTS/pyproject

WORKDIR $HOME/PROJECTS/pyproject

VOLUME $HOME/PROJECTS

## Poetry Projects
RUN pyenv install 3.13 \
 && pyenv local 3.13 \
 && poetry install --dry-run \
 && poetry env use $(pyenv which python) \
 && poetry update --sync
