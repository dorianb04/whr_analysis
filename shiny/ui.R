library(shiny)
library(shinydashboard)
library(highcharter)
library(shinythemes)
library(plotly)


dashboardPage(
  skin = "purple",
  dashboardHeader(
    title = "World Hapiness Report", titleWidth = 300
  ),
  dashboardSidebar(
    width = 300, 
    sidebarMenu(
      tags$style(
        "#sidebarItemExpanded {
            position: fixed;
        }"
      ),
      menuItem("Carte du monde", tabName = "Carte", icon = icon("dashboard")),
      menuItem("Dans le monde", tabName = "scatter", icon = icon("th")),
      menuItem("Par région", tabName = "ByRegion", icon = icon("th")),
      menuItem("Par pays", tabName = "ByCountry", icon = icon("th"))
    ),
    
    selectInput('annee',
                'Sélectionner une année',
                choices = c(2015,2016,2017, 2018,2019,2020),
                selected = 2015)
    
    
    
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "Carte",
        fluidRow(
          box(selectInput('carteselect',
                          'Sélectionner la donnée à afficher',
                          choices = c('Score de bonheur','Score de PIB','Score de corruption', 'Score de générosité','Score de liberté', 'Score social', "Score d'espérance de vie"),
                          selected = c('Score de bonheur')),),
          tabPanel(
            'Bonheur dans le monde',
            highchartOutput('chart')
          )
        ),
      ),
      tabItem(
        tabName = "GDP",
        h2('GPD/Generosity'),
      ),
      
      tabItem(
        tabName = "Happiness",
        h2('Happiness/Generosity'),
        tabPanel("plot", plotlyOutput("plotHappiness"))
      ),
      tabItem(
        tabName = "bubblescat_Social_GDP",
        h2('bubblescat_Social_GDP'),
      ),
      
      tabItem(
        tabName = "scatter",
        fluidRow(
          box(selectInput('abs',
                          'Sélectionner une abs',
                          choices = c('Score de bonheur','Score de PIB','Score de corruption', 'Score de générosité','Score de liberté', 'Score social', "Score d'espérance de vie"),
                          selected = c('Score de PIB')),),
          
          box(selectInput('ord',
                          'Sélectionner une ord',
                          choices = c('Score de bonheur','Score de PIB','Score de corruption', 'Score de générosité','Score de liberté', 'Score social', "Score d'espérance de vie"),
                          selected = c('Score de générosité')),),
          box(plotlyOutput('plotbubblescat'), width = 12
          ),
          box(plotlyOutput("plotGDP"), width = 12          
          ), 
          box(plotlyOutput('plotscatt'), width = 12
              
          ),
        ),
        
        
      ),
      tabItem(
        tabName = "Life_Expectancy",
        h2('Life_Expectancy/GDP'),
        tabPanel("plot", plotlyOutput('plotLifeExp'))
      ),
      tabItem(
        tabName = "ByRegion",
        fluidRow(
          
          box(plotlyOutput('plotHappinessByRegion'),  width = 12
          ),
          box(plotOutput('plotHappinessByRegionBis'), width = 12
          ),
          
        ),
        
      ),
      
      tabItem(
        tabName = "BarPlotByRegion",
        h2('Bar plot by region'),
        tabPanel("plot", plotOutput('plotBarRegion'))
      ),
      
      tabItem(
        tabName = "ByCountry",
        fluidRow(
          box(selectInput('region',
                          'Sélectionner une region',
                          choices = c('Western Europe','North America and ANZ', 'Latin America and Caribbean',
                                      'Middle East and Northern Africa','Central and Eastern Europe', 'Sub-Saharan Africa',
                                      'Southeastern Asia', 'Southern Asia', 'Eastern Asia'),
                          selected = c('Middle East and Northern Africa')),),
          box(selectInput('selectbyCountry',
                          'Sélectionner une données à afficher',
                          choices = c('Score de bonheur','Score de PIB','Score de corruption', 'Score de générosité','Score de liberté', 'Score social', "Score d'espérance de vie"),
                          selected = c('Score de PIB')),),
          
          box(fluidRow(
            tabPanel("plot", plotlyOutput('ByCountry'))
          ),width = 12),
          
          
          box(sliderInput("nbCountry", "Nombre de pays",
                          min = 0, max = 54, value = 8
          ),),
          box(fluidRow(
            plotlyOutput('LineChartRegion')
          ),width = 12),
          
          box(selectInput('selecttreemap',
                          'Sélectionner une données à afficher pour la taille',
                          choices = c('Score de bonheur', 'Score de générosité','Score de liberté', 'Score social', "Score d'espérance de vie"),
                          selected = c('Score de bonheur')),),
          
          box(fluidRow(
            tabPanel("plot", plotOutput('treemap'))
          ),width = 12),
          
          
        ),
      ),
      
      tabItem(
        tabName = "roundBar",
        h2('roundBar'),
        
        tabPanel("plot", plotOutput('roundbar'))
      )
    )
    # Boxes need to be put in a row (or column)
  )
)




