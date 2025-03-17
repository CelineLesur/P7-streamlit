#!/bin/bash

rm -rf /tmp/*
rm -rf /home/site/wwwroot/antenv

echo "Vérification de pip..."
if ! command -v pip &> /dev/null; then
    echo "pip non trouvé, installation en cours..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    export PATH=$HOME/.local/bin:$PATH
    echo "pip installé avec succès."
else
    echo "pip est déjà installé."
fi

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

echo "✅  Lancement de Streamlit sur le port 8181..."
streamlit run /home/site/wwwroot/streamlit_app.py --server.port=8181 --server.address=0.0.0.0 > /home/site/wwwroot/logs.txt 2>&1 &
