library(rjson)

read_from_json <- function(fileName) {
  return(fromJSON(file=fileName))
}

read_json_from_string <- function(jsonString) {
  return(fromJSON(jsonString))
}

write_to_json <- function(fileName, content) {
  fileConn <- file(fileName)
  writeLines(toJSON(content, indent=2), fileConn)
  close(fileConn)
}