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
L'application Shiny analyse les prix des carburants pour automobiles en France pour l'année 2022. Les données ont été collectées de sources officielles et présentent une vue détaillée des tendances des prix des carburants, de la densité des stations-service et des variations régionales des prix.

### DETAILS TECHNIQUES (R)
Le projet utilise des données au format CSV et GeoJSON. Les visualisations comprennent des cartes interactives, des graphiques linéaires, et des histogrammes, réalisés avec les packages R comme `ggplot2`, `leaflet`, `dplyr`, et `sf`.

### CONCLUSIONS GÉNÉRALES
L'application révèle des tendances significatives dans les prix des carburants et leur distribution géographique en France. Ces informations sont précieuses pour comprendre les dynamiques du marché des carburants et les influences socio-économiques.

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
