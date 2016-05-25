# ******************************************************************************
# ***********                   DRUG HUNTER                        *************
# ******                    ADR - Oslo, May 2016                          ******
# ******************************************************************************




shinyServer(function(input, output, session) {

  # Extract initial values from database ---------------------

  source('components/extractFromDatabase.R', local=TRUE)













  # Table outputs ------------------------

  source('components/tableOutputs.R', local=TRUE)





  # Interactive UI outputs ------------------------

  source('components/interactiveUIelements.R', local=TRUE)








})
