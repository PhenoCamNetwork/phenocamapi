#' Extracting the list of midday images for PhenoCam sites
#'
#' @param site a character string of the PhenoCam site name
#' @return a vetor of URL's to the midday images for a given site
#' @import RCurl
#' @export
#' @examples
#'
#' midday_url <- get_midday_list('dukehw')
#' head(midday_url)
#'
get_midday_list <- function(site){
  phenocam_server = 'http://phenocam.sr.unh.edu'

  url <- sprintf('%s/data/archive/%s/ROI/%s-midday.txt', phenocam_server, site, site)
  tmp_dest <- tempfile(fileext = '.txt')

  if(!RCurl::url.exists(url)) {
    warning('midday list file was not found on the Phenocam server!')
    return(NULL)
  }

  download_try <- try(download.file(url, destfile = tmp_dest, quiet = TRUE))
  if(class(download_try)=='try-error') {
    warning('download from the phenocam server was failed')
    return(NULL)
  }
  midday_list <- readLines(tmp_dest)
  midday_list <- midday_list[midday_list!='']

  midday_url <- paste0(phenocam_server, midday_list)
  midday_url
}


