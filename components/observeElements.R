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



  # refresh contents of dropdowns by calling filesInIndividual() - this should work, but is strictly speaking an ugly hack.
  # FIXME this is not having the desired effect
  if (is.null(filesInIndividual()))
    return(NULL)
  choices <- filesInIndividual() %>% filter(imported==FALSE) %>% use_series(files) %>% basename
  updateSelectInput(session, "dropdownIndividualImports", choices = choices )
})















# Observe elements ---------------------------

# update dropdownSampleGroups list with available data which has not already been imported
observe({
  if (is.null(individualsInDataset()))
    return(NULL)
  updateSelectInput(session, "dropdownSampleGroups", choices = individualsInDataset() )
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
