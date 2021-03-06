# globals for Drug Hunter
### LIBRARIES --------------------
library(shiny)
library(shinydashboard)
library(magrittr)
library(dplyr)

library(tidyr)
library(stringr)
library(tools)
library(ggplot2)
library(viridis)
library(DT)

library(RSQLite)
library(lubridate)
library(readr)
library(lazyeval)
library(drugHunteR)

# library(drugHunteR)
#library(RColorBrewer)

### GLOBAL CONSTANTS --------------------


# App config
configData <- read.dcf("data/config.dcf")




## Message placeholders
messageData <- data.frame(from=c("Test", "Admin"), message=letters[1:2])



# tmp directory for unzipping to etc
tempDirectory <- tempdir()



### DATABASE SETUP ------------------------

# standard database tables required
dbTables <- c("user", # user details
              "drug_libraries", # identifying information for library. URL, name, serial #, date etc
              "library_contents", # Relevant information about library plate
              "picking_parameters", # setup parameters for plate picking
              "picking_list", # final picking list
              "dispensing_list", # data from dispensing lists imported from robot   ******
              "dispensing_metadata", # additional data from dispensing file import  ******
              "plate_data", # standard data import from plate                       ******
              "plate_metadata", # standard metadata import from plate               ******
              "plate_types", # table of available plate types
              "compound_annotations", # annotations for compounds in libraries
              "datasets_overview", # details of datasets which have been imported
              "plate_dispensing_xref", # cross referencing plate data with the dispensing file *******
              "datasets_annotations" # further metadata for datasets
)

# Create dummy entries for all tables so that we can initiate the database and test usefully. NEED TO SET THE COLUMN NAMES CORRECTLY
# Table structure for USER table
user <- data_frame(userID="dummy", `First Name`="Dummy", `Last Name`="Ignore", location="Absurdistan")
# Table structure for DRUG_LIBRARIES table
drug_libraries <- data_frame(LibraryID="lib000", `Library Name`="Empty", `Library URL`="https://www.google.com", `Uploaded By`="dummy")
# Table structure for DRUG_LIBRARIES table
drug_libraries <- data_frame(LibraryID="lib000", `Library Name`="Empty", `Library URL`="https://www.google.com", `Uploaded By`="dummy")
# Table structure for LIBRARY_CONTENTS table
library_contents <- data_frame(LibraryID="lib000", compoundID="comp00000", `Compound Name`="Nothing", `Serial Number`="0000", `Plate Type`="None", `Well Index`="A0")
# Table structure for PLATE_TYPES table
plate_types <- data_frame(`Plate Type`="384 Greiner_781098", `Number of Rows`=16, `Number of Columns`=24, rowtype="letters", coltype="numeric")
# Table structure for PICKING_PARAMETERS table
picking_parameters <- data_frame(`PickingID`="Pick00000", `Plate Type`="384 Greiner_781098", `Number of controls`=10, `Concentrations`="1000, 100, 10, 1, 0.1")
# Table structure for PICKING_LIST table
picking_list <- data_frame(`PickingID`="Pick00000", Well="A1", Compound="comp00000", Concentration=10)
# Dispensing lists from robot
dispensing_list <- data_frame(`Source.Plate.Name`="dummy", `Source.Plate.Barcode`="dummy", `Source.Well`="dummy",
  `Destination.Plate.Name`="dummy", `Destination.Plate.Barcode`="dummy", `Destination.Well`="dummy",
  `Transfer.Volume`=0, `Actual.Volume`=0, `Current.Fluid.Volume`=0, `Fluid.Composition`=0,
  `Fluid.Units`="dummy", `Fluid.Type`="dummy", `Transfer.Status`="dummy", checksum="0")
# Dispensing meta data
dispensing_metadata <- data_frame(info="dummy", value="dummy", checksum="0", filename="dummy")
# Table structure for COMPOUND_ANNOTATIONS table
compound_annotations <- data_frame(compoundID="comp00000", Target="Nothing", `Additional Information`="Free text")
# Table structure for DATASETS_OVERVIEW table
datasets_overview <- data_frame(`SampleID`="Sample00000", `Sample name`="Something anonymous!", Classification="Healthy Donor", `Additional Information`="Free text entry of useful additional\ninfo which can potentially be parsed")
# Table structure for DATASETS table
plate_dispensing_xref <- data_frame(`files`="dummy", checksum="0", individual="dummy", dispensingFile="0")
# Table structure for DATASETS_ANNOTATIONS table
datasets_annotations <- data_frame(`SampleID`="Sample00000", Gender="M", Age=100, Genetics="chr1:000001A/T, chr1:000002A/C")
# data frame for standard data import from plate
plate_data <- data_frame(well="Z0", value=1, checksum="0", `Keep.Flag`=integer(1L))
# data frame for standard metadata import from plate
plate_metadata <- data_frame(info="dummy", value="dummy", checksum="0", filename="dummy")



# If database type is sqlite, check existence of db and create if necessary
if (configData[1,"dbType"] == "SQLite"){
  dbPath <- configData[1,"dbPath"] %>% unname()
  # If no data directory exits to house the DB, create it
  if (!dir.exists(dirname(dbPath)))
    dir.create(dirname(dbPath))
  # Initiate a SQLite DB if doesn't already exist
  local_db <- src_sqlite(path = dbPath, create = TRUE)
  # list the tables present in the db
  existingTables <- src_tbls(local_db)
  # Check which of the standard required tables are not present
  missingTables <- dbTables %w/o% existingTables

  # create missing tables in DB
  for (missingTable in missingTables){
    copy_to(dest=local_db, df=eval(as.symbol(missingTable)), temporary = FALSE, name=missingTable)
  }
}



# END DATABASE CREATION

# tidy up by removing variables from environment
rm(list = dbTables)

rm(dbTables, existingTables, missingTable, missingTables)



