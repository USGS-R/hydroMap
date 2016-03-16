#' Basic plot of WSB based on huc
#' 
#' Basic plot
#' @param sites character vector of site ids
#' @param col for basin fill
#' @param streamorder integer
#' @param filePath path to save shapefiles. If NA, will go to temporary directory
#' @param mapRange vector of map limits (min long, max long, min lat, max lat)
#' @import sp 
#' @import rgdal
#' @export
#' @examples
#' \dontrun{
#' library(dataRetrieval)
#' Range=c(-86.32679,-81.16322,39.61600,43.06262)
#' sites=c("04189000","04197100","04198000","04185000","04199500","04176500","04193500")
#' siteInfo <- readNWISsite(sites)
#' 
#' png("test.png",width=11,height=8,units="in",res=600,pointsize=4)
#' plotWSB(sites, mapRange=Range)
#' points(siteInfo$dec_long_va, siteInfo$dec_lat_va, pch=20, col="red", cex=3)
#' box()
#' dev.off()
#' }
plotWSB <- function(sites,col="#A8A8A850", mapRange = NA, streamorder=3, filePath=NA){

  shape_hydropoly <- shape_hydropoly
  shape_polibounds <- shape_polibounds
  
  basins <- getBasin(sites, filePath)
  basins <- spTransform(basins,CRS(proj4string(shape_polibounds)))
  
  if(all(is.na(mapRange))){
    plot(basins, col=col)
    mapRange <- par()$usr
  } else {
    basins <- crop(basins, extent(mapRange)) 
    plot(basins, col=col)
  }

  shape_hydropoly <- clipShape(shape_hydropoly, mapRange)
  shape_polibounds <- clipShape(shape_polibounds, mapRange)
  
  flowLines <- getFlowLines(mapRange, streamorder, filePath)
  lowFlow <- clipShape(flowLines,mapRange)

  plot(shape_hydropoly,col="lightskyblue2",add=TRUE)
  plot(lowFlow,col="lightskyblue2",add=TRUE)
  plot(shape_polibounds,add=TRUE)
 
}

#' Basic plot of WSB based on huc
#' 
#' Basic plot
#' @param shapefile shapefile to clip
#' @param mapRange vector of map limits (min long, max long, min lat, max lat)
#' @import sp 
#' @import rgdal
#' @import rgeos 
#' @import raster
#' @export
#' @examples
#' mapRange=c(-80,-74, 38, 46)
#' shape_hydropoly <- shape_hydropoly
#' clippedShape <- clipShape(shape_hydropoly, mapRange)
clipShape <- function(shapefile, mapRange){
  ext <- extent(mapRange) 
  clipe <- as(ext, "SpatialPolygons") 
  
  proj4string(clipe) <- CRS(proj4string(shapefile)) 
  cropd <- SpatialPolygonsDataFrame(clipe, data.frame(x = 1), match.ID = FALSE) 
  shapeClipped <- gIntersection(shapefile, cropd,byid=TRUE) 
  return(shapeClipped)
}

#' Get shapefile basins
#' 
#' Get shapefile basins
#' @param sites character id
#' @param filePath path to save shapefile. If NA, will go to temporary directory
#' @return shapefile
#' @importFrom httr GET
#' @importFrom httr write_disk
#' @importFrom utils URLencode
#' @import sp 
#' @import rgdal 
#' @export
#' @examples
#' \dontrun{
#' sites <- c("01491000", "01573000", "01576000","01137500","06485500")
#' basinShapes <- getBasin(sites)
#' }
getBasin <- function(sites, filePath = NA){
  baseURL <- "http://cida-test.er.usgs.gov/nwc/geoserver/NWC/ows?service=WFS&version=1.1.0&srsName=EPSG:4326&request=GetFeature&typeName=NWC:epa_basins"
  
  siteText <- ""
  for(i in sites){
    siteText <- paste0(siteText,'<ogc:PropertyIsEqualTo  matchCase="true">',
                       '<ogc:PropertyName>site_no</ogc:PropertyName>',
                       '<ogc:Literal>',i,'</ogc:Literal>',
                       '</ogc:PropertyIsEqualTo>')
  }
  
  if(length(sites) > 1){
    filterXML <- paste0('<ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">',
                        '<ogc:Or>',siteText,'</ogc:Or>',
                        '</ogc:Filter>')
    
  } else {
    filterXML <- paste0('<ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">',
                        '<ogc:PropertyIsEqualTo matchCase="true">',
                        '<ogc:PropertyName>site_no</ogc:PropertyName>',
                        '<ogc:Literal>',sites,'</ogc:Literal>',
                        '</ogc:PropertyIsEqualTo>',
                        '</ogc:Filter>')
  }
  
  filterXML <- URLencode(filterXML,reserved = TRUE)
  
  requestURL <- paste0(baseURL,"&outputFormat=shape-zip", "&filter=", filterXML)
  destination = tempfile(pattern = 'basins_shape', fileext='.zip')
  file <- GET(requestURL, write_disk(destination, overwrite=T))
  
  if(is.na(filePath)){
    filePath <- tempdir()
  }
  
  unzip(destination, exdir = filePath)
  basins = readOGR(filePath, layer='epa_basins')
  return(basins)
}


#' Get shapefile flowlines
#' 
#' Get shapefile flowlines
#' @param mapRange vector of map limits (min long, max long, min lat, max lat)
#' @param streamorder integer stream order
#' @param filePath path to save shapefile. If NA, will go to temporary directory
#' @return shapefile
#' @importFrom httr POST
#' @importFrom httr write_disk
#' @importFrom utils URLencode
#' @import sp 
#' @import rgdal 
#' @export
#' @examples
#' \dontrun{
#' Range=c(-86.32679,-81.16322,39.61600,43.06262)
#' flowLines <- getFlowLines(Range, 5)
#' }
getFlowLines <- function(Range, streamorder = 3, filePath=NA){
  baseURL <- "http://cida-test.er.usgs.gov/nhdplus/geoserver/nhdPlus/ows?service=WFS&version=1.1.0&srsName=EPSG:4269&request=GetFeature&typeName=nhdPlus:nhdflowline_network"
  
  postURL <- "http://cida-test.er.usgs.gov/nhdplus/geoserver/nhdPlus/ows"
  
  filterXML <- paste0('<?xml version="1.0"?>',
                '<wfs:GetFeature xmlns:wfs="http://www.opengis.net/wfs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" service="WFS" version="1.1.0" outputFormat="shape-zip" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.1.0/wfs.xsd">',
                  '<wfs:Query xmlns:feature="http://owi.usgs.gov/nhdplus" typeName="feature:nhdflowline_network" srsName="EPSG:4326">',
                    '<ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">',
                      '<ogc:And>',
                        '<ogc:PropertyIsGreaterThan>',
                          '<ogc:PropertyName>streamorde</ogc:PropertyName>',
                          '<ogc:Literal>',streamorder-1,'</ogc:Literal>',
                        '</ogc:PropertyIsGreaterThan>',
                        '<ogc:BBOX>',
                          '<ogc:PropertyName>the_geom</ogc:PropertyName>',
                          '<gml:Envelope>',
                            '<gml:lowerCorner>',Range[3]," ",Range[1],'</gml:lowerCorner>',
                            '<gml:upperCorner>',Range[4]," ",Range[2],'</gml:upperCorner>',
                          '</gml:Envelope>',
                        '</ogc:BBOX>',
                      '</ogc:And>',
                    '</ogc:Filter>',
                  '</wfs:Query>',
                '</wfs:GetFeature>')

  destination = file.path(tempdir(),"nhdflowline_network.zip")
  file <- POST(postURL, body = filterXML, write_disk(destination, overwrite=T))
  
  if(is.na(filePath)){
    filePath <- tempdir()
  }
  
  unzip(destination, exdir = filePath)
  flowLines = readOGR(filePath, layer='nhdflowline_network')
  return(flowLines)
}

