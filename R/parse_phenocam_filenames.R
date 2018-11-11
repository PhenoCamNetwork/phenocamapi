#' Parse Phenocam filenames
#'
#' This function parse filename to extract sitename, date and timing of the images based on the phenocam naming convention.
#' @param filepaths a character vector of filenames
#' @return a datatable containing filenames, with site name, date and timing
#' @keywords  Parse Filename
#' @export
#' @import data.table
#'
parse_phenocam_filenames <- function(filepaths)
{
  filenames <- gsub(paste('.jpg',
                          '.tiff',
                          '.tif',
                          '.dng',
                          sep = '|')
                    , '', basename(filepaths),
                    ignore.case = TRUE)

  werr <- grepl('.err', filenames, fixed = TRUE)

  lsplit <- lapply(filenames, function(x){strsplit(x, split = '_')[[1]]})
  len <- lapply(lsplit, length)
  wIR <- (grepl('_IR_', filenames))

  wfilter <- (!werr)&(len==5)&(!wIR)

  imgDT <- cbind(filepaths[wfilter],filenames[wfilter], matrix(unlist(lsplit[wfilter]), ncol = 5, byrow = TRUE))
  colnames(imgDT) <- c('filepaths', 'filenames', 'Site', 'Year', 'Month','Day','HHMMSS')
  imgDT <- data.table(imgDT)

  imgDT$Year <- as.numeric(imgDT$Year)
  imgDT$Month <- as.numeric(imgDT$Month)
  imgDT$Day <- as.numeric(imgDT$Day)
  imgDT$HHMMSS <- as.numeric(imgDT$HHMMSS)
  imgDT$Hour <- floor(imgDT$HHMMSS/10000)
  imgDT$Minute <- floor((imgDT$HHMMSS%%10000)/100)
  imgDT$Second <- imgDT$HHMMSS%%100
  imgDT$DOY <- yday(ISOdate(imgDT$Year, imgDT$Month, imgDT$Day))
  imgDT$Date <- as.Date(ISOdate(imgDT$Year, imgDT$Month, imgDT$Day))
  imgDT$DateTime <- ISOdatetime(imgDT$Year, imgDT$Month, imgDT$Day, imgDT$Hour, imgDT$Minute, imgDT$Second)
  imgDT
}
