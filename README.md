# Touski

## Description

Touski est une application mobile multiplateforme développée en Flutter, actuellement en cours de finalisation. Ce projet personnel s’inscrit dans une démarche d’apprentissage et d’exploration autour de l’intégration de modèles d’intelligence artificielle directement sur appareil mobile, sans dépendre d’un serveur externe.

L’application reprend et adapte le concept initial de FruitAppKotlin, en y intégrant un modèle de vision par ordinateur capable de détecter ou classifier des objets à partir d’images, entièrement en local.

Touski est compatible avec les plateformes iOS et Android.

---

## Objectif

L’objectif principal du projet est de concevoir une application mobile capable d’exécuter un modèle d’intelligence artificielle intégré, sans nécéssiter l'appel à un serveur distant.

---

## Technologies utilisées

### Développement mobile
- Dart
- Flutter

### Intelligence artificielle et machine learning
- YOLOv8 (Ultralytics)
- PyTorch
- Conversion du modèle vers TensorFlow Lite

### Intégration mobile du modèle
- TensorFlow Lite
- tflite_flutter

### Préparation des données
- LabelImg (annotation du dataset)

---

## État du projet

Projet en cours de finalisation.

Certaines fonctionnalités et optimisations sont encore en développement, notamment au niveau des performances et de l’expérience utilisateur.

---
## Installation

### iOS

L’application peut être installée sur un appareil iOS en utilisant Sideloadly.

1. Télécharger et installer Sideloadly sur votre ordinateur  
2. Connecter l’iPhone en USB  
3. Sélectionner le fichier `app-release.ipa`  
4. Fournir un identifiant Apple pour la signature  
5. Installer l’application sur l’appareil  

Un mode développeur doit être activé sur l’iPhone pour autoriser l’installation.

---

### Android

L’application peut être installée sur Android via Android Studio ou directement avec l’APK.

#### Option 1 — Android Studio

1. Ouvrir le projet dans Android Studio  
2. Connecter un appareil Android ou lancer un émulateur  
3. Exécuter l’application  

#### Option 2 — Installation directe

1. Transférer le fichier `app-release.apk` sur l’appareil  
2. Autoriser les sources inconnues si nécessaire  
3. Installer l’application  
