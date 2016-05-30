# ******************************************************************************
# ***********                   DRUG HUNTER                        *************
# ******                    ADR - Oslo, May 2016                          ******
# ******************************************************************************




# Dashboard UI --------------------

dashboardPage(skin = configData[1,"skin"],


              # Dashboard header ------------------
              dashboardHeader( title = configData[1,"title"],
                               # Header contents
                               dropdownMenuOutput("messageMenu")
                               ),

              # Dashboard sidebar -----------------
              dashboardSidebar(
                # tab menu
                sidebarMenu(
                  ## tab 1
                  menuItem("Setup", tabName = "setup", icon = icon("wrench")),
                  ## tab 2
                  menuItem("Prepare a screen", tabName = "prepare", icon = icon("cog")),
                  ## tab 3
                  menuItem("Import a dataset", tabName = "import", icon = icon("upload")),
                  ## tab 4
                  menuItem("Inspect a dataset", tabName = "inspect", icon = icon("search")),
                  ## tab 5
                  menuItem("Results", tabName = "output", icon = icon("th-large")),
                  ## tab 6
                  menuItem("Report", tabName = "report", icon = icon("file-pdf-o"))
                )
              ),

              # Dashboard body -----------------
              dashboardBody(

                # tabs
                tabItems(

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "setup",
                          fluidRow(
                            box(width=12, title = "User details", solidHeader = TRUE, background="black", collapsible=FALSE, height = 600,
                                column(width=4,
                                       h3("info")
                                       )
                                )
                          )
                          ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "prepare",
                    fluidRow(
                      tabBox(width=12,
                        title = "Prepare a screen",
                        id = "tabsPrep",
                        height = 800,
                        tabPanel(width=12, title = "Meta",
                          column(width=4,
                            dataTableOutput("existingMetaDispensing")
                          )
                        ),
                        tabPanel(width=12, title = "Dispensing",
                          column(width=12,
                            dataTableOutput("existingDataDispensing")
                          )
                        )
                      )
                    )
                    ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "import",
                          fluidRow(
                            tabBox(width=12,
                                   title = "Import Raw Data",
                                   id = "tabsPrep",
                                   height = 400,
                                   tabPanel(width=12, title = "1: Choose files",
                                            box(width=4, height=250, title="1: Upload .zip file", solidHeader=TRUE, background="red",
                                                fileInput("filesIn", "Import zipped data files", multiple = FALSE, accept = c(".zip") ),
                                                HTML("<button type='button' id='buttonResetImport' class='btn btn-default', disabled='disabled'>Reset</button>")
                                            ),
                                            uiOutput("chooseFilesSampleGroupsBox"),
                                            uiOutput("showFilesSampleGroupsBox")
                                   ),
                                   tabPanel(width=12, title = "Settings",
                                     fluidRow(
                                       box(width=12, height=50, title="Classifying file type by regular naming convention", solidHeader=TRUE, background="olive",
                                         h3("The settings below must be unique to the file name of each type of data file, and cannot exist in other file names")
                                       )
                                     ),
                                     fluidRow(
                                            box(width=3, height=150, title="Dispensing file identifier", solidHeader=TRUE, background="olive",
                                                textInput("regexDispensingPattern", "Regular expression in file name:", value="Transfer")
                                            ),
                                            box(width=3, height=150, title="Plate data file identifier", solidHeader=TRUE, background="olive",
                                                textInput("regexPlatePattern", "Regular expression in file name:", value="plate")
                                            ),
                                            box(width=3, height=150, title="Drug library identifier", solidHeader=TRUE, background="olive",
                                                textInput("regexLibraryPattern", "Regular expression in file name:", value="Selleck")
                                            ),
                                            box(width=3, height=150, title="Drug annotation identifier", solidHeader=TRUE, background="olive",
                                              textInput("regexAnnotationPattern", "Regular expression in file name:", value="annotation")
                                            )
                                     )
                                   )
                            )
                          )
                          ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "inspect",
                          fluidRow(
                            box(width=4, height=250, title="Healthy reference data", solidHeader=TRUE, background="black",
                                textInput("healthyDonorRegex", "Pattern defining healthy donors", value="healthy"),
                                selectizeInput("selectHealthyReferenceIndividuals", label="", choices = NULL, selected = NULL, multiple = TRUE)
                            ),
                            box(width=4, height=250, title="Patient data", solidHeader=TRUE, background="red",
                                selectizeInput("selectPatients", label="", choices = NULL, selected = NULL, multiple = FALSE),
                                h4("Choose a patient to view results")
                            ),
                            box(width=4, height=250, title="Drug responses", solidHeader=TRUE, background="black",
                                radioButtons("radioDisplayDrugResponses", "View drugs by",
                                             choices = c("Performance order" = "sorted",
                                                         "Search" = "search"), inline = TRUE),
                                # condition == sorted
                                conditionalPanel(
                                  condition = "input.radioDisplayDrugResponses == 'sorted'",
                                  numericInput("numberDrugsPlotPerformance", "Number of drugs to show together", value = 12, min=1, max=48), # arbitrary values chosen here
                                  sliderInput("slideThroughDrugList", "scroll through list", min=1, max=384, value=1, step=1) # arbitrary values.. fix with observe updates and finally replace with interactive waterfall plot
                                  ),
                                # condition == search
                                conditionalPanel(
                                  condition = "input.radioDisplayDrugResponses == 'search'",
                                  selectizeInput("selectDrugs", label="", choices = NULL, selected = NULL, multiple = FALSE)
                                )
                            )
                          ),
                          fluidRow(
                            box(width=12, height = 800, title = "Drug Responses", solidHeader = TRUE, background = "black")
                          )
                        ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "output"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "report")

                )
              )




)
