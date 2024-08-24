
library(tidyverse)

function(input, output, session) {
  
  ##### Setup for TAB 1 - Monthly Data #####
  
  # Combine the selected variables into a new data frame
  selectedMonthlyData <- reactive({
    electricityusagedata::monthly_usage %>%
      filter(between(date, input$hourlyDateRange[1], input$hourlyDateRange[2])) %>%
      mutate(datetime = as.POSIXct(paste(date, start.time), format="%Y-%m-%d %H:%M:%S")) 
  })
  
  output$monthly_plot <- renderPlot({
    
    timespan <- abs(input$monthlyDateRange[1] - input$monthlyDateRange[2])
    
    mainplot <- ggplot(data=selectedHourlyData(), aes(x=datetime, y=consumption)) +
      geom_point() + 
      geom_line() + 
      theme_bw() +
      labs(x="Date", y="Consumption (Kwh)")
    
    if(timespan < 2){
      mainplot +
        scale_x_datetime(date_breaks = "2 hour", date_labels = "%R")
    }else{
      if(timespan >= 2 & timespan < 7){
        mainplot +
          scale_x_datetime(date_breaks = "1 day", date_labels="%D\n%R")
      }else{
        mainplot +
          scale_x_datetime(date_breaks = "1 week", date_labels="%D\n%R")
      }
    }
    
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
    }else{
      if(timespan >= 2 & timespan < 7){
        mainplot +
          scale_x_datetime(date_breaks = "1 day", date_labels="%D\n%R")
      }else{
        mainplot +
          scale_x_datetime(date_breaks = "1 week", date_labels="%D\n%R")
      }
    }
    
  })
  
}

