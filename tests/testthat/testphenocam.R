context("testphenocam")

phenos <- getphenos()
phenos <- as.data.frame(phenos)
dukehwLat <- phenos[phenos$site=='dukehw','lat']

rois <- getrois()
rois <- as.data.frame(rois)
dukehwLon <- rois[rois$roi_name=='dukehw_DB_1000', 'lon']

phenots <- getphenoTS(site = 'dukehw', vegType = 'DB', roiID = 1000, type = '3day')
phenots <- as.data.frame(phenots)
dukeB <- phenots[phenots$date=='2017-03-27', 'midday_b']

test_that("test getting site metadata", {
  expect_equal(dukehwLat, 35.973583)
})

test_that("test getting roi metadata", {
  expect_equal(dukehwLon, -79.100371)
})

test_that("test getting time-series data", {
  expect_equal(dukeB, 57.20225)
})
