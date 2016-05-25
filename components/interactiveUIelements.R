# interactive UI elements






# box for describing the groupings of zip file contents ----------
output$chooseFilesSampleGroupsBox<- renderUI({
  if (is.null(input$filesIn)) {
    box(width=4, height=150, title="Sample groups", solidHeader=TRUE, background="navy",
        h3("test")
    )
  } else {
    box(width=4, height=150, title="Sample groups", solidHeader=TRUE, background="blue",
        h3("test2")
    )
  }
})
