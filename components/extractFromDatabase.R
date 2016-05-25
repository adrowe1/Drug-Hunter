# Extract initial values from database ---------------------

# Existing dispensing file data
dbDataDispensing <- reactive({
  # define table name
  tableName <- "dispensing_list"
  # read in
  dat <- readTableFromDB(configData[1,"dbPath"], tableName)
  # return
  dat
})

# Existing dispensing file data
dbMetaDispensing <- reactive({
  # define table name
  tableName <- "dispensing_metadata"
  # read in
  dat <- readTableFromDB(configData[1,"dbPath"], tableName)
  # return
  dat
})
