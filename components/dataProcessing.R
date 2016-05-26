# All data processing components here




# List files available in dataset which have not yet been imported
filesToImport <- reactive({
  # give back a null if inputs are NULL
  if (is.null(input$filesIn))
    return(NULL)
  # get details of all files in zip file
  filesInZip <- zipFileContents(input$filesIn$datapath)

  # get list of all checksums in imported dispensing files
  SQLquery <- "SELECT DISTINCT checksum FROM dispensing_metadata"
  importedDispensing <- queryDB("data/local_db.sqlite3", SQLquery)

  # get list of all checksums in imported data files
  SQLquery <- "SELECT DISTINCT checksum FROM plate_metadata"
  importedPlate <- queryDB("data/local_db.sqlite3", SQLquery)

  # already imported checksums
  alreadyImported <- bind_rows(importedDispensing, importedPlate) %>% mutate(imported=TRUE)

  # retain only files in list which have not already been imported
  fileStatus <- left_join(filesInZip, alreadyImported) %>%
    mutate(imported=replace(imported, which(is.na(imported)), FALSE))

  #return
  fileStatus
})






# List individuals available in dataset for dropdownSampleGroups dropdown
individualsInDataset <- reactive({
  # give back a null if inputs are NULL
  if (is.null(filesToImport()))
    return(NULL)
  # get individual title from paths of all files
  allIndividuals <- filesToImport()$files %>%
  stringr::str_split_fixed("/", 3) %>%
  .[,2] %>%
  unique
  # return
  allIndividuals
})



# List files for an individual
filesInIndividual <- reactive({
  # give back a null if inputs are NULL
  if (is.null(individualsInDataset()))
    return(NULL)
  if (is.null(input$dropdownSampleGroups))
    return(NULL)

  # get the data for the chosen chosen individual - input$dropdownSampleGroups
  output <- filesToImport() %>%
    dplyr::filter(grepl(input$dropdownSampleGroups, files)) %>%
    select(-checksum)

  # return
  output
})
























