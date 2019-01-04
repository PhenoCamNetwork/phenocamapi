

globalVariables(names = c('Year','Month', 'Day', 'Hour', 'Minute', 'Second',
                          'contact1', 'contact2',
                          'HHMMSS','DOY', 'Date', 'DateTime', 'year','filepaths',
                          'imgfile', 'AWB', 'maxmonthdev', 'wb', '.', ':='))


.onLoad <- function(libname, pkgname) {

  options(phenocam_server = 'http://phenocam.sr.unh.edu')

}

.onAttach <- function(libname, pkgname) {
  requireNamespace("data.table")
}

