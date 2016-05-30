# interactive UI elements






# box for describing the groupings of zip file contents ----------
output$chooseFilesSampleGroupsBox<- renderUI({
  if (is.null(input$filesIn)) {
    box(width=4, height=250, title="2: Individuals in dataset", solidHeader=TRUE, background="black",
        h4("select a zip file in the first step")
    )
  } else {
    bkg <- "green"
    infoString <- ""
    # if all files in dataset imported, set a new colour and a text string to inform
    if( all(filesInIndividual()$imported) ){
      bkg <- "black"
      infoString <- "All files have been imported"
    }
    # create box
    box(width=4, height=250, title="2: Individuals in dataset", solidHeader=TRUE, background=bkg,
        selectInput("dropdownSampleGroups", "Choose individual to import", choices=NULL, selected = NULL, multiple = FALSE,
          selectize = TRUE, width = NULL, size = NULL),
        h4(infoString)
    )
  }
})


# box for showing the contents of a single group in the zip file contents ----------
output$showFilesSampleGroupsBox <- renderUI({
  if (is.null(input$filesIn)) {
    box(width=4, height=250, title="3: Individual dataset", solidHeader=TRUE, background="black",
        h4("select a zip file in the first step")
    )
  } else if ( all(filesInIndividual()$imported) ) {
    box(width=4, height=250, title="3: Individual dataset", solidHeader=TRUE, background="black",
        h4("all files imported")
    )
  } else {
    box(width=4, height=250, title="3: Individual dataset", solidHeader=TRUE, background="green",
        selectInput("dropdownIndividualImports", "Choose file to import", choices=NULL, selected = NULL, multiple = FALSE,
                    selectize = TRUE, width = NULL, size = NULL),
        # radio button to choose whether to import all or individually
        radioButtons("radioSingleAllImport", "Import singly or all", choices = c("single", "all"), selected = "all", inline = TRUE),
        # button to import chosen file(s)
        #HTML("<button type='button' id='buttonDatasetImport' class='btn btn-primary'>Import</button>")
      actionButton("buttonDatasetImport", "Import!")
        # h3("FIXME button to import - classify each file correctly by settings regex and put in correct table")
    )
  }
})
