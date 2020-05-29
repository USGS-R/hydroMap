.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Attention:
There is no continued resources for this package,
bug fixes & new features will be minimal.

Please consider using:
https://github.com/usgs-r/nhdplusTools")
}

#' hydroMaps
#'
#' \tabular{ll}{
#' Package: \tab hydroMaps\cr
#' Type: \tab Package\cr
#' License: \tab Unlimited for this package, dependencies have more restrictive licensing.\cr
#' Copyright: \tab This software is in the public domain because it contains materials
#' that originally came from the United States Geological Survey, an agency of
#' the United States Department of Interior. For more information, see the
#' official USGS copyright policy at
#' https://www.usgs.gov/visual-id/credit_usgs.html#copyright\cr
#' LazyLoad: \tab yes\cr
#' }
#'
#' Collection of functions to do USGS graphics.
#'
#' @name hydroMaps-package
#' @docType package
NULL

#' Political boundaries.
#' 
#' Political boundary shapefiles from \url{http://dds.cr.usgs.gov/pub/data/nationalatlas/bound0m_shp_nt00298.tar.gz} 
#' @name shape_polibounds
#' @docType data
#' @keywords station data
NULL
#' Rivers in US.
#' 
#' River shapefiles from \url{http://dds.cr.usgs.gov/pub/data/nationalatlas/hydro0m_shp_nt00300.tar.gz} 
#' @name shape_hydroline
#' @docType data
#' @keywords station data
NULL
#' Lakes in US
#' 
#' Lake shapefiles from \url{http://dds.cr.usgs.gov/pub/data/nationalatlas/hydro0m_shp_nt00300.tar.gz} 
#' @name shape_hydropoly
#' @docType data
#' @keywords station data
NULL
#' Lakes in US
#' 
#' Lake shapefiles from \url{http://dds.cr.usgs.gov/pub/data/nationalatlas/hydro0m_shp_nt00300.tar.gz} 
#' @name shape_hydropoly
#' @docType data
#' @keywords station data
NULL
