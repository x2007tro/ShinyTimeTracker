##
# Global parameter
##
ini_num_time_entry <- 10
entry_wid_s <- "80px"
entry_wid_m <- "120px"
entry_wid_l <- "250px"

##
# Time records specific pars
##
an_mid <- "501498"
ft_hrs <- 7.5
fallback_cliprj <- "ZZZ (General Admin)"
fallback_job <- ""
wkly_req_fields <- c("PayType", "PayTypeDesc", "Duration", "WorkDate", "AccountNumber", "Narrative")

##
# Configuration parameter
##
dly_file_loc <- "./input/daily/"
dly_arc_file_loc <- paste0(dly_file_loc, "archive/")
wly_file_loc <- "./input/weekly/"
wly_arc_file_loc <- paste0(wly_file_loc, "archive/")
cf_file_path <- "./input/ref/cross_reference.xlsx"