# All data processing components here


# Files already imported to database - checksums -----------
# put into reactiveValues - "variables"
variables$alreadyImported <- reactive({
  listImportedChecksums(configData[1,"dbPath"])
})







# List files available in dataset which have not yet been imported ------------------
filesToImport <- reactive({
  # give back a null if inputs are NULL
  if (is.null(input$filesIn))
    return(NULL)
  # get details of all files in zip file
  filesInZip <- zipFileContents(input$filesIn$datapath, tmpdir = tempDirectory)

  # update reactive values fir already imported files
  variables$alreadyImported <-  listImportedChecksums(configData[1,"dbPath"])

  # pass reactive value to a simple R object -
  # currently getting an error: no applicable method for 'tbl_vars' applied to an object of class "reactive"
  # when passing variables$alreadyImported directly below -  this works -- why?!
  alreadyImported <- variables$alreadyImported

  # retain only files in list which have not already been imported
  fileStatus <- left_join(filesInZip, alreadyImported) %>%
    mutate(imported=replace(imported, which(is.na(imported)), FALSE))

  #return
  fileStatus
})






# List individuals available in dataset for dropdownSampleGroups dropdown --------------------
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



# List files for an individual--------------------
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




# get first individual in dataset with unimported data -----------
firstUnimportedIndividual <- reactive({
  # give back a null if inputs are NULL
  if (is.null(filesToImport()))
    return(NULL)
  if (is.null(individualsInDataset()))
    return(NULL)
  if (is.null(input$dropdownSampleGroups))
    return(NULL)

  # get individual title from paths of all files
  groupFilesByIndividual <- filesToImport() %>%
    mutate(individual = stringr::str_split_fixed(files, "/", 3) %>% .[,2]) %>%
    group_by(individual) %>%
    summarise(unimported = !all(imported)) %>%
    arrange(individual)

  if ( !any(groupFilesByIndividual$unimported) ){
    output <- groupFilesByIndividual$individual[1]
  } else {
    output <- groupFilesByIndividual %>%
      filter(unimported) %>%
      use_series(individual) %>% .[1]
  }

  # return
  output
})





# put all file classification regexes into a data frame with the associated database table name --------------
fileClassifiers <- reactive({
  regexes <- data_frame(pattern = c(input$regexDispensingPattern, input$regexPlatePattern, input$regexLibraryPattern, input$regexAnnotationPattern),
                        type = c("dispensing", "plate", "library", "annotation"),
                        dbDataTable = c("dispensing_list", "plate_data", "library_data", "annotation_data"),
                        dbMetaTable = c("dispensing_metadata", "plate_metadata", "library_metadata", "annotation_metadata") ## FIXME
    )

  # return
  regexes
})















