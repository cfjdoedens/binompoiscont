library(shiny)
library(ggplot2)
library(binompoiscont) # Your package

ui <- fluidPage(
  titlePanel("Continuous Binomial & Poisson Visualization"),

  sidebarLayout(
    sidebarPanel(
      selectInput("dist", "Choose Distribution:",
                  choices = c("Binomial" = "binom", "Poisson" = "pois")),

      # Binomial Inputs
      conditionalPanel(
        condition = "input.dist == 'binom'",
        sliderInput("n", "Trials (n):", min = 1, max = 400, value = 10),
        sliderInput("p", "Probability (p):", min = 0, max = 1, value = 0.5, step = 0.05)
      ),

      # Poisson Inputs
      conditionalPanel(
        condition = "input.dist == 'pois'",
        sliderInput("lambda", "Rate (lambda):", min = 0.1, max = 400, value = 5, step = 0.5)
      ),

      hr(),
      checkboxInput("show_discrete", "Show Standard Discrete (Bars)", value = TRUE)
    ),

    mainPanel(
      plotOutput("distPlot"),
      verbatimTextOutput("desc")
    )
  )
)

server <- function(input, output) {

  output$distPlot <- renderPlot({

    # Generate X sequence for smooth curve
    if (input$dist == "binom") {
      x_seq <- seq(0, input$n, length.out = 200)
      y_cont <- dbinom_continuous(x_seq, n = input$n, p = input$p)

      # For discrete bars
      k_seq <- 0:input$n
      y_disc <- dbinom(k_seq, size = input$n, prob = input$p)

    } else {
      # Poisson range logic
      max_val <- qpois(0.999, lambda = input$lambda)
      x_seq <- seq(0, max_val, length.out = 200)
      y_cont <- dpois_continuous(x_seq, lambda = input$lambda)

      k_seq <- 0:max_val
      y_disc <- dpois(k_seq, lambda = input$lambda)
    }

    # Plotting
    p <- ggplot() +
      geom_line(aes(x = x_seq, y = y_cont, color = "Continuous"), linewidth = 1.2) +
      labs(title = paste("Continuous", input$dist, "Distribution"),
           y = "Density", x = "k") +
      theme_minimal()

    if (input$show_discrete) {
      p <- p + geom_col(aes(x = k_seq, y = y_disc, fill = "Discrete"), alpha = 0.3, width = 0.2)
    }

    p
  })

  output$desc <- renderText({
    paste("Visualizing", input$dist, "distribution.")
  })
}

shinyApp(ui = ui, server = server)
