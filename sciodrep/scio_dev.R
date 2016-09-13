rm(list = ls())
install.packages(c("rgbif", "raster", "maptools", "XML","rgdal", "dismo", "sqldf",
                   "maps", "testthat", "adehabitatsHS", "roxygen2", "spocc",
                   "rJava", "rworldmap","ggmap"))
library (rgbif) #
library (raster) #OK
library (maptools) 
library (XML) #
library (rgdal) #
library (dismo) #OK
library (sqldf) #OK
library (maps) #OK
library (testthat) #OK
library (adehabitatHS) #OK
library (roxygen2) #OK
library (spocc) #
library (rJava) #OK
library (rworldmap) #OK
newmap = getMap(resolution="low") #function from package rworldmap
install.packages("ggmap")

## SPOCC SEARCH 
scio.gbif= occ (query="Sciodrepoides watsoni", 
                    from="gbif", 
                 gbifopts=list(hasCoordinate=TRUE)
                    ,limit= 5000)

scio.gbif=occ2df(scio.gbif)

coord.gbif = data.frame (long=scio.gbif$longitude,
                          lat=scio.gbif$latitude)


# ## solution for transformation of DMS to decimal degrees
## with celestila packages and function dms2deg
#install.packages("celestial")
library (celestial)

data.sw <- read.csv("Data/sc.watsoni.csv", header=TRUE, sep=";")
str (data.sw)
head (data.sw)
n=length(data.sw$lat)-7
cz.lat = c()
cz.long = c()
for (i in 1:n) {
  cz.lat[i]=dms2deg (as.character (data.sw[i,30]), sep="DMS") #DMS format is still wrong in source
  cz.long[i]=dms2deg (as.character (data.sw[i,31]), sep="DMS")
}

#made a data.frame from my data (they were in right format), Jan's data
#and Gbif data
coord.sc <- data.frame (long=data.sw$long[40:46], lat=data.sw$lat[40:46])
coord.sc2 <- data.frame (long = cz.long, lat = cz.lat)
coord.full <- rbind (coord.sc2, coord.sc)
coord <- rbind (coord.full, coord.gbif)
str (coord)
coord.long <- as.numeric (coord$long)
coord.lat <- as.numeric (coord$lat)
coord.unfiltered <- cbind (coord.long, coord.lat)

# X11()
# plot (newmap, xlim=c(-10,55), ylim=c(40,65))
# points (coord.unfiltered, col="blue", pch=16)

#map of s. watsoni occurence in Europe
library(ggmap)
map=get_map (location="Europe", zoom=4)
?"ggmap"
coord.unfiltered = data.frame (coord.unfiltered)

tiff (filename="exports/sciodrepoides_occurence.tiff", 
      width=2000, height=2000, 
      compression="lzw", res= 300)
sciod.occur=  ggmap(map)+
  geom_point (aes (x= coord.long, y = coord.lat), data = coord.unfiltered, alpha = 0.5)+
  xlab("")+ 
  ylab("")
dev.off()
