#' Obtain phenological time-series from the PhenoCam server
#'
#' @param site site name as character string
#' @param vegType 2-letter character string indicating the vegetation type
#' @param roiID four-digit integer number indicating the ROI number
#' @param type a character string indicating what data to be obtained, can be '1day', '3day', or 'roistats'.
#' @return a data.table containing phenological data over time.
#' @importFrom data.table data.table as.data.table
#' @import utils
#' @export
#' @examples
#'
#' ts <- get_pheno_ts(site = 'dukehw', vegType = 'DB', roiID = 1000)
#' head(ts)
#'
get_pheno_ts <- function(site, vegType, roiID, type = '3day'){

  if(type%in%c('1day', '3day', 'roistats')){
    ext <- paste0('_', type, '.csv')
  }else{
    stop("type argument should be one of '1day', '3day', or 'roistats'.")
  }
  url <- paste0(.Options$phenocam_server, '/data/archive/', site, '/ROI/', site, '_', vegType, '_', sprintf(fmt = '%04d', roiID), ext)

  tmp <- tempfile(fileext='.csv')
  if(class(try(download.file(url, destfile = tmp)))=='try-error') {
    stop('file was not found on the server!')
  }else{
    ts <- read.csv(tmp, skip = 22)
  }
  ts <- as.data.table(ts)
  ts$YEAR <- ts$year
  ts$DOY <- ts$doy
  ts$YYYYMMDD <- as.character(ts$date)

  ts
}
