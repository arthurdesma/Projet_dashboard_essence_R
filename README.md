# Guide Utilisateur

## Déploiement de l'Application Shiny

1. Assurez-vous d'avoir installé R et les packages nécessaires tels que `shiny`, `readr`, `ggplot2`, `dplyr`, `sf`, `leaflet`, et `tidyverse`.
2. Placez tous les fichiers nécessaires, y compris les données CSV et le fichier GeoJSON, dans un dossier unique.
3. Ouvrez RStudio ou une autre interface R et naviguez jusqu'au dossier contenant les fichiers.
4. Ouvrez le script de l'application Shiny (`app.R` ou un nom similaire) dans RStudio.
5. Exécutez l'application en cliquant sur le bouton "Run App" dans RStudio.
6. L'application s'ouvrira dans une nouvelle fenêtre de navigateur.

### Utilisation de l'Application

- Utilisez le menu déroulant pour sélectionner un type de carburant et voir son prix moyen évoluer dans le temps.
- Explorez les stations de service sur la carte en sélectionnant un type de carburant et un département spécifique.
- Visualisez la densité des stations-service dans différents départements à l'aide de la carte choroplèthe.
- Examinez l'histogramme des prix du carburant pour différents types de carburants.

## Analyse des Données Visualisées

### INTRO
Notre projet a pour sujet le prix des carburants pour automobiles sur l'année 2022(2023 n'étant pas encore terminée). Nous avons récupéré les données sur le site data.gouv.fr. L'émetteur de ces informations est le Ministère de l'Economie, des Finances et de la Souveraineté industrielle et numérique. Nous avons choisi ce domaine d'études car nous voulions choisir un thème qui est présent dans la vie quotidienne de presque tous les français. En effet, aller en station service pour faire le plein et connaître leur localisation ainsi que le prix des différents carburants est quelque chose qui nous concerne tous. 
Notre Dashboard se présente comme une page web qui a pour utilité d'analyser les stations-services en France ainsi que les carburants proposés, leur adresse, les tarifs pratiqués et enfin l’historique des prix sur l’année ainsi que le prix selon lme département où l’on vit. 

### DETAILS TECHNIQUES (R)

#### Fichiers utilisés
Nous utilisons un fichier CSV, "prix-des-carburants-en-france-flux-instantane-v2.csv", et un fichier geojson, "departements.geojson". Le script R traite ces fichiers, convertissant les coordonnées et fusionnant les données pour les analyses.

#### Cartes Interactives avec Shiny
Interactives avec Shiny : Utilisant leaflet en R, nous créons des cartes interactives montrant les emplacements des stations-service et leurs informations, avec un zoom automatique sur le département choisi.

#### Carte de Densité des Stations-Services
Nous affichons la densité des stations-services par département sur une carte choroplèthe, en utilisant leaflet et ggplot2 pour une visualisation améliorée.

#### Graphique des Prix des Carburants
Un graphique classique est généré avec ggplot2, montrant l'évolution des prix des différents carburants au fil de l'année.

#### Heatmap des Prix par Département
Les heatmaps des prix des carburants par département sont créées, avec des couleurs variant du jaune au rouge pour indiquer les variations de prix.

#### Histogramme des Prix des Carburants 
Nous utilisons ggplot2 pour créer un histogramme comparant les prix des différents carburants, en fonction de leur fréquence d'occurrence.

#### Dashboard avec Shiny
Toutes ces visualisations sont intégrées dans un dashboard interactif créé avec Shiny. Ce dashboard permet une navigation facile et des sélections personnalisées de carburant ou de département.

### COMMENTAIRES SUR LES DONNÉES VISUALISÉES (R)

#### Prix du Carburant par Département
Notre projet débute avec une carte interactive et un menu déroulant pour sélectionner le département. Chaque station-service y est indiquée par un "pin", affichant des informations détaillées sur les prix et la dernière mise à jour des carburants disponibles.

#### Densité des Stations-Services
La carte de densité des stations-services montre des variations significatives de densité par département. La corrélation entre la densité des stations-services et la population est évidente, avec des zones plus densément peuplées affichant plus de stations.

#### Evolution des Prix du Carburant
Une analyse temporelle des prix montre une hausse notable en mars 2022 pour tous les carburants, probablement en lien avec la crise ukrainienne. D'autres tendances, comme une baisse en septembre et des hausses en juillet pour certains carburants, sont également observées.

#### Prix Moyen du Carburant par Département (Heatmap)
Les heatmaps des prix moyens révèlent des disparités entre les différents types de carburants. Tandis que certains carburants montrent des prix assez homogènes à travers les départements, d'autres affichent des variations plus marquées.

#### Histogramme des Prix des Carburants
L'histogramme des prix met en évidence la différence de coût entre les carburants, avec l'E85 et le GPLC étant nettement moins chers. Il révèle également les préférences de consommation des Français en matière de carburant.

### Conclusions Générales du Projet
L'ensemble de notre analyse offre un aperçu approfondi des dynamiques du marché des carburants en France. Les outils de visualisation de données, tels que les cartes interactives, les heatmaps et les histogrammes, permettent de comprendre les tendances de prix, la distribution géographique des stations-services, et l'impact d'événements mondiaux sur le marché. Cette étude révèle non seulement les habitudes de consommation de carburant, mais aussi les influences socio-économiques et environnementales qui modèlent le secteur énergétique en France.


# Guide de Développement

## Architecture du Code

L'application est structurée comme suit:

- **UI**: Définit l'interface utilisateur, y compris les inputs et les outputs.
- **Server**: Contient la logique du serveur pour le traitement des données et la génération des visualisations.
- **Data Processing**: Des fonctions pour lire et prétraiter les données CSV et GeoJSON.

### Modification ou Extension du Code

1. Pour ajouter de nouvelles fonctionnalités, créez des fonctions supplémentaires dans le script et intégrez-les dans l'UI ou la logique serveur.
2. Modifiez les visualisations existantes en ajustant les fonctions de tracé dans la section serveur.
3. Testez toutes les modifications localement avant de les déployer.
