import streamlit as st
import requests

st.title("Prédiction de sentiment d'un tweet avec ModernBERT")

# Appel de l'API FastAPI
response = requests.get("https://webapp-ocr-p7-b2d0cuafdhgyf8fx.canadacentral-01.azurewebsites.net/")  
if response.status_code == 200:
    st.success(f"L'API est fonctionnelle")
else:
    st.error("L'API ne répond pas.")

# Formulaire pour tester un endpoint
user_input = st.text_input("Entrez un texte pour tester l'API:")
if st.button("Envoyer"):
    api_url = "https://webapp-ocr-p7-b2d0cuafdhgyf8fx.canadacentral-01.azurewebsites.net/predict"
    # api_url = "http://127.0.0.1:8000/predict"
    data = {"tweet": user_input}
    res = requests.post(api_url, params=data)

    if res.status_code==200:
        if res.json() == {"prediction":1}:
            st.write('Positif')
        else:
            st.write('Négatif')
    else:
        st.error(f'Erreur {res.status_code} : {res.text}')