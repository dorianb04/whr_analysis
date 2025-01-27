# Visualisation des données du "World Hapiness Report"

## Installation des packages
Pour pouvoir exécuter toutes les cellules de code au sein du rapport R Markdown sans problème, nous préconisons d'utiliser cette commande afin de garantir la bonne installation de tous les packages :
```
install.packages(c('magick', 'ggthemes', 'gapminder', 'fmsb', 'ggstatsplot', 'highcharter', 'treemap', 'corrplot', 'gganimate', 'forcats', 'stringr', 'dplyr', 'purrr', 'readr', 'tidyr', 'tibble', 'tidyverse', 'plotly', 'ggrepel', 'hrbrthemes', 'viridis', 'viridisLite', 'ggplot2', 'ggridges', 'stats', 'graphics', 'grDevices', 'utils', 'datasets', 'methods', 'base', 'prettydoc'))
```


## Introduction

### I. Données

#### 1. Contexte

Nous avons selectionné un data set se nommant : "World Hapiness Report up to 2022". Celui-ci classe 155 pays en fonction de leur niveau de bonheur. Le premier rapport a été publié en 2012. En ce qui nous concerne, nous souhaitons étudier les rapports de 2015 à 2022.

Ces données proviennent du site Kaggle (disponible sur ce [lien](https://www.kaggle.com/datasets/ajaypalsinghlo/world-happiness-report-2022)) dont l'auteur ***Mathurin Aché*** les a extraites des "[World Happiness Report](https://worldhappiness.report/)", publiés par le Earth Institute. 
<p align="center">
<img src="img/WHR-2021_press.jpg" width="50%">
</p>


Les données sont tirées des sondages du [Gallup World Poll](https://www.gallup.com/analytics/318875/global-research.aspx). Elles sont basées sur les réponses à la principale question d'évaluation de la vie posée dans les sondages. Appelée l'échelle de Cantril, elle demande aux personnes interrogées de penser à une échelle, la meilleure vie possible pour elles étant un 10 et la pire étant un 0. Il leur est ensuite demandé d'évaluer leur propre vie actuelle sur cette échelle de 0 à 10. Les classements sont issus d'échantillons représentatifs au niveau national.

<p align="center">
<br>
<img src="img/gallup_world_poll.png" width="50%">
</p>

Nous avons choisi pour ce projet d'analyser ces rapports car ils sont reconnu mondialement. En effet, ils peuvent être utilisés par les gouvernements et les organisations pour éclairer leur choix politiques. De plus, ces données nous parraissaient intéresssantes à étudier, puisque des experts décisionnaires les utilisent également dans de nombreux domaines : 

- Questions financières
- Recherche sur le cerveau
- Enquête générale
- Perspectives nationales 
- Bien-être

Ceux-ci permettent de donner des estimations du bien-être et évaluer les progrès des pays. Ainsi, nous pensons que l'étude et la visualisation des données contenues dans ce dataset nous permettrait de mettre en lien les différents paramètres pouvant influer sur le bonheur des pays.

#### 2. Description détaillée des données
#### 2.1. Description des variables
Notre dataset est composé de 7 fichiers au format *.csv*, chacun représentant respectivement les données de chacunes des années de 2015 à 2022 d'au moins 146 pays. Les différentes variables que nous pouvons retrouver et exploiter dans notre dataset sont :
1.   `Country name` : Il s'agit du nom du pays évalué
4.   `Regional indicator` : Un indicateur précisant la région du monde dans laquelle se trouve le pays observé
5.   `Ladder score` : Médiane du score du bonheur donné dans les sondages
6.   `Standard error of ladder score` : L'erreur estimée sur le score du bonheur 
7.   `upperwhisker` : Le maximum du boxplot des réponses données dans les sondages
8.   `lowerwhisker` : Le minimum du boxplot des réponse données dans les sondages
9.   `Logged GDP per capita` : Le PIB (Produit Intérieur Brut) par habitants dans le pays
10.   `Social support` : Notion polysémique qui désigne l'intégration d'un individu divisé par le nombre de relation avec autrui 
11.  `Healthy life expectancy` : L'espérance de vie moyenne dans le pays concerné
12.  `Freedom to make life choices` : Score désignant la liberté des choix de vie de la population
13.  `Generosity` : Le score de la générosité de la population dans le pays
14.  `Perceptions of corruption` : Le score représentant la perception de la corruption dans le pays de la population
15.  `Ladder score in Dystopia` : Moyenne de score de bonheur dans le cas d'une Dystopie
16.  `Explained by: Log GDP per capita` : Part du score du bonheur expliqué par le PIB par habitants
17.  `Explained by: Social support` : Part du score du bonheur expliqué par le support social
18.  `Explained by: Healthy life expectancy` : Part du score du bonheur expliqué par l'espérance de vie
19.  `Explained by: Freedom to make life choices` : Part du score du bonheur expliqué par la liberté de choix de vie
20.  `Explained by: Generosity` : Part du score du bonheur expliqué par la générosité
21.  `Explained by: Perceptions of corruption` : Part du score du bonheur expliqué par la corruption
22.  `Dystopia + residual` : Restant des parts du score du bonheur pouvant être expliqué par le score du bonheur dans une le cas d'une Dystopie ajouté aux résidus                

#### 2.2. Description des données au sein des fichiers du dataset
Voici la description des variables pour chacunes des années du dataset : 
##### 2015
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
158 individus
12 variables
 #   Variables                      Non-Null Count  Dtype  
---  ------                         --------------  -----  
 0   Country                        158 non-null    object 
 1   Region                         158 non-null    object 
 2   Happiness Rank                 158 non-null    int64  
 3   Happiness Score                158 non-null    float64
 4   Standard Error                 158 non-null    float64
 5   Economy (GDP per Capita)       158 non-null    float64
 6   Family                         158 non-null    float64
 7   Health (Life Expectancy)       158 non-null    float64
 8   Freedom                        158 non-null    float64
 9   Trust (Government Corruption)  158 non-null    float64
 10  Generosity                     158 non-null    float64
 11  Dystopia Residual              158 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2016
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
157 individus
13 variables
 #   Variables                      Non-Null Count  Dtype  
---  ------                         --------------  -----  
 0   Country                        157 non-null    object 
 1   Region                         157 non-null    object 
 2   Happiness Rank                 157 non-null    int64  
 3   Happiness Score                157 non-null    float64
 4   Lower Confidence Interval      157 non-null    float64
 5   Upper Confidence Interval      157 non-null    float64
 6   Economy (GDP per Capita)       157 non-null    float64
 7   Family                         157 non-null    float64
 8   Health (Life Expectancy)       157 non-null    float64
 9   Freedom                        157 non-null    float64
 10  Trust (Government Corruption)  157 non-null    float64
 11  Generosity                     157 non-null    float64
 12  Dystopia Residual              157 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2017
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
155 individus
12 variables
 #   Variables                      Non-Null Count  Dtype  
---  ------                         --------------  -----  
 0   Country                        155 non-null    object 
 1   Happiness.Rank                 155 non-null    int64  
 2   Happiness.Score                155 non-null    float64
 3   Whisker.high                   155 non-null    float64
 4   Whisker.low                    155 non-null    float64
 5   Economy..GDP.per.Capita.       155 non-null    float64
 6   Family                         155 non-null    float64
 7   Health..Life.Expectancy.       155 non-null    float64
 8   Freedom                        155 non-null    float64
 9   Generosity                     155 non-null    float64
 10  Trust..Government.Corruption.  155 non-null    float64
 11  Dystopia.Residual              155 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2018
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
156 individus
9 variables
 #   Variables                     Non-Null Count  Dtype  
---  ------                        --------------  -----  
 0   Overall rank                  156 non-null    int64  
 1   Country or region             156 non-null    object 
 2   Score                         156 non-null    float64
 3   GDP per capita                156 non-null    float64
 4   Social support                156 non-null    float64
 5   Healthy life expectancy       156 non-null    float64
 6   Freedom to make life choices  156 non-null    float64
 7   Generosity                    156 non-null    float64
 8   Perceptions of corruption     155 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2019
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
156 individus
9 variables
 #   Variables                     Non-Null Count  Dtype  
---  ------                        --------------  -----  
 0   Overall rank                  156 non-null    int64  
 1   Country or region             156 non-null    object 
 2   Score                         156 non-null    float64
 3   GDP per capita                156 non-null    float64
 4   Social support                156 non-null    float64
 5   Healthy life expectancy       156 non-null    float64
 6   Freedom to make life choices  156 non-null    float64
 7   Generosity                    156 non-null    float64
 8   Perceptions of corruption     156 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2020
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
153 individus
20 variables
 #   Variables                                   Non-Null Count  Dtype  
---  ------                                      --------------  -----  
 0   Country name                                153 non-null    object 
 1   Regional indicator                          153 non-null    object 
 2   Ladder score                                153 non-null    float64
 3   Standard error of ladder score              153 non-null    float64
 4   upperwhisker                                153 non-null    float64
 5   lowerwhisker                                153 non-null    float64
 6   Logged GDP per capita                       153 non-null    float64
 7   Social support                              153 non-null    float64
 8   Healthy life expectancy                     153 non-null    float64
 9   Freedom to make life choices                153 non-null    float64
 10  Generosity                                  153 non-null    float64
 11  Perceptions of corruption                   153 non-null    float64
 12  Ladder score in Dystopia                    153 non-null    float64
 13  Explained by: Log GDP per capita            153 non-null    float64
 14  Explained by: Social support                153 non-null    float64
 15  Explained by: Healthy life expectancy       153 non-null    float64
 16  Explained by: Freedom to make life choices  153 non-null    float64
 17  Explained by: Generosity                    153 non-null    float64
 18  Explained by: Perceptions of corruption     153 non-null    float64
 19  Dystopia + residual                         153 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2021
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
149 individus
20 variables
 #   Variables                                   Non-Null Count  Dtype  
---  ------                                      --------------  -----  
 0   Country name                                149 non-null    object 
 1   Regional indicator                          149 non-null    object 
 2   Ladder score                                149 non-null    float64
 3   Standard error of ladder score              149 non-null    float64
 4   upperwhisker                                149 non-null    float64
 5   lowerwhisker                                149 non-null    float64
 6   Logged GDP per capita                       149 non-null    float64
 7   Social support                              149 non-null    float64
 8   Healthy life expectancy                     149 non-null    float64
 9   Freedom to make life choices                149 non-null    float64
 10  Generosity                                  149 non-null    float64
 11  Perceptions of corruption                   149 non-null    float64
 12  Ladder score in Dystopia                    149 non-null    float64
 13  Explained by: Log GDP per capita            149 non-null    float64
 14  Explained by: Social support                149 non-null    float64
 15  Explained by: Healthy life expectancy       149 non-null    float64
 16  Explained by: Freedom to make life choices  149 non-null    float64
 17  Explained by: Generosity                    149 non-null    float64
 18  Explained by: Perceptions of corruption     149 non-null    float64
 19  Dystopia + residual                         149 non-null    float64
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##### 2022
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
147 individus
12 variables
 #   Variables                                   Non-Null Count  Dtype  
---  ------                                      --------------  -----  
 0   RANK                                        147 non-null    int64 
 1   Country                                     147 non-null    object
 2   Happiness score                             146 non-null    object
 3   Whisker-high                                146 non-null    object
 4   Whisker-low                                 146 non-null    object
 5   Dystopia (1.83) + residual                  146 non-null    object
 6   Explained by: GDP per capita                146 non-null    object
 7   Explained by: Social support                146 non-null    object
 8   Explained by: Healthy life expectancy       146 non-null    object
 9   Explained by: Freedom to make life choices  146 non-null    object
 10  Explained by: Generosity                    146 non-null    object
 11  Explained by: Perceptions of corruption     146 non-null    object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



## II. Plan d'analyse

Comme décrit précedemment, ce data set contient au minimum une dizaine de variables par année, ainsi, il serait interessant de comparer les variables qui sont similaires par année et d'observer leur évolution par pays. En effet, cette première analyse pourra nous permettre de visualiser comment un évènement peut impacter le bonheur des populations en fonction d'où ils se trouvent dans le monde. On peut prendre l'exemple du COVID, quel impact a-t il eu sur les différentes populations et sinon pourquoi? Comment l'expliquer ? Les mesures étaient elles les mêmes?

De plus, nous souhaitons également analyser et comparer des variables telles que la générosité des populations dans des pays instables ou en guerre avec des pays dit en paix. Cette analyse permettrait de visualiser l'entraide et le soutien naturel durant les situations de crises. D'autres part, nous pouvons par exemple mener une analyse sur la variable de Happiness score ou l'éspérance de vie moyenne et les comparer à différentes région du monde, on pourrait ainsi en déduire que le climat, la zone géographique peut influer sur le bonheur et l'éspérance de vie moyenne.

Enfin, il serait interessant d'étudier les corrélations entre différentes variables sur plusieurs années, tels que l'étude de la durée de vie moyenne avec la générosité ou le Happiness score. Cette étude de corrélation pourrait ainsi nous permettre d'observer que plus on est heureux, plus notre éspérance de vie est élevée. 

En somme, nous souhaitons :
- Etudier l'évolution des différentes variables communes en fonction des années, 
- Comparer les variables sur différents types de pays, régions du monde,
- Analyser les corrélations entre différentes variables ou individus.

A noter que certaines variables ne sont pas comparées de la même manière en fonction des différentes années, on peut prendre l'exemple de la variable Happinness score en 2015, dont on donne la variance alors qu'en 2016, un intervalle de confiance a été calculé. Ainsi, il faudra traiter nos données de sorte que ce type de différences, ne pose pas problème lors des visualiations. Nous devrons donc faire attention au sens et à l'exploitation des variables en fonction des différentes années.
