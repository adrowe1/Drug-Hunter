# Observe and observeEvent elements

# Reset input file data to NULL to reinitiate upload process
observeEvent(input$resetImport, {
  # On click of reset button
  # reset values for filesIn to NULL
  input$filesIn <- NULL
})


# update dropdownSampleGroups list with available data which has not already been imported
observe({
  # FIXME if
})
