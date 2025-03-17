#!/bin/bash

rm -rf /tmp/*
rm -rf /home/site/wwwroot/antenv

echo "➡️  Activation de l'environnement virtuel..."
if [ -d "/home/site/wwwroot/venv" ]; then
    python3 -m venv /home/site/wwwroot/venv
fi

source /home/site/wwwroot/venv/bin/activate

echo "➡️  Vérification de Python et pip..."
which python
python --version
which pip
pip --version

echo "➡️  Installation des dépendances..."
pip install -r /home/site/wwwroot/requirements.txt

echo "✅  Lancement de Streamlit sur le port 8501..."

streamlit run /home/site/wwwroot/streamlit_app.py --server.port=8181 --server.address=0.0.0.0
