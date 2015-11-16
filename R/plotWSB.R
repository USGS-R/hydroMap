#' Basic plot of WSB based on huc
#' 
#' Basic plot
#' @param siteInfo data frame returned from dataRetrieval
#' @param rangeMap numeric vector of: min longitude, max longitude, min latitude, max latitude
#' @return list of politicalBoundary, rivers, and lakes shapefiles, and a vector of lat/lon limits
#' @importFrom rgdal readOGR
#' @importFrom httr GET
#' @importFrom httr write_disk
#' @importFrom utils URLencode
#' @importFrom sp spTransform
#' @export
#' @examples
#' sites <- c("01491000", "01573000", "01576000","01137500","06485500")
#' library(dataRetrieval)
#' siteInfo <- readNWISsite(sites)
#' png("test.png")
#' plotWSB(sites)
#' points(siteInfo$dec_long_va, siteInfo$dec_lat_va, pch=20, col="red", cex=1)
#' box()
#' dev.off()
plotWSB <- function(sites,col="#A8A8A850"){

  shape_hydropoly <- shape_hydropoly
  shape_polibounds <- shape_polibounds
  shape_hydroline <- shape_hydroline
  
  baseURL <- "http://cida-eros-wsdev.er.usgs.gov:8081/geoserver/NWC/ows?service=WFS&version=1.1.0&srsName=EPSG:4326&request=GetFeature&typeName=NWC:epa_basins"

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
  shp.path <- tempdir()
  unzip(destination, exdir = shp.path)
  basins = readOGR(shp.path, layer='epa_basins')
#   destination = tempfile(pattern = 'geoJ',fileext = ".json")
#   requestURL <- paste0(baseURL,"&outputFormat=json", "&filter=", filterXML)
#   file <- GET(requestURL, write_disk(destination, overwrite=T))
#   shp.path <- tempdir()
#   basins = readOGR(destination, "OGRGeoJSON")
  basins <- spTransform(basins,CRS(proj4string(shape_polibounds)))
  
  plot(basins, col=col)
  plot(shape_hydropoly,col="lightskyblue2",add=TRUE)
  lines(shape_hydroline,col="lightskyblue2")
  plot(shape_polibounds,add=TRUE) 
  # box()
}
  