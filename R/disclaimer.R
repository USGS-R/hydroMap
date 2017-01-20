.onAttach <- function(libname, pkgname) {
  packageStartupMessage("This information is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The information has not received final approval by the U.S. Geological Survey (USGS) and is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the information. Although this software program has been used by the USGS, no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.")
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
