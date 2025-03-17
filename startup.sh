#!/bin/bash

echo "➡️  Activation de l'environnement virtuel..."
if [ -d "/home/site/wwwroot/venv" ]; then
    source /home/site/wwwroot/venv/bin/activate
else
    echo "⚠️  Environnement virtuel non trouvé ! Création..."
    python3 -m venv /home/site/wwwroot/venv
    source /home/site/wwwroot/venv/bin/activate
    echo "✅  Environnement virtuel créé."
fi

echo "➡️  Vérification de Python et pip..."
which python
python --version
which pip
pip --version

echo "➡️  Installation des dépendances..."
pip install -r /home/site/wwwroot/requirements.txt

echo "✅  Lancement de Streamlit sur le port 8501..."
PORT=${PORT:-8501}
streamlit run /home/site/wwwroot/streamlit_app.py --server.port=$PORT --server.address=0.0.0.0
