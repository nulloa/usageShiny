
mindate <- min(electricityusagedata::hourly_usage$date)
maxdate <- max(electricityusagedata::hourly_usage$date)

fluidPage(
  titlePanel("Hourly Electricity Usage Data."),
  
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
)




