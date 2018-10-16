#' Full list of PhenoCam sites and metadata
#'
#' @return a data.table with a list of all the PhenoCam sites and their metadata
#' @import data.table
#' @import rjson
#' @export
#' @examples
#'
#' phenos <- getphenos()
#' head(phenos)
#'
getphenos <- function(){
  # getting the metadata from the phenocam
  phenos <- fromJSON(file = 'https://phenocam.sr.unh.edu/api/cameras/?limit=10000')$results

  # getting organized in a data.table
  dt <- data.table(site = sapply(phenos, function(x){tmp = x$Sitename; if(is.null(tmp)) tmp <- NA; tmp}),
                   lat = sapply(phenos, function(x){tmp = x$Lat; if(is.null(tmp)) tmp <- NA; tmp}),
                   lon = sapply(phenos, function(x){tmp = x$Lon; if(is.null(tmp)) tmp <- NA; tmp}),
                   elev = sapply(phenos, function(x){tmp = x$Elev; if(is.null(tmp)) tmp <- NA; tmp}),
                   active = sapply(phenos, function(x){tmp = x$active; if(is.null(tmp)) tmp <- NA; tmp}),
                   utc_offset = sapply(phenos, function(x){tmp = x$utc_offset; if(is.null(tmp)) tmp <- NA; tmp}),
                   date_first = sapply(phenos, function(x){tmp = x$date_first; if(is.null(tmp)) tmp <- NA; tmp}),
                   date_last = sapply(phenos, function(x){tmp = x$date_last; if(is.null(tmp)) tmp <- NA; tmp}),
                   site_description = sapply(phenos, function(x){tmp = x$sitemetadata$site_description; if(is.null(tmp)) tmp <- NA; tmp}),
                   camera_description = sapply(phenos, function(x){tmp = x$sitemetadata$camera_description; if(is.null(tmp)) tmp <- NA; tmp}),
                   camera_orientation = sapply(phenos, function(x){tmp = x$sitemetadata$camera_orientation; if(is.null(tmp)) tmp <- NA; tmp}),
                   flux_data = sapply(phenos, function(x){tmp = x$sitemetadata$flux_data; if(is.null(tmp)) tmp <- NA; tmp}),
                   flux_networks = sapply(phenos, function(x){tmp = x$sitemetadata$flux_networks; if(is.null(tmp)) tmp <- NA; tmp}),
                   # flux_networks.name = sapply(phenos, function(x){tmp = x$sitemetadata$flux_networks[[1]]$Name; if(is.null(tmp)) tmp <- NA; tmp}),
                   # flux_networks.url = sapply(phenos, function(x){tmp = x$sitemetadata$flux_networks[[1]]$NetworkURL; if(is.null(tmp)) tmp <- NA; tmp}),
                   # flux_networks.description = sapply(phenos, function(x){tmp = x$sitemetadata$flux_networks[[1]]$Description; if(is.null(tmp)) tmp <- NA; tmp}),
                   flux_sitenames = sapply(phenos, function(x){tmp = x$sitemetadata$flux_sitenames; if(is.null(tmp)) tmp <- NA; tmp}),
                   dominant_species = sapply(phenos, function(x){tmp = x$sitemetadata$dominant_species; if(is.null(tmp)) tmp <- NA; tmp}),
                   primary_veg_type = sapply(phenos, function(x){tmp = x$sitemetadata$primary_veg_type; if(is.null(tmp)) tmp <- NA; tmp}),
                   secondary_veg_type = sapply(phenos, function(x){tmp = x$sitemetadata$secondary_veg_type; if(is.null(tmp)) tmp <- NA; tmp}),
                   site_meteorology = sapply(phenos, function(x){tmp = x$sitemetadata$site_meteorology; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAT_site = sapply(phenos, function(x){tmp = x$sitemetadata$MAT_site; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAP_site = sapply(phenos, function(x){tmp = x$sitemetadata$MAP_site; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAT_daymet = sapply(phenos, function(x){tmp = x$sitemetadata$MAT_daymet; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAP_daymet = sapply(phenos, function(x){tmp = x$sitemetadata$MAP_daymet; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAT_worldclim = sapply(phenos, function(x){tmp = x$sitemetadata$MAT_worldclim; if(is.null(tmp)) tmp <- NA; tmp}),
                   MAP_worldclim = sapply(phenos, function(x){tmp = x$sitemetadata$MAP_worldclim; if(is.null(tmp)) tmp <- NA; tmp}),
                   koeppen_geiger = sapply(phenos, function(x){tmp = x$sitemetadata$koeppen_geiger; if(is.null(tmp)) tmp <- NA; tmp}),
                   ecoregion = sapply(phenos, function(x){tmp = x$sitemetadata$ecoregion; if(is.null(tmp)) tmp <- NA; tmp}),
                   landcover_igbp = sapply(phenos, function(x){tmp = x$sitemetadata$landcover_igbp; if(is.null(tmp)) tmp <- NA; tmp})
  )

  dt$flux_networks_name <- sapply(dt$flux_networks, function(x){
    if(length(x)==0)
      return(NA)
    x[[1]]$Name
  })

  dt$flux_networks_url <- sapply(dt$flux_networks, function(x){
    if(length(x)==0)
      return(NA)
    x[[1]]$NetworkURL
  })

  dt$flux_networks_description <- sapply(dt$flux_networks, function(x){
    if(length(x)==0)
      return(NA)
    x[[1]]$Description
  })

  dt
}


