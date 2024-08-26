
library(tidyverse)

function(input, output, session) {
  
  ##### Setup for TAB 1 - Monthly Data #####
  
  # Combine the selected variables into a new data frame
  selectedMonthlyData <- reactive({
    electricityusagedata::monthly_usage %>%
      unite(date, year, month, sep="-", remove=FALSE) %>%
      mutate(date = as.Date(paste0(date,"-01"))) %>%
      filter(between(date, as.Date(paste0(input$monthlyDateRange[1],"-01")), as.Date(paste0(input$monthlyDateRange[2],"-01"))))
  })
  
  output$monthly_plot <- renderPlot({
    
    ggplot(data=selectedMonthlyData(),
           aes_string(x='date', y=input$yvar, color='usage_timing', shape='season', group='usage_timing')) +
      geom_point(size=3) +
      # geom_line() +
      theme_bw() +
      labs(x="Date", y=as.character(input$yvar), color="Timing", shape="Season") +
      scale_x_date(date_breaks = "3 months", date_minor_breaks = "1 month", date_labels = "%m-%Y")
    
  })
  
  
  
  
  
  ##### Setup for TAB 2 - Hourly Data #####
  
  # Combine the selected variables into a new data frame
  selectedHourlyData <- reactive({
    electricityusagedata::hourly_usage %>%
      filter(between(date, input$hourlyDateRange[1], input$hourlyDateRange[2])) %>%
      mutate(datetime = as.POSIXct(paste(date, start.time), format="%Y-%m-%d %H:%M:%S")) 
  })
  
  output$hourly_plot <- renderPlot({
    
    timespan <- abs(input$hourlyDateRange[1] - input$hourlyDateRange[2])
    
    mainplot <- ggplot(data=selectedHourlyData(), aes(x=datetime, y=consumption)) +
      geom_point() + 
      geom_line() + 
      theme_bw() +
      labs(x="Date", y="Consumption (Kwh)")
    
    if(timespan < 2){
      mainplot +
        scale_x_datetime(date_breaks = "2 hour", date_labels = "%R")
    }else if(timespan >= 2 & timespan < 7){
        mainplot +
          scale_x_datetime(date_breaks = "1 day", date_labels="%D\n%R")
    }else if(timespan >=7 & timespan < 45){
      mainplot +
          scale_x_datetime(date_breaks = "1 week", date_labels="%D\n%R")
    }else{
      mainplot +
        scale_x_datetime(date_breaks = "1 month", date_labels="%D")
    }
    
  })
  
}

