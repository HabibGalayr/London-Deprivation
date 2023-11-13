#-----Section 01-------------------------------------------

# Set working directory
setwd(dirname(file.choose()))
getwd()

# load libraries
install.packages("sf")
install.packages("tmap")
library(sf)
library(tmap)


#-----Section 02-------------------------------------------

# Read in the shapefile of london_polygon
london.polygon <- st_read("london_polygon.shp", quiet = TRUE)
plot(london.polygon$geometry, border = "black", col = "lightgrey")

# Read in the shapefile of london_point
thames <- st_read("thames.shp", quiet = TRUE)
plot(thames$geometry, add = TRUE, border = "blue", col = "lightblue")

# Read in the shapefile of thames
london.point <- sf::st_read("london_point.shp", quiet = TRUE)
plot(london.point, add=TRUE, pch=16, col="yellow", cex=0.5)

colnames(london.polygon)
names(london.point)


#-----Section 03-------------------------------------------

# Draw the map polygons
tmap_mode("plot")

tm_shape(london.polygon)+
  tm_fill("DEPRIV", 
          n= 5, 
          style = "quantile", 
          palette = "Oranges", 
          legend.hist = TRUE, 
          legend.is.portrait = TRUE,
          legend.hist.z = 0.1
  ) +
  tm_shape(thames) +
  tm_fill(col = "lightblue") +
  tm_layout(title = "Deprivation Levels in London Boroughs",
            title.position = c("center","top"),
            title.color = "black",
            title.size = 1.5,
            legend.height = 0.35, 
            legend.width = 0.35,
            legend.outside = FALSE,
            legend.position = c("left", "bottom"),
            frame = FALSE) +
  tm_borders(alpha = 0.5) +
  tm_compass(position = c("right", "top")) +
  tm_scale_bar(position = c("right", "bottom"))


#-----Section 04-------------------------------------------

# Summarise point values
summary(london.point)

# Draw the map points
# scale values need to be adjusted for the size of point

tm_shape(london.polygon)+
  tm_fill("DEPRIV", 
          n= 5, 
          style = "quantile", 
          palette = "Oranges", 
          legend.hist = TRUE, 
          legend.is.portrait = TRUE,
          legend.hist.z = 0.1
  ) +
  tm_shape(thames) +
  tm_fill(col = "lightblue") +
  tm_layout(title = "Deprivation Levels & Life Expectancy for Males in London",
            title.position = c("center","top"),
            title.color = "black",
            title.size = 1.5,
            legend.height = 0.35, 
            legend.width = 0.35,
            legend.outside = FALSE,
            legend.position = c("left", "bottom"),
            frame = FALSE) +
  tm_borders(alpha = 0.5) +
  tm_compass(position = c("right", "top")) +
  tm_scale_bar(position = c("right", "bottom")) +
  tm_shape(london.point) +
  tm_dots(col = "lightgreen", shape = 20, size = 1,
          scale = (london.point$LIFE_MALE-74)/2)


#-----Section 05-------------------------------------------

rm (list=ls())

