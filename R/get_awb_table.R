#' Extracting Auto-White-Balance (AWB) status of images for PhenoCam sites
#'
#' @param site a character string of the PhenoCam site name
#' @return a data.table of two columns: midday images and their AWB status ('ON', 'OFF', 'UNKOWN', 'LIKELY_YES', 'LIKELY_NO')
#' @import RCurl
#' @importFrom data.table data.table as.data.table
#' @export
#' @examples
#'
#' awb_table <- get_awb_table('dukehw')
#' head(awb_table)
#'
get_awb_table <- function(site){

  phenocam_server = 'http://phenocam.sr.unh.edu'

  url <- sprintf('%s/data/archive/%s/ROI/%s-awb.txt', phenocam_server, site, site)

  tmp_dest <- tempfile(fileext = '.txt')

  if(!RCurl::url.exists(url)) {
    warning('AWB file was not found on the Phenocam server!')
    return(NULL)
  }

  download_try <- try(download.file(url, destfile = tmp_dest, quiet = TRUE))
  if(class(download_try)=='try-error') {
    warning('download from the phenocam server was failed')
    return(NULL)
  }

  awb_table <- read.csv(tmp_dest)
  awb_table <- as.data.table(awb_table)
  awb_table[,imgfile:=as.character(imgfile)]

  awb_table[wb==0, AWB:='OFF']
  awb_table[wb==1, AWB:='ON']
  awb_table[is.na(wb), AWB:='UNKOWN']
  awb_table[is.na(wb)&maxmonthdev<=0.02, AWB:='LIKELY_YES']
  awb_table[is.na(wb)&maxmonthdev>0.02, AWB:='LIKELY_NO']

  awb <- awb_table[,.(filename=imgfile, AWB)]
  awb
}


