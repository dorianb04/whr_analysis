library(plotly)
library(shiny)
library(dplyr)
library(tidyverse)
library(highcharter)
library(gganimate)


library(ggrepel)
library(ggridges)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggrepel)
library(tidyverse)
library(gganimate)
library(corrplot)
library(treemap)
library(highcharter) 
library(ggstatsplot)
library(fmsb)
library(gapminder)

###

###def option highcharter
options(highcharter.theme = hc_theme_smpl(tooltip = list(valueDecimals = 2)))

### Clean data
setwd("..")

df2015<- read.csv('data/2015.csv')
df2016<- read.csv('data/2016.csv')
df2017<- read.csv('data/2017.csv')
df2018<- read.csv('data/2018.csv')
df2019<- read.csv('data/2019.csv')
df2020<- read.csv('data/2020.csv')
df2021<- read.csv('data/2021.csv')


### remplacer United States par United States of America
df2015 <- replace(df2015, df2015 == 'United States','United States of America' )
df2016 <- replace(df2016, df2016 == 'United States','United States of America' )
df2017 <- replace(df2017, df2017 == 'United States','United States of America' )
df2018 <- replace(df2018, df2018 == 'United States','United States of America' )
df2019 <- replace(df2019, df2019 == 'United States','United States of America' )
df2020 <- replace(df2020, df2020 == 'United States','United States of America' )
df2021 <- replace(df2021, df2021 == 'United States','United States of America' )








### Normalisation du GDP_Score
df2015$Economy..GDP.per.Capita.<-scale(df2015$Economy..GDP.per.Capita.)
df2015$Trust..Government.Corruption.<-scale(df2015$Trust..Government.Corruption.)

### Changement des noms des colonnes
colnames(df2015) <- c('Country', 'Region', 'Happiness_Rank', 'Happiness_Score', 'ste_Happiness_Score', 'GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Corruption_Score', 'Generosity_Score', 'Dystopia_Residual')


### Faire en sorte d'avoir les m?mes r?gions
for (i in 1:nrow(df2015)){
  if (df2015$Region[i] %in% c("North America", "Australia and New Zealand")){
    df2015$Region[i] <- "North America and ANZ"
  }
}

df2016$Economy..GDP.per.Capita.<-scale(df2016$Economy..GDP.per.Capita.)
df2016$Trust..Government.Corruption.<-scale(df2016$Trust..Government.Corruption.)

colnames(df2016) <- c('Country', 'Region', 'Happiness_Rank', 'Happiness_Score','LCI_Happiness_Score','UCI_Happiness_Score', 'GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Corruption_Score', 'Generosity_Score', 'Dystopia_Residual')

regions <- c()
for (i in df2016$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2016$Region <- regions

df2017$Economy..GDP.per.Capita.<-scale(df2017$Economy..GDP.per.Capita.)
df2017$Trust..Government.Corruption.<-scale(df2017$Trust..Government.Corruption.)


df2017[df2017$Country == 'Hong Kong S.A.R., China',]$Country <- 'Hong Kong'
df2017[df2017$Country == 'Taiwan Province of China',]$Country <- 'Taiwan'

regions <- c()
for (i in df2017$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2017$Region <- regions

colnames(df2017) <- c('Country', 'Happiness_Rank', 'Happiness_Score','UCI_Happiness_Score','LCI_Happiness_Score', 'GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Generosity_Score', 'Corruption_Score', 'Dystopia_Residual', 'Region')

df2018$GDP.per.capita<-scale(df2018$GDP.per.capita)
df2018$Perceptions.of.corruption<-scale(as.numeric(df2018$Perceptions.of.corruption))

regions <- c()
for (i in df2018$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2018$Region <- regions

colnames(df2018) <- c('Happiness_Rank', 'Country', 'Happiness_Score', 'GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Generosity_Score', 'Corruption_Score', 'Region')

df2019$GDP.per.capita<-scale(df2019$GDP.per.capita)
df2019$Perceptions.of.corruption<-scale(df2019$Perceptions.of.corruption)
regions <- c()
for (i in df2019$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2019$Region <- regions

colnames(df2019) <- c('Happiness_Rank', 'Country', 'Happiness_Score', 'GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Generosity_Score', 'Corruption_Score', 'Region')

df2020$Healthy.life.expectancy<-(df2020$Healthy.life.expectancy/100)
df2020$Logged.GDP.per.capita<-scale(df2020$Logged.GDP.per.capita)
df2020$Perceptions.of.corruption<-scale(1-df2020$Perceptions.of.corruption)

colnames(df2020) <- c('Country', 'Region', 'Happiness_Score', 'ste_Happiness_Score', 'UCI_Happiness_Score','LCI_Happiness_Score','GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Generosity_Score', 'Corruption_Score', 'Dystopia_Score', 'Exp_GDP', 'Exp_Social', 'Exp_Life_Expectancy', 'Exp_Freedom', 'Exp_Generosity', 'Exp_Corruption', 'Dystopia_Residual')

regions <- c()
for (i in df2020$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2020$Region <- regions

df2021$Healthy.life.expectancy<-(df2021$Healthy.life.expectancy/100)
df2021$Logged.GDP.per.capita<-scale(df2021$Logged.GDP.per.capita)
df2021$Perceptions.of.corruption<-scale(1-df2021$Perceptions.of.corruption)


colnames(df2021) <- c('Country', 'Region', 'Happiness_Score', 'ste_Happiness_Score', 'UCI_Happiness_Score','LCI_Happiness_Score','GDP_Score', 'Social_Score', 'Life_Expectancy_Score', 'Freedom_Score', 'Generosity_Score', 'Corruption_Score', 'Dystopia_Score', 'Exp_GDP', 'Exp_Social', 'Exp_Life_Expectancy', 'Exp_Freedom', 'Exp_Generosity', 'Exp_Corruption', 'Dystopia_Residual')

regions <- c()
for (i in df2021$Country) {
  if (i %in% df2015$Country) {
    regions <- c(regions, df2015[df2015$Country == i,]$Region)
  }
  else {
    regions <- c(regions, "NA")
  }
}
df2021$Region <- regions
unique(df2021$Region)

df2015$Year <- '2015'
df2016$Year <- '2016'
df2017$Year <- '2017'
df2018$Year <- '2018'
df2019$Year <- '2019'
df2020$Year <- '2020'
df2021$Year <- '2021'


list_df <- list(df2015, df2016, df2017, df2018, df2019, df2020, df2021)


df_2015_to_2021 <- data.frame()
for (i in list_df){
  df_2015_to_2021 <- rbind(df_2015_to_2021, i[,c('Year', 'Country', 'Region', 'Happiness_Score','Generosity_Score', 'Corruption_Score', 'GDP_Score', 'Life_Expectancy_Score','Social_Score')])
}


df_2015_to_2021$Year <- as.Date(ISOdate(year = df_2015_to_2021$Year, month = 1, day=01))






generate_scatter_H_Generosity <- function(df){
  df <- df %>% filter(!Region %in% c('NA'))
  p <- ggplot(df,aes(Happiness_Score,Generosity_Score))+
    geom_point(aes(color=Region))+
    ggtitle(paste('Score de bonheur en Fonction de la Générosité en', unique(df$Year))) +
    geom_label_repel(aes(label = ifelse(Generosity_Score>0.45 ,as.character(Country),'')),
                     box.padding   = 0.35, 
                     point.padding = 0.5,
                     segment.color = 'grey50')+
    xlab("Score du Bonheur")+
    ylab("Score de Générosité")
  ggplotly(p)
}



generate_bubblescat_Life_Exp_GDP <- function(df){
  #On enlève les NA
  df <- df %>% filter(!Region %in% c('NA'))
  p <- df %>%
    ggplot(aes(x=GDP_Score, y=Life_Expectancy_Score, size=1.8**Happiness_Score, color=Region,text = paste("country:",Country))) +
    ggtitle(paste0("Score d'Esperance de vie du PIB en ", df$Year))+
    geom_point(alpha=0.5) +
    scale_size(range = c(.001, 4),name="")+
    
    xlab("PIB")+
    ylab("Score d'Esperance de vie")
  
  ggplotly(p)
}


bar_chart_region_happiness_score_median <- function(dfyear){
  df <- dfyear %>% filter(!Region %in% c('NA'))
  df <- df %>% group_by(Region) %>% summarise_at(vars(Happiness_Score), list(Happiness_score = median))
  p <- df %>% ggplot(aes(x=Region, y=Happiness_score)) +
    geom_bar(stat="identity", fill="steelblue",width=0.4) +
    theme_minimal() + coord_flip()+ylab("Score du Bonheur")+xlab("Région")+ 
    ggtitle(paste0('Mediane par Région du Happiness Score en ', dfyear$Year))+
    geom_hline(yintercept = median(df$Happiness_score), linetype = "dashed", color='red')
  
  ggplotly(p)
}




round_bar_plot_country <- function(dfyear){
  
  df <- dfyear %>% filter(!Region %in% c('NA'))
  df <- df[sample(1:nrow(df)), ]
  
  number_bar <- nrow(df)
  empty_bar <- 8
  to_add <- data.frame(matrix(NA, empty_bar*length(unique(df$Region)), ncol(df)))
  colnames(to_add) <- colnames(df)
  to_add$Region <- rep(unique(df$Region), each=empty_bar)
  
  data <- rbind(df, to_add)
  data <- data[order(data$Region, decreasing=TRUE),]
  data$id <- seq(1, nrow(data))
  data$subRegion <- gsub('\\b(\\pL)\\pL{2,}|.','\\U\\1',data$Region,perl = TRUE)
  
  # prepare a data frame for base lines
  base_data <- data %>%
    group_by(Region) %>%
    summarize(start=min(id), end=max(id) - empty_bar, subRegion=subRegion) %>%
    rowwise() %>%
    mutate(title=mean(c(start, end)))
  # Make the plot
  
  p <- ggplot(data, aes(x=as.factor(id), y=2**Happiness_Score, fill=Region)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    
    geom_bar(aes(x=as.factor(id), y=2**Happiness_Score, fill=Region), stat="identity",alpha=.7) +
    
    theme_minimal() + ggtitle(paste("Barplot circulaire de l'Happiness Score en", unique(dfyear$Year)), subtitle = "Note : Les unités ne sont pas à la bonne échelle, ne peut être utilisé qu'à des fins de visualisation")  + 
    
    theme(
      legend.position = "right",
      legend.key.size = unit(1, 'cm'), #change legend key size
      legend.key.height = unit(1, 'cm'), #change legend key height
      legend.key.width = unit(1, 'cm'), #change legend key width
      legend.title = element_text(size=10), #change legend title font size
      legend.text = element_text(size=10),
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.title = element_text(size = 25),
      plot.subtitle = element_text(size = 10),
      plot.margin = margin(0, -1, -1, -1, "cm") 
    ) +
    ylim(-100, 90) +
    
    coord_polar(start = 0) +
    
    geom_segment(data=base_data, aes(x = start, y = -4, xend = end, yend = -4), colour = "black", alpha=0.8, size=0.6 )  +
    geom_text(data=base_data, aes(x = title, y = -20, label=subRegion), colour = "black", alpha=0.8, size=7)
  
  p  
  
}

df_evolution_country_by_region <- function(param, region, nbPays){
  df_2015_to_2021 <- data.frame()
  for (i in list(df2015, df2016, df2017, df2018, df2019, df2020, df2021)){
    df_2015_to_2021 <- rbind(df_2015_to_2021, i[,c('Year', 'Country', 'Region', param)])
  }
  
  df <- df_2015_to_2021 %>% dplyr::filter(Region %in% region)
  
  if (nbPays < length(unique(df$Country))){
    pays_random <- sample(unique(df$Country), nbPays, replace = F)
  }
  else {
    pays_random <- sample(unique(df$Country), length(unique(df$Country)), replace = F)
  }
  
  
  df_pays_random_in_region <- df %>% dplyr::filter(Country %in% pays_random)
  df_pays_random_in_region$Country <- as.factor(df_pays_random_in_region$Country)
  df_pays_random_in_region$Region <- as.factor(df_pays_random_in_region$Region)
  
  df_pays_random_in_region
}


function(input, output) {
  
  
  myYear <- reactive({
    if(input$annee==2015){
      return(x2015)
    }else if (input$annee==2016){
      return(x2016)
    }else if (input$annee==2017){
      return(x2017)
    }else if (input$annee==2018){
      return(x2018)
    }else if (input$annee==2019){
      return(x2019)
    }else if (input$annee==2020){
      return(x2020)
    }else if (input$annee==2021){
      return(x2021)
    }
  })
  myText <- reactive({
    if(input$annee==2015){
      return('Année 2015')
    }else if (input$annee==2016){
      return('Année 2016')
    }else if (input$annee==2017){
      return('Année 2017')
    }else if (input$annee==2018){
      return('Année 2018')
    }else if (input$annee==2019){
      return('Année 2019')
    }else if (input$annee==2020){
      return('Année 2020')
    }else if (input$annee==2021){
      return('Année 2021')
    }
  })
  myDf <- reactive({
    if(input$annee==2015){
      return(df2015)
    }else if (input$annee==2016){
      return(df2016)
    }else if (input$annee==2017){
      return(df2017)
    }else if (input$annee==2018){
      return(df2018)
    }else if (input$annee==2019){
      return(df2019)
    }else if (input$annee==2020){
      return(df2020)
    }else if (input$annee==2021){
      return(df2021)
    }
  })
  
  
  myAbs<- reactive({
    if(input$abs=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$abs=='Score de PIB'){
      return('GDP_Score')
    }else if (input$abs=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$abs=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$abs=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$abs=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$abs=='Score social'){
      return('Social_Score')
    }
  })
  myOrdName<- reactive({
    if(input$ord=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$ord=='Score de PIB'){
      return('PIB')
    }else if (input$ord=='Score de corruption'){
      return('Score de corruption')
    }else if (input$ord=='Score de générosité'){
      return('Score de générosité')
    }else if (input$ord=='Score de liberté'){
      return('Score de liberté')
    }else if (input$ord=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$ord=='Score social'){
      return('Scrore social')
    }
  })
  
  myAbsName<- reactive({
    if(input$abs=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$abs=='Score de PIB'){
      return('PIB')
    }else if (input$abs=='Score de corruption'){
      return('Score de corruption')
    }else if (input$abs=='Score de générosité'){
      return('Score de générosité')
    }else if (input$abs=='Score de liberté'){
      return('Score de liberté')
    }else if (input$abs=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$abs=='Score social'){
      return('Score social')
    }
  })
  
  myOrd<- reactive({
    if(input$ord=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$ord=='Score de PIB'){
      return('GDP_Score')
    }else if (input$ord=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$ord=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$ord=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$ord=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$ord=='Score_social'){
      return('Social_Score')
    }
  })
  
  myCarteSelect<- reactive({
    if(input$carteselect=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$carteselect=='Score de PIB'){
      return('GDP_Score')
    }else if (input$carteselect=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$carteselect=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$carteselect=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$carteselect=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$carteselect=='Score social'){
      return('Social_Score')
    }
  })
  myCarteSelectName<- reactive({
    if(input$carteselect=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$carteselect=='Score de PIB'){
      return('PIB')
    }else if (input$carteselect=='Score de corruption'){
      return('Score de corruption')
    }else if (input$carteselect=='Score de générosité'){
      return('Score de générosité')
    }else if (input$carteselect=='Score de liberté'){
      return('Score de liberté')
    }else if (input$carteselect=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$carteselect=='Score social'){
      return('Score social')
    }
  })
  
  
  myRegion<- reactive({
    if(input$region=='Western Europe'){
      return('Western Europe')
    }else if (input$region=='North America and ANZ'){
      return('North America and ANZ')
    }else if (input$region=='Latin America and Caribbean'){
      return('Latin America and Caribbean')
    }else if (input$region=='Middle East and Northern Africa'){
      return('Middle East and Northern Africa')
    }else if (input$region=='Central and Eastern Europe'){
      return('Central and Eastern Europe')
    }else if (input$region=='Sub-Saharan Africa'){
      return('Sub-Saharan Africa')
    }else if (input$abs=='Southeastern Asia'){
      return('Southeastern Asia')
    }else if (input$abs=='Southern Asia'){
      return('Southern Asia')
    }else if (input$abs=='Eastern Asia'){
      return('Eastern Asia')
    }
  })
  
  mySelectByCountry<- reactive({
    if(input$selectbyCountry=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$selectbyCountry=='Score de PIB'){
      return('GDP_Score')
    }else if (input$selectbyCountry=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$selectbyCountry=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$selectbyCountry=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$selectbyCountry=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$selectbyCountry=='Score social'){
      return('Social_Score')
    }
  })
  
  mySelectByCountryName<- reactive({
    if(input$selectbyCountry=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$selectbyCountry=='Score de PIB'){
      return('PIB')
    }else if (input$selectbyCountry=='Score de corruption'){
      return('Score de corruption')
    }else if (input$selectbyCountry=='Score de générosité'){
      return('Score de générosité')
    }else if (input$selectbyCountry=='Score de liberté'){
      return('Score de liberté')
    }else if (input$selectbyCountry=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$selectbyCountry=='Score social'){
      return('Score social')
    }
  })
  
  mySelectByRegion<- reactive({
    if(input$selectbyRegion=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$selectbyRegion=='Score de PIB'){
      return('GDP_Score')
    }else if (input$selectbyRegion=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$selectbyRegion=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$selectbyRegion=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$selectbyRegion=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$selectbyRegion=='Score social'){
      return('Social_Score')
    }
  })
  
  mySelectByRegionName<- reactive({
    if(input$selectbyRegion=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$selectbyRegion=='Score de PIB'){
      return('PIB')
    }else if (input$selectbyRegion=='Score de corruption'){
      return('Score de corruption')
    }else if (input$selectbyRegion=='Score de générosité'){
      return('Score de générosité')
    }else if (input$selectbyRegion=='Score de liberté'){
      return('Score de liberté')
    }else if (input$selectbyRegion=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$selectbyRegion=='Score Social'){
      return('Score social')
    }
  })
  
  mySelectTreeMap<- reactive({
    if(input$selecttreemap=='Score de bonheur'){
      return('Happiness_Score')
    }else if (input$selecttreemap=='Score de PIB'){
      return('GDP_Score')
    }else if (input$selecttreemap=='Score de corruption'){
      return('Corruption_Score')
    }else if (input$selecttreemap=='Score de générosité'){
      return('Generosity_Score')
    }else if (input$selecttreemap=='Score de liberté'){
      return('Freedom_Score')
    }else if (input$selecttreemap=="Score d'espérance de vie"){
      return('Life_Expectancy_Score')
    }else if (input$selecttreemap=='Score social'){
      return('Social_Score')
    }
  })
  mySelectTreeMapName<- reactive({
    if(input$selecttreemap=='Score de bonheur'){
      return('Score de bonheur')
    }else if (input$selecttreemap=='Score de PIB'){
      return('PIB')
    }else if (input$selecttreemap=='Score de corruption'){
      return('Score de corruption')
    }else if (input$selecttreemap=='Score de générosité'){
      return('Score de générosité')
    }else if (input$selecttreemap=='Score de liberté'){
      return('Score de liberté')
    }else if (input$selecttreemap=="Score d'espérance de vie"){
      return("Score d'espérance de vie")
    }else if (input$selecttreemap=='Score Social'){
      return('Score social')
    }
  })
  
  
  
  ridge_line_region <- function(dfyear){
    dfyear <- dfyear %>% filter(!Region %in% c('NA'))
    ggplot(dfyear, aes(x = Happiness_Score, y = Region, fill = ..x..)) +
      geom_density_ridges_gradient(scale = 2, rel_min_height = 0.01) +
      scale_fill_viridis(name = "Score du Bonheur", option = "B") +
      ggtitle(paste('Repartition du score de bonheur en', unique(dfyear$Year))) +
      theme(
        legend.position="bottom",
        panel.spacing = unit(0.1, "lines"),
        strip.text.x = element_text(size = 3), 
        legend.key.height = unit(.2, 'cm'), 
        legend.key.width = unit(1, 'cm'),
      )+ xlab("Score du Bonheur")
    
  }
  
  bar_chart_region_happiness_score_median <- function(dfyear, abs){
    df <- dfyear %>% filter(!Region %in% c('NA'))
    df <- df %>% group_by(Region) %>% summarise_at(vars(Happiness_Score), list(Happiness_score = median))
    p <- df %>% ggplot(aes(x=Region, y=Happiness_score)) +
      geom_bar(stat="identity", fill="steelblue",width=0.4) +
      theme_minimal() + coord_flip()+ylab("Score du Bonheur")+xlab("Région")+ 
      ggtitle(paste0('Mediane par Région du Happiness Score en ', dfyear$Year))+
      geom_hline(yintercept = median(df$Happiness_score), linetype = "dashed", color='red')
    ggplotly(p)
  }
  
  scatt_Corr_GDP<-function(df, abs, ord){
    df <- df %>% filter(!Region %in% c('NA'))
    
    p <-  ggplot(df,aes(x = get(abs), y = get(ord), label= Country )) +
      geom_point(aes(color=get(abs))) +
      #Courbe 
      geom_smooth()+
      ggtitle(paste("Scatterplot du ", myOrdName(), "en fonction du", myAbsName(), "en",df$Year))+
      ylab(myOrdName())+
      xlab(myAbsName())+
      labs(color=myAbsName())
    ggplotly(p)
  }
  
  generate_bubblescat_Social_GDP <- function(df, abs, ord){
    #On enlève les NA
    df <- df %>% filter(!Region %in% c('NA'))
    p <- df %>%
      ggplot(aes(x = get(abs), y = get(ord), size=1.8**Happiness_Score, color=Region,text = paste("country:",Country))) +
      labs(title=paste0(myOrdName(), " en fonction du ", myAbsName(), ' en ', df$Year))+
      geom_point(alpha=0.5) +
      scale_size(range = c(.001, 4),name="")+
      theme(plot.title=element_text(size=10))+
      ylab(myOrdName())+
      xlab(myAbsName())
    
    
    ggplotly(p)
  }
  
  generate_scatter_GDP_Generosity <- function(df, abs, ord){
    df <- df %>% filter(!Region %in% c('NA'))
    
    p <- ggplot(df,aes(x = get(abs), y = get(ord)))+
      geom_point(aes(color=Region))+
      ggtitle(paste(myOrdName(), " en fonction du ", myAbsName(), ' en ', unique(df$Year))) +
      geom_label_repel(aes(label = ifelse(Generosity_Score>0.45 ,as.character(Country),'')),
                       box.padding   = 0.35, 
                       point.padding = 0.5,
                       segment.color = 'grey50')+
      xlab(myAbsName())+
      ylab(myOrdName())
    ggplotly(p)
  }
  
  
  make_barplot_region<-function(df,region,param){
    data<-df %>% filter(Region==region)
    data<-select(data,c("Year","Country",param))
    p <-  ggplot(data,aes(x = Country, y=get(param), color=Country)) + geom_bar(stat='identity', width=0.5)+  geom_hline(yintercept=0)+
      coord_flip()+
      ylab(paste(myCarteSelectName())) +
      #Titre Problème
      ggtitle(paste(param,"de tous les pays en",df)) 
    ggplotly(p)
    
  }
  
  boxviolon <- function(df, region){
    data <- df %>% filter(Region==region)
    p <- ggbetweenstats(
      data= data, 
      x=Region, 
      y=Generosity_Score,results.subtitle = FALSE,
      title=paste("Violon Chart représentant le score de générosité \npour toutes les régions  en ", unique(df2015$Year)), 
      pairwise.comparisons = FALSE
    )
    p
  }
  
  
  make_line_chart_region <- function(param, region, nbPays){
    df_pays_random_in_region <- df_evolution_country_by_region(param, region, nbPays)
    p <-  ggplot(df_pays_random_in_region) + geom_line(aes(x = Year, y=get(param), group=Country, color=Country))+
      ggtitle(paste(param,"de différents pays en ",region, " à partir de 2015"))+
      ylab(param)
    ggplotly(p)
  }
  
  Treemap_plot_country<-function(df){
    data<-select(df,c("Region","Country","Life_Expectancy_Score","GDP_Score"))
    data<-data  %>% filter(Region=="Sub-Saharan Africa")
    data %>%
      hchart(
        "treemap", 
        hcaes(x = "Country", value = "Life_Expectancy_Score", color = "GDP_Score")
      )%>%
      hc_colorAxis(stops = color_stops(colors = viridis::inferno(10)))
    
  }
  
  treemap_func<-function(param, region, annee){
    data<-select(annee,c("Region","Country",param))
    data<-data %>% filter(Region == myRegion())
    
    treemap(data, index=c('Region',"Country"),vSize=param, type="index",
            fontsize.labels=c(11,7),                
            fontcolor.labels=c("White"),    
            fontface.labels=c(2,1),                  
            bg.labels=c("transparent"),              
            align.labels=list(
              c("center", "center"), 
              c("center", "center")
            ),    
            overlap.labels=0.5,                      
            inflate.labels=F, 
            range = c(0, 1))
    
  }
  
  
  
  
  
  output$chart <- 
    renderHighchart(highchart(type = "map") %>%
                      hc_add_series_map(
                        worldgeojson, 
                        df = myDf(), 
                        value = myCarteSelect(), 
                        joinBy = c('name', 'Country'),
                        name = myCarteSelectName()
                      )  %>% 
                      hc_colorAxis(
                        stops = color_stops()
                      ) %>% 
                      hc_title(
                        text ="dans le monde"
                      ) %>% 
                      hc_mapNavigation(
                        enabled = TRUE
                      ) %>%
                      hc_subtitle(
                        text = myCarteSelectName()
                      )
    )
  
  
  
  
  
  
  output$plotGDP <- renderPlotly({
    generate_scatter_GDP_Generosity(myDf(), myAbs(), myOrd())
  })
  
  
  output$plotHappiness <- renderPlotly({
    generate_scatter_H_Generosity(df = myDf())
  })
  
  output$plotbubblescat <- renderPlotly({
    generate_bubblescat_Social_GDP(myDf(), myAbs(),myOrd())
  })
  
  output$plotscatt <- renderPlotly({
    scatt_Corr_GDP(myDf(), myAbs(), myOrd())
  })
  
  output$plotLifeExp <- renderPlotly({
    scatt_Corr_GDP(df = myDf())
  })
  
  
  output$roundbar <- renderPlot({
    generate_bubblescat_Life_Exp_GDP(df = myDf())
  })
  
  output$plotHappinessByRegion <- renderPlotly({
    bar_chart_region_happiness_score_median(myDf(), mySelectByRegion())
  })
  
  output$plotHappinessByRegionBis <- renderPlot({
    ridge_line_region(df = myDf())
  })
  
  output$ByCountry <- renderPlotly({
    make_barplot_region(myDf(), myRegion(), mySelectByCountry())
  })
  
  output$LineChartRegion <- renderPlotly({
    make_line_chart_region(mySelectByCountry(), myRegion(), input$nbCountry)
  })
  
  output$treemap <- renderPlot({
    treemap_func(mySelectTreeMap(), myRegionName(), myDf())
  })
  
  output$boxViolon <- renderPlot({
    boxviolon(myDf(), myRegion())
  })
}




