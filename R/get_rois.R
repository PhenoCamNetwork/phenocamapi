#' Full list of PhenoCam ROI's and metadata
#'
#' @return a data.table with a list of all the PhenoCam ROI's and their metadata
#' @importFrom data.table data.table as.data.table
#' @importFrom rjson fromJSON
#' @export
#' @examples
#'
#' rois <- get_rois()
#' head(rois)
#'
get_rois <- function(){
  # getting the metadata from the phenocam
  rois <- fromJSON(file = 'https://phenocam.nau.edu/api/roilists/?limit=10000')$results

  # getting organized in a data.table
  dt <- data.table(roi_name = sapply(rois, function(x){tmp = x$roi_name; if(is.null(tmp)) tmp <- NA; tmp}),
                   site = sapply(rois, function(x){tmp = x$site; if(is.null(tmp)) tmp <- NA; tmp}),
                   lat = sapply(rois, function(x){tmp = x$lat; if(is.null(tmp)) tmp <- NA; tmp}),
                   lon = sapply(rois, function(x){tmp = x$lon; if(is.null(tmp)) tmp <- NA; tmp}),
                   roitype = sapply(rois, function(x){tmp = x$roitype; if(is.null(tmp)) tmp <- NA; tmp}),
                   active = sapply(rois, function(x){tmp = x$active; if(is.null(tmp)) tmp <- NA; tmp}),
                   show_link = sapply(rois, function(x){tmp = x$show_link; if(is.null(tmp)) tmp <- NA; tmp}),
                   show_data_link = sapply(rois, function(x){tmp = x$show_data_link; if(is.null(tmp)) tmp <- NA; tmp}),
                   sequence_number = sapply(rois, function(x){tmp = x$sequence_number; if(is.null(tmp)) tmp <- NA; tmp}),
                   description = sapply(rois, function(x){tmp = x$description; if(is.null(tmp)) tmp <- NA; tmp}),
                   first_date = sapply(rois, function(x){tmp = x$first_date; if(is.null(tmp)) tmp <- NA; tmp}),
                   last_date = sapply(rois, function(x){tmp = x$last_date; if(is.null(tmp)) tmp <- NA; tmp}),
                   site_years = sapply(rois, function(x){tmp = x$site_years; if(is.null(tmp)) tmp <- NA; tmp}),
                   missing_data_pct = sapply(rois, function(x){tmp = x$missing_data_pct; if(is.null(tmp)) tmp <- NA; tmp}),
                   roi_page = sapply(rois, function(x){tmp = x$roi_page; if(is.null(tmp)) tmp <- NA; tmp}),
                   roi_stats_file = sapply(rois, function(x){tmp = x$roi_stats_file; if(is.null(tmp)) tmp <- NA; tmp}),
                   one_day_summary = sapply(rois, function(x){tmp = x$one_day_summary; if(is.null(tmp)) tmp <- NA; tmp}),
                   three_day_summary = sapply(rois, function(x){tmp = x$three_day_summary; if(is.null(tmp)) tmp <- NA; tmp}),
                   data_release = sapply(rois, function(x){tmp = x$data_release; if(is.null(tmp)) tmp <- NA; tmp})

  )
  dt
}


