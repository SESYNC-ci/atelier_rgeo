### Worksheet for:
### Introduction to geospatial data analysis in R

#### Explore a vector dataset ####

library(sf)

# Load MRC polygons

mrc <- ...


# Visualize sf data

plot(...)

plot(..., axes = TRUE)


#### Exercise 1 ####

### Produce a map with MRCs colored by administrative region, 
### e.g.: Nord-du-Québec, Côte-Nord, etc.





# Create a sf object from a data.frame

uqat <- data.frame(nom = "UQAT", long = -79.0086, lat = 48.2306)

uqat <- st_as_sf(..., coords = ..., crs = ...)


# In which MRC is UQAT located?

st_within(..., ...)


# Overlap multiple datasets on a map

plot(mrc[, "geometry"], ..., axes = TRUE)

plot(uqat, ..., pch = 20, col = "red")


#### Coordinate systems ####

# Coordinate transformation

mrc_proj <- st_transform(...)

uqat_proj <- ...


plot(..., axes = TRUE)


# Map with longitude and latitude lines

plot(mrc_proj[, "geometry"], axes = TRUE, reset = FALSE, 
     ...)

plot(uqat_proj, add = TRUE, pch = 20, col = "red")


#### Geometric operations on vector data ####

# Create a buffer zone

rayon <- st_buffer(..., dist = ...)

plot(..., add = TRUE, border = "blue")


#### Exercise 2 ####

# The `st_intersection(A, B)` function returns the intersection of two vector 
# datasets `A` and `B`, that is, the areas where objects in each dataset overlap. 
# 
# Using this function, determine how many MRCs are located within 100 km of 
# the point `uqat`, and try to show on a map representing this circular area.




# Union of polygons

poly_union <- ...


# Difference of polygons

poly_diff <- st_difference(..., ...)

plot(poly_diff[, "geometry"])


#### Defoliation due to the forest tent caterpillar ####

# Read data and select polygons for the year 2017

livree <- st_read("livree/Livree_2014_2017.shp")

livree2017 <- livree[..., ]


#### Exercise 3 ####

# 1. Determine the total area (in hectares) defoliated by the forest tent
#    caterpillar in the MRC of Rouyn-Noranda.
# 2. Produce a map of the defoliated areas with their intensity level for that MRC.

# Suggested steps:
#  - Extract the Rouyn-Noranda MRC from the `mrc` dataset.
#  - Extract data from `livree2017` located within the MRC. 
#  Before applying spatial comparison operators, make sure the datasets 
#  have comparable coordinates. It is fine to work in geographic coordinates 
#  (longitude and latitude) for this case.


rn <- ...

livree_rn <- ...

plot(...)




# Defoliation polygons by MRC

livree_mrc <- ...

# Defoliated area by intensity level in Rouyn-Noranda

aggregate(..., data = livree_rn, ...)


#### Thematic maps with tmap ####

library(tmap)

# Map of defoliation polygons

tm_shape(...) +
    ...

# With MRC boundaries and names

tm_shape(mrc) +
    tm_polygons() +
    tm_text(...) +
tm_shape(livree_mrc) +
    ...("Niveau") +
    ...("MRS_NM_REG")


#### Raster data: Canadian Digital Elevation Model ####

# Read the index

cdem_index <- ...("cdem/cdem_index_250k.kml", stringsAsFactors = FALSE)

# Find which CDEM sections cover the MRC of Rouyn-Noranda

cdem_index <- st_transform(cdem_index, ...)

cdem_rn <- ...


#### Working with raster data ####

# Read data

library(raster)

cdem32D <- ...

# Visualize raster data

hist(cdem32D)

plot(cdem32D)

# Add a vector layer

plot(...)


# Combine two sections of the CDEM

cdem31M <- ...

cdem <- ...


# Crop the extent of a raster

cdem <- crop(...)

plot(cdem)

plot(...)


#### Exercise 4 ####

# From `cdem`, produce 
#  (a) a map where elevation is represented in km rather than meters and 
#  (b) a map indicating areas of elevation under 300 m.





# Masking data

plot(mask(cdem, ..., maskvalue = ...))


# Reduce the resolution of a raster

cdem_agg <- aggregate(cdem, ..., ...)


#### Extract raster variables based on vector layers ####

# Extract the value for a point

extract(..., ...)

# Extract using polygons

poly_ext <- extract(..., ...)


# Mean value per polygon

moy_cdem <- extract(cdem, ..., fun = ...)

livree_rn$cdem <- ...


# Elevation by intensity level

boxplot(...)


#### Interactive maps with mapview ####

library(mapview)

mapview(...)