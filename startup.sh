#!/bin/bash

python3 -m venv /home/site/wwwroot/venv

# Vérifier si l'environnement est Windows ou Linux/Mac
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    # Si c'est Linux/Mac, activer l'environnement virtuel (Linux/Mac)
    source /home/site/wwwroot/venv/bin/activate
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Si c'est Windows, activer l'environnement virtuel avec activate.ps1 (PowerShell)
    source /home/site/wwwroot/venv/Scripts/activate
fi

# Vérification de l'environnement virtuel
echo "Environnement virtuel activé : $(which python3)"

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
export PORT=8501
echo "🔍 [DEBUG] PORT is set to $PORT" >> /home/site/wwwroot/startup.log
echo "🔍 [DEBUG] Starting Streamlit..." >> /home/site/wwwroot/startup.log
python3 -m streamlit run /home/site/wwwroot/streamlit_app.py --server.port=$PORT --server.address=0.0.0.0 >> /home/site/wwwroot/startup.log 2>&1
