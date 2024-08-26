library(tidyverse)

dateRangeInput2 <- function(inputId, label, minview = "days", maxview = "decades", ...) {
  d <- shiny::dateRangeInput(inputId, label, ...)
  d$children[[2L]]$children[[1]]$attribs[["data-date-min-view-mode"]] <- minview
  d$children[[2L]]$children[[3]]$attribs[["data-date-min-view-mode"]] <- minview
  d$children[[2L]]$children[[1]]$attribs[["data-date-max-view-mode"]] <- maxview
  d$children[[2L]]$children[[3]]$attribs[["data-date-max-view-mode"]] <- maxview
  d
}


minHourDate <- min(electricityusagedata::hourly_usage$date)
maxHourDate <- max(electricityusagedata::hourly_usage$date)

tmp <- electricityusagedata::monthly_usage %>%
  unite(date, year, month, sep="-", remove=FALSE) %>%
  mutate(date = as.Date(paste0(date,"-01")))
  
minMonthDate <- min(tmp$date)
maxMonthDate <- max(tmp$date)


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
                      dateRangeInput2('monthlyDateRange',
                                      label = 'Choose a date. (yyyy-mm)',
                                      start = as.Date("2024-07-01"), 
                                      end = as.Date("2024-08-01"),
                                      format = "yyyy-mm",
                                      min = minMonthDate,
                                      max = maxMonthDate,
                                      minview="months",
                                      maxview = "decades"
                      )
               ),
               column(4,
                      selectInput('yvar',
                                  label = 'Response Variable',
                                  choices = c("ratekWh","kWh_used"),
                                  selected = NULL,
                                  multiple = FALSE,
                                  selectize = TRUE,
                                  width = NULL,
                                  size = NULL
                      )
               )),
             
             plotOutput('monthly_plot')
    ),
    # TAB 2
    tabPanel("Hourly Usage",
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




