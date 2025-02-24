# Introduction to geospatial data analysis in R - Worksheet

#### Explore a vector dataset ####

library(sf)

# Load MRC data
mrc <- ...


# Display vector layer
plot(...)

plot(..., axes = TRUE)


# Select subsets of rows or columns
mrc[, ]


#### Exercise 1 ####

# Select the MRCs in the Bas-St-Laurent (*reg_id*: 01) and Gaspesie (*reg_id*: 11) 
# regions, then display their 2016 population on a map.  

# Hint: The operator %in% can check if a variable has one value within a set, 
# for example x %in% c(1, 3) returns TRUE if x is equal to 1 or 3.




# Integration with the dplyr package 
library(dplyr)

# Name and population for MRCs with population over 200,000
filter(...) %>%
    select(...)


# Sum population by region
regions <- group_by(...) %>%
    summarize(...)

plot(...)


# Create a spatial object from a data frame

plots <- read.csv("data/plots_rgeo.csv")

plots <- st_as_sf(plots, ...)

plot(...)


#### Coordinate reference systems and transformations ####

mrc_proj <- ...(mrc, ...)

plot(mrc_proj["geometry"], axes = TRUE)

# Add graticule
plot(mrc_proj["geometry"], axes = TRUE, ...)


#### Customize maps with ggplot2 ####

library(ggplot2)

# Bar chart of forest inventory plots by height class and cover type 
ggplot(data = ..., aes(... = height_cls, ... = cover_type)) + 
    ...() +
    labs(title = "Forest inventory plots", x = "Height class", 
         y = "Count", fill = "Cover type")

# Simple map
ggplot(...) +
    ...()

# Multiple layers
theme_set(theme_bw())
ggplot() +
    geom_sf(data = ...) +
    geom_sf(data = ..., aes(...), size = 1)

# Change coordinate systems
ggplot(data = plots) +
    geom_sf() +
    ...

# Add labels, select section of map
ggplot(data = regions) +
    geom_sf(aes(fill = pop2016)) +
    geom_sf_label(aes(...)) +
    coord_sf(...)


#### Exercise 2 ####

# Create a map of the MRCs with different fill colors for each region.




#### Geometric operations on vector data ####

areas <- ...

# Change units
units(areas) <- ...

# Which plots and MRCs intersect?
inters <- ...

# Spatial join
plots_mrc <- ...

mrc_01_11 <- mrc[...]
plots_01_11 <- ...


# Show on map
ggplot() +
    geom_sf(data = mrc_01_11) +
    geom_sf(data = plots_01_11)


#### Exercise 3 ####

# The shapefile "data/tbe2016_gaspe.shp" contains a map of areas defoliated
# by the spruce budworm in the Bas-St-Laurent and Gaspesie regions in 2016. 
# The defoliation level is represented by an integer: 
#   1 = Light, 2 = Moderate and 3 = Severe.

# a) How many forest inventory plots in these regions are affected 
#    at each defoliation level? 
# Hint: The `table` function could be useful to get counts of each value in a column.



# b) Plot the defoliated areas located in the MRC of Kamouraska, along with the MRC border.




# Create a buffer around points

plots_proj <- st_transform(plots_01_11, crs = 6622)

plots_buffer <- ...

ggplot() +
    geom_sf(data = plots_buffer, linetype = "dotted", fill = NA) +
    geom_sf(data = plots_proj)

# Negative distance buffer
mrc_01_11_proj <- st_transform(mrc_01_11, crs = 6622)
mrc_buffer <- st_buffer(mrc_01_11_proj, ...)

ggplot() +
    geom_sf(data = mrc_buffer, linetype = "dotted", fill = NA) +
    geom_sf(data = mrc_01_11_proj, fill = NA)


# Union of polygons

buffer_union <- ...

ggplot(buffer_union) +
    geom_sf()

# Difference

mrc_edge <- ...

ggplot(mrc_edge) +
    geom_sf()


#### Raster datasets ####

library(stars)

# Load a raster
cdem <- ...("data/cdem_022BC_3s.tif")


# Plot a raster

plot(...)

ggplot() +
    geom_stars(...) +
    geom_sf(...) +
    scale_fill_viridis_c() +
    coord_sf(xlim = c(-70, -66), ylim = c(48, 49))


# Raster operations

# Crop by coordinate values
cdem_part <- filter(...)

# Crop by polygon (MRC of La Mitis)

mitis <- ...

mitis <- st_transform(mitis, ...)

cdem_mitis <- ...


# Raster math
cdem_km <- ...

cdem_500 <- ...


#### Exercise 4 ####

# a) Show on a map where the elevation is between 5 and 100 m 
#    in the MRC of La Mitis. 



# b) What is the highest elevation in that MRC?




#### Extract values from raster at points ####

library(raster)

# Convert from stars to raster format
cdem_r <- as(cdem, "Raster") 

plots_elev <- ...


#### Interactive maps with mapview ####

library(mapview)

mapview(...)