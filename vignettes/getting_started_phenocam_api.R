## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(data.table)
library(phenocamapi)

# obtaining the metadata as data.table
phenos <- get_phenos()

head(phenos)

## ------------------------------------------------------------------------
phenofluxsites <- phenos[flux_data==TRUE&!is.na(flux_sitenames), .(PhenoCam=site, Flux=flux_sitenames)]
head(phenofluxsites)

#list deciduous broadleaf sites with flux tower
DB.flux <- phenos[flux_data==TRUE&primary_veg_type=='DB', site]
head(DB.flux)

## ------------------------------------------------------------------------
# obtaining the list of all the available ROI's on the PhenoCam server
rois <- get_rois()

head(rois)

## ------------------------------------------------------------------------

# to obtain the DB 1000  from dukehw
dukehw_DB_1000 <- get_pheno_ts(site = 'dukehw', vegType = 'DB', roiID = 1000, type = '3day')

head(dukehw_DB_1000)

dukehw_DB_1000[,date:=as.Date(date)]
# dukehw_DB_1000[,plot(date, gcc_90)]


