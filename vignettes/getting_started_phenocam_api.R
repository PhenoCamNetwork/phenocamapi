## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- fig.height=5, fig.width=6.5, message=FALSE-------------------------
library(data.table)

library(phenocamapi)

# obtaining the phenocam site metadata from the server as data.table
phenos <- get_phenos()

# checking out the first few rows
head(phenos$site)

colnames(phenos$site)

# removing the sites with unkown MAT and MAP values
phenos <- phenos[!((MAT_worldclim == -9999)|(MAP_worldclim == -9999))]

# extracting the PhenoCam climate space based on the WorldClim dataset
phenos[primary_veg_type=='DB', plot(MAT_worldclim, MAP_worldclim, pch = 19, col = 'green', xlim = c(-5, 27), ylim = c(0, 4000))]
phenos[primary_veg_type=='DN', points(MAT_worldclim, MAP_worldclim, pch = 1, col = 'darkgreen')]
phenos[primary_veg_type=='EN', points(MAT_worldclim, MAP_worldclim, pch = 17, col = 'brown')]
phenos[primary_veg_type=='EB', points(MAT_worldclim, MAP_worldclim, pch = 25, col = 'orange')]
phenos[primary_veg_type=='AG', points(MAT_worldclim, MAP_worldclim, pch = 12, col = 'yellow')]
phenos[primary_veg_type=='SH', points(MAT_worldclim, MAP_worldclim, pch = 23, col = 'red')]
legend('topleft', legend = c('DB','DN', 'EN','EB','AG', 'SH'), 
       pch = c(19, 1, 17, 25, 12, 23), 
       col =  c('green', 'darkgreen', 'brown',  'orange',  'yellow',  'red' ))


## ---- fig.height=5, fig.width=6.5, message=FALSE-------------------------
# store sites with flux_data available
phenofluxsites <- phenos[flux_data==TRUE&!is.na(flux_sitenames), .(PhenoCam=site, Flux=flux_sitenames)]

# see the first few rows
head(phenofluxsites)

#list deciduous broadleaf sites with flux tower
DB.flux <- phenos[flux_data==TRUE&primary_veg_type=='DB', site]

# see the first few rows
head(DB.flux)

## ---- fig.height=5, fig.width=6.5, message=FALSE-------------------------
# obtaining the list of all the available ROI's on the PhenoCam server
rois <- get_rois()

head(rois$roi_name)
colnames(rois)

## ---- fig.height=5, fig.width=6.5, message=FALSE-------------------------
# to obtain the DB 1000  from dukehw
dukehw_DB_1000 <- get_pheno_ts(site = 'dukehw', vegType = 'DB', roiID = 1000, type = '3day')

colnames(dukehw_DB_1000)

dukehw_DB_1000[,date:=as.Date(date)]
dukehw_DB_1000[,plot(date, gcc_90, col = 'green', type = 'b', title = 'dukehw')]

## ---- fig.height=5, fig.width=6.5, message=FALSE-------------------------
# obtaining midday_images for dukehw
duke_middays <- get_midday_list('dukehw')

# see the first few rows
head(duke_middays)


