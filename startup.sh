# #!/bin/bash

# # python3 -m venv /home/site/wwwroot/venv

# # Extraire les fichiers du déploiement si nécessaire
# if [ -f "/home/site/wwwroot/output.tar.gz" ]; then
#     echo "Extraction de output.tar.gz..."
#     tar -xvf /home/site/wwwroot/output.tar.gz -C /home/site/wwwroot/
# fi

# cd /home/site/wwwroot

# # Vérifier si l'environnement est Windows ou Linux/Mac
# if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
#     # Si c'est Linux/Mac, activer l'environnement virtuel (Linux/Mac)
#     source antenv/bin/activate
# elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
#     # Si c'est Windows, activer l'environnement virtuel avec activate.ps1 (PowerShell)
#     source antenv/Scripts/activate
# fi

# # Vérification de l'environnement virtuel
# echo "Environnement virtuel activé : $(which python)"

# pip install -r requirements.txt

# # Démarrer l'application FastAPI
# streamlit run streamlit_app.py --server.port=8000 --server.address=0.0.0.0

#!/bin/bash

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

echo "Installation des dépendances..."
pip install --user -r /home/site/wwwroot/requirements.txt

echo "Démarrage de Streamlit..."
streamlit run /home/site/wwwroot/streamlit_app.py --server.port=8000 --server.address=0.0.0.0
