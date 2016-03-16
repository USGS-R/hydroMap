## ----include = FALSE, message=FALSE-----------------------
library(rmarkdown)
options(continue=" ")
options(width=60)
library(knitr)


## ----message=FALSE----------------------------------------
library(hydroMap)
library(dataRetrieval)

Range=c(-86.32679,-81.16322,39.61600,43.06262)
sites=c("04189000","04197100","04198000","04185000","04199500","04176500","04193500")
siteInfo <- readNWISsite(sites)

# png("test.png",width=11,height=8,units="in",res=600,pointsize=4)
plotWSB(sites, mapRange=Range, streamorder = 5)
points(siteInfo$dec_long_va, siteInfo$dec_lat_va, pch=20, col="red", cex=3)
box()
# dev.off()


## ----message=FALSE----------------------------------------
library(leaflet)
basins <- getBasin(sites)
Range=c(-86.32679,-81.16322,39.61600,43.06262)
flowLines <- getFlowLines(Range, streamorder = 5)

leaflet() %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  setView(-84, 41.35, zoom = 8) %>%
  addPolygons(data=basins, weight=2, color = "grey") %>%
  addPolylines(data=flowLines, weight=1) %>%
  addCircleMarkers(siteInfo$dec_long_va,siteInfo$dec_lat_va,
                   color = "red",
                   radius=4,
                   stroke=FALSE,
                   fillOpacity = 0.8, opacity = 0.8,
                   popup=siteInfo$station_nm)


