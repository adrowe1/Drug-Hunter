# Table outputs ------------------------

# Existing dispensing file data output to table
output$existingDataDispensing <- renderDataTable(dbDataDispensing())

# Existing dispensing meta data output to table
output$existingMetaDispensing <- renderDataTable(dbMetaDispensing())
