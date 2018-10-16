globalVariables(names = c('.', 'CO2', 'DOY', 'FC', 'G', 'H', 'H2O', 'LE', 'LW_IN', 'LW_OUT',
                          'NETRAD_PI_F', 'PA', 'PPFD_IN', 'P_PI_F', 'RH',
                          'SC', 'SWC_1_1_1', 'SWC_1_2_1', 'SW_IN', 'SW_OUT', 'TA',
                          'TIMESTAMP', 'TIMESTAMP_START','TS_1_1_1', 'TS_1_2_1', 'T_SONIC',
                          'T_SONIC_SIGMA', 'USTAR', 'U_SIGMA', 'VPD_PI', 'V_SIGMA',
                          'WD', 'WS', 'W_SIGMA', 'YEAR', 'YYYYMMDD', 'datetime', 'doy'))

.onLoad <- function(libname, pkgname) {

  options(phenocam_server = 'http://phenocam.sr.unh.edu/')

}

.onAttach <- function(libname, pkgname) {
  requireNamespace("data.table")
}
