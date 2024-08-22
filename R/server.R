
library(tidyverse)

function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    electricityusagedata::hourly_usage %>%
      filter(between(date, input$dateRange[1], input$dateRange[2])) %>%
      mutate(datetime = as.POSIXct(paste(date, start.time), format="%Y-%m-%d %H:%M:%S")) 
  })
  
  output$plot1 <- renderPlot({
    
    timespan <- abs(input$dateRange[1] - input$dateRange[2])
    
    mainplot <- ggplot(data=selectedData(), aes(x=datetime, y=consumption)) +
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
          scale_x_datetime(date_breaks = "1 day", date_labels="%D")
      }else{
        mainplot +
          scale_x_datetime(date_breaks = "1 week", date_labels="%D")
      }
    }
    
  })
  
}

