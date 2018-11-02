#' Extracting the list of midday images for PhenoCam sites
#'
#' @param site a character string of the PhenoCam site name
#' @param direct logical value indicating whether obtain the list from directly from the API or from the file on the server, default is TRUE
#' @return a vetor of URL's to the midday images for a given site
#' @import RCurl
#' @importFrom data.table as.data.table
#' @importFrom rjson fromJSON
#' @export
#' @examples
#'
#' midday_url <- get_midday_list('dukehw', direct = FALSE)
#' head(midday_url)
#'
get_midday_list <- function(site, direct = TRUE){
  phenocam_server = 'http://phenocam.sr.unh.edu'

  if(direct){

    url <- sprintf('%s/webcam/network/middayimglist/%s',phenocam_server, site)
    middday_tble <- try(rjson::fromJSON(file = url))
    if(class(middday_tble)=='try-error'){
      warning('direct method was failed for this site, try again with direct = FALSE.')
      return(NULL)
    }
    midday_list <- try(sapply(middday_tble$images, FUN = function(x){x$midimg}))
    if(class(midday_list)=='try-error'){
        warning('direct method was failed for this site, try again with direct = FALSE.')
        return(NULL)
    }
  }else{

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
  }
  midday_images_url <- paste0(phenocam_server, midday_list)
  return(midday_images_url)
}


