# observeEvent elements --------------------------

# Reset input file data to NULL to reinitiate upload process - buttonResetImport
observeEvent(input$buttonResetImport, {
  # On click of reset button
  # reset values for filesIn to NULL
  input$filesIn <- NULL
})



# Import data files
observeEvent(input$buttonDatasetImport, {
  # On click of import button
  # check whether to import all or single
  if (input$radioSingleAllImport == "single"){
    # import file selected in input$dropdownIndividualImports
    choices <- input$dropdownIndividualImports
  } else if(input$radioSingleAllImport == "all"){
    # import all files in list
    choices <- filesInIndividual() %>% filter(imported==FALSE) %>% use_series(files) %>% basename
  }
  # write to DB
  putChosenFilesIntoDatabase(choices, input$dropdownSampleGroups, fileClassifiers(), configData[1,"dbPath"], input$filesIn$datapath, tmpdir = tempDirectory)

  # create an overview of files imported

  # get the data for the chosen individual - input$dropdownSampleGroups and build link-references for dispensing and plates
  dispensingFile <- filesToImport() %>%
    dplyr::filter(grepl(input$dropdownSampleGroups, files)) %>%
    dplyr::filter(grepl(input$regexDispensingPattern, files)) %>%
    use_series(checksum)

  filesToLink <- filesToImport() %>% #
    dplyr::filter(grepl(input$dropdownSampleGroups, files)) %>%
    dplyr::filter(!grepl(input$regexDispensingPattern, files)) %>%
    mutate(individual = input$dropdownSampleGroups) %>%
    mutate(dispensingFile = dispensingFile) %>%
    select(-imported)



  # write directly to recording table in DB
  writeTableToDB(configData[1,"dbPath"], "plate_dispensing_xref", filesToLink)

  # update reactive values for already imported files
  variables$alreadyImported <-  listImportedChecksums(configData[1,"dbPath"])

})















# Observe elements ---------------------------

# update dropdownSampleGroups list with available data which has not already been imported
observe({
  if (is.null(individualsInDataset()))
    return(NULL)
  # FIXME get the next choice in the list ( if it exists ) and set as selected, allowing continuous clickthrough importing  -  replacing input$dropdownSampleGroups
  updateSelectInput(session, "dropdownSampleGroups", choices = individualsInDataset(), selected = firstUnimportedIndividual() )
})




# update dropdownIndividualImports list with available data which has not already been imported
observe({
  # take a dependency on the sample choice dropdown
  input$dropdownSampleGroups # FIXME this is not having the desired effect

  if (is.null(filesInIndividual()))
    return(NULL)
  choices <- filesInIndividual() %>% filter(imported==FALSE) %>% use_series(files) %>% basename
  updateSelectInput(session, "dropdownIndividualImports", choices = choices )
})









# Update items on inspect dataset tab -----------------------------
observe({
  if (is.null(databaseSuggestedHealthy()))
    return(NULL)

  # write to selectize
  updateSelectInput(session, "selectHealthyReferenceIndividuals", choices = databaseImportedIndividuals(), selected = databaseSuggestedHealthy() )

  # update list of patients to choose from
  updateSelectInput(session, "selectPatients", choices = databaseExcludingHealthy(), selected = databaseExcludingHealthy()[1] )
})





