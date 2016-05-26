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
                                            box(width=4, height=250, title="Upload .zip file", solidHeader=TRUE, background="red",
                                              HTML("<button type='button' id='resetImport' class='btn btn-warning'>Reset</button>"),
                                                fileInput("filesIn", "Import zipped data files", multiple = FALSE, accept = c(".zip") )
                                            ),
                                            uiOutput("chooseFilesSampleGroupsBox")
                                   ),
                                   tabPanel(width=12, title = "Settings",
                                            box(width=4, height=150, title="Transfer file identifier", solidHeader=TRUE, background="olive",
                                                textInput("transferPattern", "Pattern", value="Transfer")
                                            ),
                                            box(width=4, height=150, title="Compound file identifier", solidHeader=TRUE, background="olive",
                                                textInput("compoundPattern", "Pattern", value="Compound_Annotations.xls")
                                            ),
                                            box(width=4, height=150, title="Compound file identifier", solidHeader=TRUE, background="olive",
                                                textInput("pickingPattern", "Pattern", value="_pick.csv")
                                            )
                                   )
                            )
                          )
                          ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "inspect"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "output"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "report")

                )
              )




)
