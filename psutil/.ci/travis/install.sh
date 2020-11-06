#!/bin/bash

set -e
set -x

uname -a
python -c "import sys; print(sys.version)"

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    case "${PYVER}" in
        py27)
            pyenv install 2.7.16
            pyenv virtualenv 2.7.16 psutil
            ;;
        py36)
            pyenv install 3.6.6
            pyenv virtualenv 3.6.6 psutil
            ;;
        py37)
            pyenv install 3.7.6
            pyenv virtualenv 3.7.6 psutil
            ;;
        py38)
            pyenv install 3.8.5
            pyenv virtualenv 3.8.5 psutil
            ;;
    esac
    pyenv rehash
    pyenv activate psutil
fi

if [[ $TRAVIS_PYTHON_VERSION == '2.7' ]] || [[ $PYVER == 'py27' ]]; then
    pip install -U ipaddress mock unittest2
fi

pip install -U coverage coveralls flake8 setuptools
