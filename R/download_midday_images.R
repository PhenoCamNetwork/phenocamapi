#' Downloading the midday images for PhenoCam sites given a time range
#'
#' @param site a character string, the PhenoCam site name
#' @param y integer numeric, the year for which midday images are downloaded
#' @param months a vector of integer numeric, months for which midday images are downloaded
#' @param days a vector of integer numeric, days for which midday images are downloaded
#' @param download_dir a character string, path to directory where images are downloaded
#' @return a character string, path to directory where images are downloaded
#' @import RCurl
#' @import data.table
#' @export
#' @examples
#'
#' download_dir <- download_midday_images('dukehw',
#'  y = 2018,
#'  months = 2,
#'  days=1,
#'  download_dir= tempdir())
#'
download_midday_images <- function(site, y = year(Sys.Date()), months = 1, days=1, download_dir){
  midday_list <- get_midday_list(site, direct = FALSE)
  midday_table <- parse_phenocam_filenames(midday_list)

  download_list <- midday_table[midday_table$Year==y&midday_table$Month%in%months&midday_table$Day%in%days,]$filepaths

  n <- length(download_list)

  if(n==0) {
    warning('no files to download!')
    return(NULL)
  }

  if(!dir.exists(download_dir)){
    stop(download_dir, ' directory does not exist!')
  }

  pb <- txtProgressBar(0, n , style = 3)

  for(i in 1:n){
    download_url <- download_list[i]
    setTxtProgressBar(pb, i)

    if(!RCurl::url.exists(download_url)) {
      warning(download_url, ' does not exist!')
      next()
    }

    destfile <- paste0(download_dir, '/', basename(download_url))
    if(file.exists(destfile)) {
      warning(destfile, ' was already in ', download_dir)
      next()
    }
    download.file(download_url, destfile = destfile, quiet = TRUE, mode = 'wb')
  }

  download_dir
}


