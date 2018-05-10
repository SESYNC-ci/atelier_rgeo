### Feuille de travail pour l'atelier:
### Introduction à l'analyse de données géospatiales avec R

#### Explorer un jeu de données vectoriel ####

library(sf)

# Charger les polygones des MRC

mrc <- ...


# Visualiser un jeu de données sf

plot(...)

plot(..., axes = TRUE)


#### Exercice 1 ####

### Produisez une carte du jeu de données mrc  
###  coloriée par région administrative, ex.: Nord-du-Québec, Côte-Nord, etc.





# Créer un objet sf à partir d'un data.frame

uqat <- data.frame(nom = "UQAT", long = -79.0086, lat = 48.2306)

uqat <- st_as_sf(..., coords = ..., crs = ...)


# Dans quelle MRC se retrouve le point UQAT?

st_within(..., ...)


# Superposer plusieurs jeux de données sur une carte

plot(mrc[, "geometry"], ..., axes = TRUE)

plot(uqat, ..., pch = 20, col = "red")


#### Systèmes de coordonnées ####

# Transformation de coordonnées

mrc_proj <- st_transform(...)

uqat_proj <- ...


plot(..., axes = TRUE)


# Carte avec lignes de longitude et latitude

plot(mrc_proj[, "geometry"], axes = TRUE, reset = FALSE, 
     ...)

plot(uqat_proj, add = TRUE, pch = 20, col = "red")


#### Opérations géométriques sur les données vectorielles ####

# Créer une zone tampon (buffer)

rayon <- st_buffer(..., dist = ...)

plot(..., add = TRUE, border = "blue")


#### Exercice 2 ####

# La fonction `st_intersection(A, B)` retourne l'intersection de deux jeux de 
# données vectoriels `A` et `B`, c'est-à-dire les régions où leurs objets géométriques
# se superposent. 

# Avec cette fonction, identifiez le nombre de MRC situées dans un rayon de 100km
# du point `uqat`, puis essayez de les indiquer sur une carte représentant ce rayon. 



# Union de polygones

poly_union <- ...


# Différences de polygones

poly_diff <- st_difference(..., ...)

plot(poly_diff[, "geometry"])


#### Défoliation due à la livrée des forêts ####

# Charger les données et choisir les polygones de 2017

livree <- st_read("livree/Livree_2014_2017.shp")

livree2017 <- livree[..., ]


#### Exercice 3 ####

# 1. Déterminer la superficie totale (en hectares) défoliée par la livrée des 
#    forêts sur le territoire de la MRC de Rouyn-Noranda.
# 2. Produire une carte des surfaces défoliées avec leur niveau d'intensité 
#    pour ce territoire.

# Étapes suggérées:
#  - Extraire la MRC de Rouyn-Noranda du jeu de données `mrc`.
#  - Extraire les données de `livree2017` situées dans les limites de la MRC. 
#    Avant d'appliquer des opérateurs de comparaison spatiale, assurez-vous que 
#    les jeux de données soient comparables. Il est correct de travailler en 
#     coordonnées géographiques (longitude et latitude) cette fois-ci.


rn <- ...

livree_rn <- ...

plot(...)




# Polygones de défoliation dans chaque MRC

livree_mrc <- ...

# Aire par classe de défoliation pour Rouyn-Noranda

aggregate(..., data = livree_rn, ...)


#### Cartes thématiques avec tmap ####

library(tmap)

# Carte des polygones de défoliation

tm_shape(...) +
    ...

# Avec limites et noms des MRC

tm_shape(mrc) +
    tm_polygons() +
    tm_text(...) +
tm_shape(livree_mrc) +
    ...("Niveau") +
    ...("MRS_NM_REG")


#### Données matricielles: Modèle d'élévation numérique du Canada ####

# Lire l'index

cdem_index <- ...("cdem/cdem_index_250k.kml", stringsAsFactors = FALSE)

# Déterminer les sections du CDEM recouvrant la MRC de Rouyn-Noranda

cdem_index <- st_transform(cdem_index, ...)

cdem_rn <- ...


#### Traitement des données matricielles avec raster ####

# Charger les données

library(raster)

cdem32D <- ...

# Visualiser les données matricielles

hist(cdem32D)

plot(cdem32D)

# Superposer des données vectorielles

plot(...)


# Combiner deux sections du CDEM

cdem31M <- ...

cdem <- ...


# Réduire l'étendue d'un objet raster

cdem <- crop(...)

plot(cdem)

plot(...)


#### Exercice 4 ####

# À partir de cdem, produisez 
#  (a) une carte où l'altitude est exprimée en kilomètres plutôt qu'en mètres et 
#  (b) une carte où les régions d'altitude inférieure à 300 mètres sont identifiées.




# Masquage des données

plot(mask(cdem, ..., maskvalue = ...))


# Réduire la résolution de données matricielles

cdem_agg <- aggregate(cdem, ..., ...)


#### Extraire des valeurs d'un raster à partir d'objets géométriques ####

# Extraire une valeur pour un point

extract(..., ...)

# Extraire à partir de polygones

poly_ext <- extract(..., ...)


# Valeur moyenne par polygone

moy_cdem <- extract(cdem, ..., fun = ...)

livree_rn$cdem <- ...


# Altitude par classe d'intensité

boxplot(...)


#### Cartes interactives avec mapview ####

library(mapview)

mapview(...)