#!/bin/bash

which python3

echo "Vérification de pip..."
if ! command -v pip3 &> /dev/null; then
    echo "pip non trouvé, installation en cours..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    export PATH=$HOME/.local/bin:$PATH
    echo "pip installé avec succès."
else
    echo "pip est déjà installé."
fi

which pip3

echo "➡️  Installation des dépendances..."
pip3 install --no-cache-dir -r /home/site/wwwroot/requirements.txt

echo "✅  Lancement de Streamlit sur le port 8501..."
# streamlit run /home/site/wwwroot/streamlit_app.py --server.port=${PORT} --server.address=0.0.0.0 > /home/site/wwwroot/logs.txt 2>&1 &
export STREAMLIT_PORT=8501
python3 -m streamlit run /home/site/wwwroot/streamlit_app.py --server.port=8501 --server.address=0.0.0.0
