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

# Existing dispensing meta data
dbMetaDispensing <- reactive({
  # define table name
  tableName <- "dispensing_metadata"
  # read in
  dat <- readTableFromDB(configData[1,"dbPath"], tableName)
  # return
  dat
})


# Existing plate measured data
dbDataPlate <- reactive({
  # define table name
  tableName <- "plate_data"
  # read in
  dat <- readTableFromDB(configData[1,"dbPath"], tableName)
  # return
  dat
})

# Existing plate meta data
dbMetaPlate <- reactive({
  # define table name
  tableName <- "plate_metadata"
  # read in
  dat <- readTableFromDB(configData[1,"dbPath"], tableName)
  # return
  dat
})



