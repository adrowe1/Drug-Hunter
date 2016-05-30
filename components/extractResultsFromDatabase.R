# Get data from database

databaseImportedIndividuals <- reactive({
  # read all individuals from database
  inp <- readTableFromDB(configData[1,"dbPath"], "plate_dispensing_xref") %>%
    filter(individual != "dummy")

  allIndividuals <- inp$individual %>% unique %>% sort

  # return
  allIndividuals
})


databaseSuggestedHealthy <- reactive({
  if (is.null(databaseImportedIndividuals()))
    return(NULL)
  # match imported individuals with regex to automatically include these in healthy set..
  matchingIndividuals <- databaseImportedIndividuals() %>% grep(input$healthyDonorRegex, ., value = TRUE)

  # return
  matchingIndividuals
})


databaseExcludingHealthy <- reactive({
  if (is.null(databaseImportedIndividuals()))
    return(NULL)
  # remainder of individuals in DB
  databaseImportedIndividuals() %w/o% input$selectHealthyReferenceIndividuals
})
