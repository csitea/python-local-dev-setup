#!/bin/bash
set -x;

cd ./src/python


curl -sSL https://install.python-poetry.org | python3 -
sudo ln -sfn "$HOME/.local/bin/poetry" /usr/bin/poetry
sudo chmod 700 /usr/bin/poetry
sudo chmod 775 $HOME/.bashrc
echo "source $HOME/.local/share/pypoetry/venv/bin/activate" >> $HOME/.bashrc

poetry init -n

echo "Finished python setup and activated the virtual environment."
echo "To install packages you can type poetry add <package-name>"

trap : TERM INT; sleep infinity & wait