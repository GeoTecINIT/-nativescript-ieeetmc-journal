fix_geofencing_repeated_events <- function(keyEvents) {
  problematicEvents <- c("checkAreaOfInterestProximity#movedCloseToAreaOfInterest",
                         "checkAreaOfInterestProximity#movedAwayFromAreaOfInterest")
  
  for (problematicEvent in problematicEvents) {
    if (keyEvents[problematicEvent] == 2) {
      keyEvents[problematicEvent] = 1
    }
  }
  
  return(keyEvents)
}


count_key_events <- function(executedTasks, keyEvents, keyEventsNames) {
  eventCount <- c(0,0,0,0,0,0,0,0,0,0)
  names(eventCount) <- keyEventsNames
  
  for (executedTask in executedTasks) {
    name <- executedTask$name
    emitted <- executedTask$content$emitted
    invokedBy <- executedTask$content$invokedBy
    
    if (is.null(emitted)) {
      next
    }
    
    for (keyEvent in keyEvents) {
      if (name == keyEvent$name 
          & emitted %in% keyEvent$emitted
          & invokedBy %in% keyEvent$invokedBy
      ) {
        keyTask <- paste(name, emitted, sep="#")
        eventCount[keyTask] = eventCount[keyTask] + 1
      }
    }
  }
  
  return(eventCount)
}


load_captured_key_events <- function(deviceDataPath, keyEventsDesc, keyEventsNames) {
  traceFiles <- list.files(path=deviceDataPath, pattern = '*_traces.json', full.names = TRUE)
  keyEvents <- list()
  
  for (file in traceFiles) {
    executedTasks <- read_from_json(file)
    keyEventsCount <- count_key_events(executedTasks, keyEventsDesc, keyEventsNames)
    keyEventsCount <- fix_geofencing_repeated_events(keyEventsCount)
    iteration <- extract_iteration_number(file)
    keyEvents <- append(keyEvents, list(list("iteration" = iteration, "keyEvents" = keyEventsCount)))
  }
  
  return(keyEvents)
}


load_experiment_captured_key_events <- function(dataPath, keyEventsDesc, keyEventsNames) {
  devicesDataPath <- list.dirs(path=dataPath)
  devicesDataPath <- devicesDataPath[2:length(devicesDataPath)] # Exclude searching directory
  
  capturedKeyEvents <- list()
  
  for (deviceDataPath in devicesDataPath) {
    deviceId <- extract_device_id(deviceDataPath)
    keyEvents <- load_captured_key_events(deviceDataPath, keyEventsDesc, keyEventsNames)
    capturedKeyEvents <- append(capturedKeyEvents, list(list("device" = deviceId, "capturedKeyEvents" = keyEvents)))
  }
  
  return(capturedKeyEvents)
}


save_experiment_captured_key_events <- function(path, devicesCapturedEvents) {
  for (deviceCapturedEvents in devicesCapturedEvents) {
    device <- deviceCapturedEvents$device
    filePath <- file.path(path, paste(device, "key-events.json", sep="-"))
    write_to_json(filePath, deviceCapturedEvents$capturedKeyEvents)
  }
}