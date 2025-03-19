#!/bin/bash

python3 -m venv /home/site/wwwroot/venv

# Vérifier si l'environnement est Windows ou Linux/Mac
source /home/site/wwwroot/venv/bin/activate

# Vérification de l'environnement virtuel
echo "Environnement virtuel activé : $(which python3)"

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

which pip

export PORT=8501

echo "🔍 [DEBUG] PORT is set to $PORT" >> /home/site/wwwroot/startup.log
echo "🔍 [DEBUG] Installing dependencies..." >> /home/site/wwwroot/startup.log
/opt/python/3/bin/python3 -m pip install --upgrade pip >> /home/site/wwwroot/startup.log 2>&1
/opt/python/3/bin/python3 -m pip install -r /home/site/wwwroot/requirements.txt >> /home/site/wwwroot/startup.log 2>&1

echo "🔍 [DEBUG] Starting Streamlit..." >> /home/site/wwwroot/startup.log
/opt/python/3/bin/python3 -m streamlit run /home/site/wwwroot/streamlit_app.py --server.port=$PORT --server.address=0.0.0.0 >> /home/site/wwwroot/startup.log 2>&1
