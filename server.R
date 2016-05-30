# ******************************************************************************
# ***********                   DRUG HUNTER                        *************
# ******                    ADR - Oslo, May 2016                          ******
# ******************************************************************************




shinyServer(function(input, output, session) {

  # Reactive values
  variables <- reactiveValues()
  # initial values
  variables$alreadyImported <-  listImportedChecksums(configData[1,"dbPath"])


  # Extract values from database ---------------------

  source('components/extractFromDatabase.R', local=TRUE)


  # Process data for UI components ------------------

  source('components/dataProcessing.R', local=TRUE)


  # Table outputs ------------------------

  source('components/tableOutputs.R', local=TRUE)


  # Interactive UI outputs ------------------------

  source('components/interactiveUIelements.R', local=TRUE)


  # Interactivity observe and observeEvent calls -------

  source('components/observeElements.R', local=TRUE)


  # Extract imported data from database -------

  source('components/extractResultsFromDatabase.R', local=TRUE)


})
