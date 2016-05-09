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
                  menuItem("Setup", tabName = "setup", icon = icon("cog")),
                  ## tab 2
                  menuItem("Prepare a screen", tabName = "prepare", icon = icon("cog")),
                  ## tab 3
                  menuItem("Import a dataset", tabName = "import", icon = icon("cog")),
                  ## tab 4
                  menuItem("Inspect a dataset", tabName = "inspect", icon = icon("th-large")),
                  ## tab 5
                  menuItem("Results", tabName = "output", icon = icon("th-large")),
                  ## tab 6
                  menuItem("Report", tabName = "report", icon = icon("magic"))
                )
              ),

              # Dashboard body -----------------
              dashboardBody(

                # tabs
                tabItems(

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "setup",
                          fluidRow(
                            box(width=12, title = "User details", solidHeader = TRUE, background="black", collapsible=FALSE, height = 180,
                                column(width=4,
                                       h3("username menu")
                                       )
                                )
                          )
                          ),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "prepare"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "import"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "inspect"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "output"),

                  # Dashboard body tab 1 -----------------
                  tabItem(tabName = "report")

                )
              )




)
