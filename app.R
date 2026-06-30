library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(cluster)
library(factoextra)

# Load the data
data <- read.csv('marketing_campaign.csv', sep = "\t")

# Define UI for application
ui <- dashboardPage(
  dashboardHeader(title = "Customer Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "introduction", icon = icon("info-circle")),
      menuItem("Customer Insights", tabName = "customer_insights", icon = icon("dashboard")),
      menuItem("Conclusion", tabName = "conclusion", icon = icon("check-circle")),
      menuItem("About Me", tabName = "about_me", icon = icon("user"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "introduction",
              h2("Introduction"),
              p("Welcome to the Customer Analysis Dashboard!"),
              p("This interactive tool is designed to provide a comprehensive analysis of customer data, offering valuable insights into customer behaviors, preferences, and interactions with a company. Our aim is to delve deep into the dataset provided by Dr. Omar Romero-Hernandez, unraveling intricate patterns that drive customer segmentation and influence marketing strategies."),
              h2("Project Scope"),
              p("This project revolves around exploring various aspects of customer attributes and behaviors. Through a series of visualizations and statistical analyses, we seek to understand the relationships between customer demographics, spending habits, and responses to marketing campaigns. By leveraging advanced analytical techniques like scatter plots, heatmaps, dendrograms, and k-means clustering, we aim to uncover nuanced insights that aid in strategic decision-making."),
              h2("Exploratory Analysis"),
              p("Within the 'Customer Insights' tab, you'll find a plethora of interactive visualizations. These include scatter plots showcasing spending behaviors, heatmaps illuminating correlations between different variables, dendrograms revealing hierarchical relationships, and k-means clustering delineating customer segments."),
              h2("Conclusion"),
              p("The 'Conclusion' tab encapsulates the key takeaways derived from this analysis. It highlights the significant findings, providing a comprehensive summary of the discovered patterns and their implications for strategic planning and targeted marketing initiatives."),
              p("Join us in this exploration of customer data, as we uncover actionable insights to enhance understanding and facilitate data-driven decision-making!")
      ),
      tabItem(tabName = "customer_insights",
              h2("Customer Insights"),
              fluidRow(
                box(
                  title = "Scatter Plot",
                  plotlyOutput("scatterplot"),
                  selectizeInput("scatter_x", "X-axis:", choices = colnames(data)),
                  selectizeInput("scatter_y", "Y-axis:", choices = colnames(data)),
                  width = 12
                ),
                box(
                  title = "Heatmap",
                  plotlyOutput("heatmap"),
                  selectizeInput("heatmap_x", "X-axis:", choices = colnames(data)),
                  selectizeInput("heatmap_y", "Y-axis:", choices = colnames(data)),
                  width = 12
                )
              ),
              fluidRow(
                box(
                  title = "Dendrogram",
                  plotlyOutput("dendrogram"),
                  width = 12
                ),
                box(
                  title = "K-means Clustering",
                  plotlyOutput("kmeans"),
                  width = 12
                )
              )
      ),
      tabItem(tabName = "conclusion",
              h2("Conclusion"),
              p("It's evident that targeting individuals within the 40 to 60 age range, primarily in relationships, should be the focal point of the company's marketing endeavors. Concentrating on the income bracket of $25,000 to $75,000 seems prudent, yet there's an opportunity to explore untapped markets—consider redirecting efforts toward higher or lower income brackets. Introducing a budget-friendly section for lower-income customers or highlighting luxury items for higher-income segments could diversify the market reach."),
              p("The spotlight should remain on popular products like wine and meat, unless market saturation dictates otherwise. Exploring commodities like fish, sweets, and fruits, exhibiting strong correlations with other purchases, could offer promising market penetration. While gold purchases are substantial, emphasizing them might not be urgent given their comparable spending to other commodities and relatively lower correlation.")
      ),
      tabItem(tabName = "about_me",
              h2("Surya Deva Eada"),
              p("Hello"),
              p("I am Surya Deva Eada, a first year data science student in Chennai Mathematical Innstitute. I have done my Bachelors in Mathematics and Computer Science from the same. I have used RStudio to create this Rshiny app. My hobbies include swimming and volleyball."),
              h2("Credentials"),
              p("MOBILE : +91 7075412596"),
              p("GMAIL : surya@cmi.ac.in"),
              p("ROLL NO : MDS202323")
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Scatterplot
  output$scatterplot <- renderPlotly({
    req(input$scatter_x, input$scatter_y)
    ggplot(data, aes_string(x = input$scatter_x, y = input$scatter_y, color = "Education")) +
      geom_point() +
      labs(title = "Scatter Plot",
           x = input$scatter_x,
           y = input$scatter_y,
           color = "Education") +
      theme_minimal()
  })
  
  # Heatmap
  output$heatmap <- renderPlotly({
    req(input$heatmap_x, input$heatmap_y)
    ggplot(data, aes_string(x = input$heatmap_x, y = input$heatmap_y)) +
      geom_tile(aes(fill = MntGoldProds), color = "white") +
      scale_fill_gradient(low = "white", high = "steelblue") +
      labs(title = "Heatmap",
           x = input$heatmap_x,
           y = input$heatmap_y,
           fill = "Amount spent on gold products in last 2 years") +
      theme_minimal()
  })
  
  # Dendrogram
  output$dendrogram <- renderPlotly({
    dist <- dist(data[, c("MntWines", "MntMeatProducts", "MntGoldProds", "MntFishProducts", "MntSweetProducts", "MntFruits")])
    hc <- hclust(dist)
    plot_ly(x = hc$labels, y = hc$height, type = "scatter", mode = "lines") %>%
      layout(title = "Dendrogram",
             xaxis = list(title = "Customer ID"),
             yaxis = list(title = "Distance"))
  })
  
  # K-means clustering
  output$kmeans <- renderPlotly({
    data_cluster <- data[, c("MntWines", "MntMeatProducts", "MntGoldProds", "MntFishProducts", "MntSweetProducts", "MntFruits")]
    set.seed(123)
    k <- kmeans(data_cluster, 3)
    fviz_cluster(k, data = data_cluster, geom = "point", stand = FALSE, frame.type = "norm") +
      labs(title = "K-means Clustering",
           x = "Amount spent on wine in last 2 years",
           y = "Amount spent on meat products in last 2 years",
           color = "Cluster") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)


