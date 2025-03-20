#!/bin/bash

rm -rf /tmp/*

opt/python/3/bin/python3 --version

echo "🔍 [DEBUG] Creation of venv ..." >> /home/site/wwwroot/startup.log
opt/python/3/bin/virtualenv /home/site/wwwroot/venv --always-copy >> /home/site/wwwroot/startup.log 2>&1

echo "🔍 [DEBUG] Activation of venv ..." >> /home/site/wwwroot/startup.log
source /home/site/wwwroot/venv/bin/activate >> /home/site/wwwroot/startup.log 2>&1

# Vérification de l'environnement virtuel
echo "Environnement virtuel activé : $(which python3)"
python --version

export PORT=8501

echo "🔍 [DEBUG] PORT is set to $PORT" >> /home/site/wwwroot/startup.log
echo "🔍 [DEBUG] Installing dependencies..." >> /home/site/wwwroot/startup.log
/opt/python/3/bin/python3 -m pip install --upgrade pip >> /home/site/wwwroot/startup.log 2>&1
/opt/python/3/bin/python3 -m pip install -r /home/site/wwwroot/requirements.txt >> /home/site/wwwroot/startup.log 2>&1

echo "🔍 [DEBUG] Starting Streamlit..." >> /home/site/wwwroot/startup.log
/opt/python/3/bin/python3 -m streamlit run /home/site/wwwroot/streamlit_app.py --server.port=$PORT --server.address=0.0.0.0 >> /home/site/wwwroot/startup.log 2>&1
