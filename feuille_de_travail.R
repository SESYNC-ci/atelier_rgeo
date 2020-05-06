# Introduction au traitement des données géospatiales avec R - Feuille de travail

#### Explorer un jeu de données vectoriel ####

library(sf)

# Charger les données des MRC
mrc <- ...


# Afficher des données vectorielles
plot(...)

plot(..., axes = TRUE)


# Choisir des rangées et colonnes
mrc[, ]


#### Exercice 1 ####

# Choisissez les MRC de la région du Bas-St-Laurent (reg_id: 01) et de 
# la Gaspésie (reg_id: 11), puis affichez leur population de 2016 sur une carte.

# Indice: L'opérateur `%in%` permet de vérifier si une variable prend une valeur 
# parmi une liste. Par exemple, `x %in% c(1, 3)` est égal à TRUE si *x = 1* ou *x = 3*.




# Intégration avec dplyr
library(dplyr)

# Nom et population pour les MRCs avec une population > 200 000
filter(...) %>%
    select(...)


# Somme de la population par région
regions <- group_by(...) %>%
    summarize(...)

plot(...)


# Créer un objet spatial à partir d'un data.frame

plots <- read.csv("data/plots.csv")

plots <- st_as_sf(plots, ...)

plot(...)


#### Systèmes de coordonnées et transformations ####

mrc_proj <- ...(mrc, ...)

plot(mrc_proj["geometry"], axes = TRUE)

# Ajouter les méridiens et parallèles
plot(mrc_proj["geometry"], axes = TRUE, ...)


#### Cartes détaillées avec ggplot2 ####

library(ggplot2)

# Graphique à barres des placettes d'inventaire par classe de hauteur et couvert 
ggplot(data = ..., aes(... = height_cls, ... = cover_type)) + 
    ...() +
    labs(title = "Forest inventory plots", x = "Height class", 
         y = "Count", fill = "Cover type")

# Carte simple
ggplot(...) +
    ...()

# Plusieurs couches
theme_set(theme_bw())
ggplot() +
    geom_sf(data = ...) +
    geom_sf(data = ..., aes(...), size = 1) +

# Changer de système de coordonnées
ggplot(data = plots) +
    geom_sf() +
    ...

# Annoter et zoomer sur une partie de la carte
ggplot(data = regions) +
    geom_sf(aes(fill = pop2016)) +
    geom_sf_label(aes(...)) +
    coord_sf(...)


#### Exercice 2 ####

# Créez une carte des MRC avec des couleurs de remplissage différentes
# pour chaque région.




#### Opérations géométriques sur les données vectorielles ####

areas <- ...

# Changement d'unités
units(areas) <- ...

# Quelles placettes et MRCs intersectent?
inters <- ...

# Jointure spatiale
plots_mrc <- ...

mrc_01_11 <- mrc[...]
plots_01_11 <- ...


# Afficher sur une carte
ggplot() +
    geom_sf(data = mrc_01_11) +
    geom_sf(data = plots_01_11)


#### Exercice 3 ####

# Le fichier "data/tbe2016_gaspe.shp" contient une carte des régions défoliées
# par la tordeuse des bourgeons de l'épinette au Bas-St-Laurent et en Gaspésie en 2016.
# Le niveau de défoliation est représenté par un entier: 
# 1 = léger, 2 = modéré et 3 = sévère.

# a) Combien de placettes dans ces régions sont affectées à chaque niveau de défoliation? 

# Indice: La fonction `table` est utile pour compter les effectifs de chaque valeur 
# dans une colonne. 




# b) Produisez une carte des régions défoliées situées dans la MRC de Kamouraska, 
#    avec les limites de la MRC.





# Créer une zone tampon autour de points

plots_proj <- st_transform(plots_01_11, crs = 6622)

plots_buffer <- ...

ggplot() +
    geom_sf(data = plots_buffer, linetype = "dotted", fill = NA) +
    geom_sf(data = plots_proj)

# Distance tampon négative
mrc_01_11_proj <- st_transform(mrc_01_11, crs = 6622)
mrc_buffer <- st_buffer(mrc_01_11_proj, ...)

ggplot() +
    geom_sf(data = mrc_buffer, linetype = "dotted", fill = NA) +
    geom_sf(data = mrc_01_11_proj, fill = NA)


# Union de polygones

buffer_union <- ...


# Différence

mrc_edge <- ...

ggplot(mrc_edge) +
    geom_sf()


#### Données matricielles ####

library(stars)

# Charger un raster
cdem <- ...("data/cdem_022BC_3s.tif")


# Afficher sur une carte

plot(...)

ggplot() +
    geom_stars(...) +
    geom_sf(...) +
    scale_fill_viridis_c() +
    coord_sf(xlim = c(-70, -66), ylim = c(48, 49))


# Opérations matricielles

# Découper en fonction de coordonnées
cdem_part <- filter(...)

# Découper à partir d'un polygone (MRC de La Mitis)

mitis <- ...

mitis <- st_transform(mitis, ...)

cdem_mitis <- ...


# Opérations mathématiques
cdem_km <- ...

cdem_500 <- ...


#### Exercice 4 ####

# a) Affichez une carte montrant à quels endroits l'élévation est 
#    entre 5 et 100 m dans la MRC de La Mitis.

# b) Quel est la plus grande valeur d'élévation dans cette MRC?




#### Extraire des valeurs à partir de points ####

library(raster)

# Convertir du format stars au format Raster
cdem_r <- as(cdem, "Raster") 

plots_elev <- ...


#### Cartes interactives avec mapview ####

library(mapview)

mapview(...)