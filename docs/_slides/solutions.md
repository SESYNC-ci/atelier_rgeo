---
---

## Solutions {#sol}


### Exercise 1 {#sol1}

Select the MRCs in the Bas-St-Laurent (*reg_id*: 01) and Gaspesie (*reg_id*: 11) regions, then display their 2016 population on a map.



~~~r
> mrc_01_11 <- mrc[mrc$reg_id %in% c("01", "11"), ]
> plot(mrc_01_11["pop2016"], axes = TRUE)
~~~
{:title="Console" .input}
![ ]({% include asset.html path="images/solutions/sol1-1.png" %})
{:.captioned}

[Return to text](#retour1)

===

### Exercise 2 {#sol2}

Create a map of the MRCs with different fill colors for each region.



~~~r
> ggplot(data = mrc_proj, aes(fill = reg_name)) +
+     geom_sf()
~~~
{:title="Console" .input}
![ ]({% include asset.html path="images/solutions/sol2-1.png" %})
{:.captioned}

[Return to text](#retour2)

===

### Exercise 3 {#sol3}

a) How many of the forest inventory plots in these regions are affected at each defoliation level?



~~~r
> defo <- st_read("data/tbe2016_gaspe.shp")
~~~
{:title="Console" .input}


~~~
Reading layer `tbe2016_gaspe' from data source `/nfs/public-data/training/tbe2016_gaspe.shp' using driver `ESRI Shapefile'
Simple feature collection with 3928 features and 2 fields
Geometry type: POLYGON
Dimension:     XY
Bounding box:  xmin: -69.88925 ymin: 47.38829 xmax: -64.66188 ymax: 49.25522
CRS:           4269
~~~
{:.output}


~~~r
> plots_defo <- st_join(plots_01_11, defo)
~~~
{:title="Console" .input}


~~~
although coordinates are longitude/latitude, st_intersects assumes that they are planar
although coordinates are longitude/latitude, st_intersects assumes that they are planar
~~~
{:.output}


~~~r
> table(plots_defo$level)
~~~
{:title="Console" .input}


~~~

 1  2  3 
93 93 90 
~~~
{:.output}


===

b) Plot the defoliated areas located in the MRC of Kamouraska by severity level, also displaying the MRC border.



~~~r
> mrc_kam <- filter(mrc_01_11, mrc_name == "Kamouraska")
> defo_kam <- st_join(defo, mrc_kam, left = FALSE)
~~~
{:title="Console" .input}


~~~
although coordinates are longitude/latitude, st_intersects assumes that they are planar
~~~
{:.output}


~~~r
> ggplot() +
+     geom_sf(data = mrc_kam) +
+     geom_sf(data = defo_kam, color = NA, aes(fill = level))
~~~
{:title="Console" .input}
![ ]({% include asset.html path="images/solutions/sol3b-1.png" %})
{:.captioned}

[Return to text](#retour3)

===

### Exercise 4 {#sol4}

a) Show on a map where the elevation is between 5 and 100 m in the MRC of La Mitis. 



~~~r
> mitis <- filter(mrc_01_11, mrc_name == "La Mitis")
> mitis <- st_transform(mitis, st_crs(cdem))
> 
> cdem_mitis <- st_crop(cdem, mitis)
~~~
{:title="Console" .input}


~~~
although coordinates are longitude/latitude, st_union assumes that they are planar
~~~
{:.output}


~~~
although coordinates are longitude/latitude, st_intersects assumes that they are planar
~~~
{:.output}


~~~r
> plot(cdem_mitis >= 5 & cdem_mitis <= 100)
~~~
{:title="Console" .input}
![ ]({% include asset.html path="images/solutions/sol4a-1.png" %})
{:.captioned}

===

b) What is the highest elevation in that MRC?



~~~r
> cdem_mitis_vals <- cdem_mitis[[1]]
> max(cdem_mitis_vals, na.rm = TRUE)
~~~
{:title="Console" .input}


~~~
[1] 794.4375
~~~
{:.output}


[Return to text](#retour4)
