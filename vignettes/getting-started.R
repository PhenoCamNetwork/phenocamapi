## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(data.table)
library(phenocam)

# obtaining the metadata as data.table
phenos <- getphenos()

head(phenos)

## ------------------------------------------------------------------------
phenofluxsites <- phenos[flux_data==TRUE&!is.na(flux_sitenames), .(PhenoCam=site, Flux=flux_sitenames)]
head(phenofluxsites)

#list deciduous broadleaf sites with flux tower
DB.flux <- phenos[flux_data==TRUE&primary_veg_type=='DB', site]
head(DB.flux)

## ------------------------------------------------------------------------
# obtaining the list of all the available ROI's on the PhenoCam server
rois <- getrois()

head(rois)

## ------------------------------------------------------------------------

# to obtain the DB 1000  from dukehw
dukehw_DB_1000 <- getphenoTS(site = 'dukehw', vegType = 'DB', roiID = 1000, type = '3day')

head(dukehw_DB_1000)

dukehw_DB_1000[,date:=as.Date(date)]
dukehw_DB_1000[,plot(date, gcc_90)]


## ------------------------------------------------------------------------
phenots <- getphenoTS(site = 'oregonMP', vegType = 'EN', roiID = 1000)

head(phenots)

fluxfile <- system.file('fluxnetrepo/FLX_US-Me2/FLX_US-Me2_FULLSET_DD.csv', package = 'phenocam')

fluxts <- read.csv(fluxfile, skip = 0)
fluxts[fluxts==-9999] <- NA
fluxts <- as.data.table(fluxts)
fluxts[,datetime:=as.POSIXct(as.character(TIMESTAMP), format='%Y%m%d')]
fluxts[,YYYYMMDD:=as.character(as.Date(datetime))]
fluxts[,YEAR:=year(datetime)]
fluxts[,DOY:=yday(datetime)]

head(fluxts)


