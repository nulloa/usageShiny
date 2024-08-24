
minHourDate <- min(electricityusagedata::hourly_usage$date)
maxHourDate <- max(electricityusagedata::hourly_usage$date)

fluidPage(
  # Main Title
  titlePanel("Hourly Electricity Usage Data."),
  
  # Set Color/Font Scheme/Theme
  # theme = shinythemes::shinytheme("lumen"),
  
  # Setup TABs
  tabsetPanel(
    # TAB 1
    tabPanel("Monthly Usage",
             fluidRow(
               column(4,
                      dateRangeInput('dateRange',
                                     label = 'Choose a date. (yyyy-mm-dd)',
                                     start = as.Date("2024-08-01") - 1, 
                                     end = as.Date("2024-08-01") + 1,
                                     min = mindate,
                                     max = maxdate
                      )
               )),
             
             plotOutput('plot1')
    ),
    # TAB 2
    tabPanel("Monthly Usage",
             fluidRow(
               column(4,
                      dateRangeInput('hourlyDateRange',
                                     label = 'Choose a date. (yyyy-mm-dd)',
                                     start = as.Date("2024-08-01") - 1, 
                                     end = as.Date("2024-08-01") + 1,
                                     min = minHourDate,
                                     max = maxHourDate
                      )
               )),
             
             plotOutput('hourly_plot')
    )
  )
)




