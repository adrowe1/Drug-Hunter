# All data processing components here




# List files available in dataset which have not yet been imported
filesToImport <- reactive({
  # give back a null if inputs are NULL
  if (is.null(input$filesIn))
    return(NULL)
  # get details of all files in zip file
  filesInZip <- zipFileContents(input$filesIn)

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





# FIXME
# # List individuals available in dataset for dropdownSampleGroups dropdown
# individualsinDataset <- reactive({
#   # give back a null if inputs are NULL
#   if (is.null(input$filesIn))
#     return(NULL)
#   filesToImport()
# list of data groups
# allIndividuals <- allFiles %>%
#   stringr::str_split_fixed("/", 3) %>%
#   .[,2] %>%
#   unique
# })

