## ----setup, include=FALSE, message=FALSE------------------
library(rmarkdown)
options(continue=" ")
options(width=60)
library(knitr)


## ----message=FALSE----------------------------------------
library(hydroMap)
library(dataRetrieval)
sites <- c("01491000", "01573000", "01576000","01137500","06485500")

siteInfo <- readNWISsite(sites)
plotWSB(sites)
points(siteInfo$dec_long_va, siteInfo$dec_lat_va, pch=20, col="red", cex=1)
box()


## ----message=FALSE----------------------------------------
library(leaflet)
basins <- getBasin(sites)
leaflet() %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  setView(-93.65, 42.0285, zoom = 4) %>%
  addPolygons(data=basins, weight=2) %>%
  addCircleMarkers(siteInfo$dec_long_va,siteInfo$dec_lat_va,
                   color = "red",
                   radius=3,
                   stroke=FALSE,
                   fillOpacity = 0.8, opacity = 0.8,
                   popup=siteInfo$station_nm)


