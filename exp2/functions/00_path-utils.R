extract_iteration_number <- function(filePath) {
  fileName <- tail(strsplit(filePath, "/")[[1]], n=1)
  iteration <- as.numeric(strsplit(fileName, "_")[[1]][1])
  return(iteration)
}

extract_device_id <- function(filePath) {
  deviceDirectory <- tail(strsplit(filePath, "/")[[1]], n=1)
  deviceId <- strsplit(deviceDirectory, "_")[[1]][1]
  return(deviceId)
}