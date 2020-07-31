library(shiny)
source('myfunc.R')

ui <- fluidPage(
  titlePanel('Exponential Function'),
  
  sidebarLayout(
    sidebarPanel(
      
      # input slider for coefficient k:
      sliderInput('coeff',
                  'coefficient of exponential k',
                  min = 0,
                  max = 2,
                  value = 1,
                  step = 0.1),
      helpText('This parameter changes the growth speed of the exponential function.'),
      
      br(),
      
      # checkbox for logarithmic scale:
      checkboxInput('log',
                    'logarithmic scale',
                    value = FALSE),
      helpText('Change the y-Axis from linear to logarithmic')
    ),
    
    mainPanel(
      plotOutput("expPlot")
    )
  )
)

server <- function(input, output) {
  
  #create plot:
  output$expPlot <- renderPlot({
    
    k <- input$coeff
    x <- seq(-1, 10, 0.1)
    
    #create string for parameter 'log' in plot():
    if (input$log) logString <- 'y'
    else logString <- ''
    
    plot(x,
         myfunc(k, x),
         type = 'l',
         log = logString)
  })
}

shinyApp(ui = ui, server = server)