iterations_limit <- function(experimentCapturedKeyEvents) {
  limit <- length(experimentCapturedKeyEvents[[1]]$capturedKeyEvents)
  for (i in 2:length(experimentCapturedKeyEvents)) {
    current <- length(experimentCapturedKeyEvents[[i]]$capturedKeyEvents)
    if (current < limit) {
      limit <- current
    }
  }
  
  return(limit)
}


count_captured_key_events <- function(capturedKeyEvents, keyEventsNames, limit) {
  eventCount <- c(0,0,0,0,0,0,0,0,0,0)
  names(eventCount) <- keyEventsNames
  
  i <- 0
  for (iterationEvents in capturedKeyEvents) {
    events <- iterationEvents$keyEvents
    for (keyEventName in names(events)) {
      eventCount[keyEventName] = eventCount[keyEventName] + events[keyEventName]
    }
    
    i <- i + 1
    if (i == limit) {
      break
    }
  }
  
  return(eventCount)
}


count_total_key_events_for_devices <- function(experimentCapturedKeyEvents, keyEventsNames) {
  totalKeyEvents = list()
  
  limit <- iterations_limit(experimentCapturedKeyEvents)
  
  for (deviceCapturedEvents in experimentCapturedKeyEvents) {
    deviceId <- deviceCapturedEvents$device
    keyEventsCount <- count_captured_key_events(deviceCapturedEvents$capturedKeyEvents, keyEventsNames, limit)
    totalKeyEvents <- append(totalKeyEvents, list(list("device" = deviceId, "totalKeyEvents" = keyEventsCount)))
  }
  
  return(list("totalKeyEvents" = totalKeyEvents, "nIterations" = limit))
}


total_expected_key_events <- function(expectedKeyEventsPerIteration, nIterations) {
  totalExpectedEvents <- c(0,0,0,0,0,0,0,0,0,0)
  names(totalExpectedEvents) <- names(expectedKeyEventsPerIteration)
  
  for (eventName in names(expectedKeyEventsPerIteration)) {
    totalExpectedEvents[[eventName]] = expectedKeyEventsPerIteration[[eventName]] * nIterations
  }
  
  return(totalExpectedEvents)
}


lost_key_events_percentage <- function(deviceTotalEventsCount, totalExpectedKeyEvents) {
  lost_percentage <- c(0,0,0,0,0,0,0,0,0,0)
  names(lost_percentage) <- names(deviceTotalEventsCount)
  
  for (eventName in names(deviceTotalEventsCount)) {
    lost_percentage[[eventName]] <- (totalExpectedKeyEvents[[eventName]] - deviceTotalEventsCount[[eventName]]) / totalExpectedKeyEvents[[eventName]] * 100
  }
  
  return(lost_percentage)
}


total_lost_key_events_percentage <- function(experimentTotalEventsCount, totalExpectedKeyEvents) {
  lost_percentage = list()
  
  for (deviceTotalEventCount in experimentTotalEventsCount) {
    device <- deviceTotalEventCount$device
    device_lost_percentage <- lost_key_events_percentage(deviceTotalEventCount$totalKeyEvents, totalExpectedKeyEvents)
    lost_percentage <- append(lost_percentage, list(list("device" = device, "lost_percentage" = device_lost_percentage)))
  }
  
  return(lost_percentage)
}