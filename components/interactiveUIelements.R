# interactive UI elements






# box for describing the groupings of zip file contents ----------
output$chooseFilesSampleGroupsBox<- renderUI({
  if (is.null(input$filesIn)) {
    box(width=4, height=250, title="2: Individuals in dataset", solidHeader=TRUE, background="navy",
        h4("select a zip file in the previous step")
    )
  } else {
    box(width=4, height=250, title="2: Individuals in dataset", solidHeader=TRUE, background="blue",
        selectInput("dropdownSampleGroups", "Choose individual to import", choices=NULL, selected = NULL, multiple = FALSE,
          selectize = TRUE, width = NULL, size = NULL)
    )
  }
})
