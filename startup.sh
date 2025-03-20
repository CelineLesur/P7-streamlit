#!/bin/bash

rm -rf /tmp/*

echo "🔍 [DEBUG] Locating python3..." >> /home/site/wwwroot/startup.log
PYTHON_PATH=$(which python3)
echo "🔍 [DEBUG] Python3 found at $PYTHON_PATH"  >> /home/site/wwwroot/startup.log

if [ -z "$PYTHON_PATH" ]; then
    echo "❗ [ERROR] Python3 not found. Exiting." >> /home/site/wwwroot/startup.log
    exit 1
fi

# Créer un environnement virtuel si nécessaire
if [ ! -d "/home/site/wwwroot/venv" ]; then
    echo "🔍 [DEBUG] Creating virtual environment using virtualenv..." >> /home/site/wwwroot/startup.log
    $PYTHON_PATH -m virtualenv /home/site/wwwroot/venv --always-copy
else
    echo "🔍 [DEBUG] Virtual environment already exists." >> /home/site/wwwroot/startup.log
fi

echo "🔍 [DEBUG] Activation of venv ..." >> /home/site/wwwroot/startup.log
source /home/site/wwwroot/venv/bin/activate >> /home/site/wwwroot/startup.log 2>&1

# Vérification de l'environnement virtuel
echo "Environnement virtuel activé : $(which python3)"
python --version

export PORT=8501

echo "🔍 [DEBUG] PORT is set to $PORT" >> /home/site/wwwroot/startup.log
echo "🔍 [DEBUG] Installing dependencies..." >> /home/site/wwwroot/startup.log
pip install --upgrade pip >> /home/site/wwwroot/startup.log 2>&1
pip install -r /home/site/wwwroot/requirements.txt >> /home/site/wwwroot/startup.log 2>&1

echo "🔍 [DEBUG] Starting Streamlit..." >> /home/site/wwwroot/startup.log
/home/site/wwwroot/venv/bin/python3 -m streamlit run /home/site/wwwroot/streamlit_app.py --server.port=$PORT --server.address=0.0.0.0 >> /home/site/wwwroot/startup.log 2>&1
