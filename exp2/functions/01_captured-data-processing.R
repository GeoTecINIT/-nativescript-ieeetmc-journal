library("tidyverse")
source("exp2/functions/00_json-utils.R")

HIGH_FREQUENCY_INTERVAL <- 60000
LOW_FREQUENCY_INTERVAL <- 120000

empty_geo_records_df <- function(){
  return(data.frame(INSTANT=integer(),
                    TAKES=integer(),
                    LAT=double(),
                    LON=double(),
                    ALT=double(),
                    VACC=double(),
                    HACC=double(),
                    SPD=double(),
                    DIR=double()))
}

empty_answers_records_df <- function() {
  data.frame(INSTANT=integer(),
             TAKES=integer(),
             QUESTION=character(),
             ANSWER=integer(),
             ANSWER_TIME=integer())
}

add_row_to_geo_df <- function(df, instant, took, geoRecord) {
  return(df %>%
           add_row(INSTANT = instant,
                   TAKES = took,
                   LAT=geoRecord$latitude,
                   LON=geoRecord$longitude,
                   ALT=geoRecord$altitude,
                   VACC=geoRecord$verticalAccuracy,
                   HACC=geoRecord$horizontalAccuracy,
                   SPD=geoRecord$speed,
                   DIR=geoRecord$direction))
}

add_row_to_answers_df <- function(df, instant, took, answerRecord) {
  return(df %>%
           add_row(INSTANT=instant,
                   TAKES=took,
                   QUESTION=answerRecord$title,
                   ANSWER=answerRecord$answer,
                   ANSWER_TIME=answerRecord$millisecondsToAnswer))
}

process_captured_data <- function(filePath) {
  capturedData <- read.csv(file = filePath, stringsAsFactors = FALSE)

  geoRecords <- empty_geo_records_df()

  multipleGeoRecords <- empty_geo_records_df()
  multipleGeoRecordsGroups <- 0

  answersRecords <- empty_answers_records_df()

  startTime <- 0
  lastNotificationSendingTime <- 0
  previousToBeCloseTook <- 0
  offset <- 0


  for (i in 1:nrow(capturedData)) {
    row <- capturedData[i,]

    if (startTime == 0) {
      startTime <- row$timestamp - LOW_FREQUENCY_INTERVAL
    }

    dataType <- row$name
    dataContent <- read_json_from_string(row$content[[1]])

    if (dataType == "acquirePhoneGeolocation") {
      outcome <- dataContent$outcome
      previousToBeCloseTook <- dataContent$took
      instant <- LOW_FREQUENCY_INTERVAL * (nrow(geoRecords) + 1) + offset
      geoRecords <- add_row_to_geo_df(geoRecords, instant, dataContent$took, outcome)
    } else if (dataType == "acquireMultiplePhoneGeolocation") {
      multipleGeoRecordsGroups <- multipleGeoRecordsGroups + 1
      outcome <- dataContent$outcome
      took <- floor(dataContent$took / length(outcome))
      instant <- LOW_FREQUENCY_INTERVAL + HIGH_FREQUENCY_INTERVAL * multipleGeoRecordsGroups + offset

      for (geoRecord in outcome) {
        multipleGeoRecords <- add_row_to_geo_df(multipleGeoRecords, instant, took, geoRecord)
        instant <- instant + took
      }

    } else if (dataType == "sendNotification") {
      lastNotificationSendingTime <- row$timestamp
    } else if (dataType == "questionsAnswered") {
      took <- row$timestamp - lastNotificationSendingTime
      instant <- lastNotificationSendingTime - startTime
      answers <- dataContent$answers
      for (answer in answers) {
        answersRecords <- add_row_to_answers_df(answersRecords, instant, took, answer)
      }
    } else if (dataType == "checkAreaOfInterestProximity"
               & dataContent$emitted == "movedCloseToAreaOfInterest") {
      offset <- offset + previousToBeCloseTook
    }
  }

  return(list(
    list("dataType" = "geo-records", "records" = geoRecords),
    list("dataType" = "multiple-geo-records", "records" = multipleGeoRecords),
    list("dataType" = "answer-records", "records" = answersRecords)
  ))
}

save_processed_data <- function(data, folder) {
  for (d in data) {
    write.csv(d$records, file.path(folder, paste(d$dataType,"csv", sep = ".")), row.names = FALSE)
  }
}