##
# CalcDuration
##
CalcDuration <- function(begt, endt){
  res <- as.difftime(c(begt, endt), format="%H:%M")
  res2 <- as.numeric(res, units = "hours")
  res3 <- round(res2[2] - res2[1], 2)
  return(res3)
}