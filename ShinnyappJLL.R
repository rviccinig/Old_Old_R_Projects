

#Opening Packages

library("flexdashboard")
library("pdftools")
library("tidyverse")
library("ggplot2")
library("ggthemes")
library("gridExtra")
library("dplyr")
library("RColorBrewer")
library("plotly")
library("shiny")
library("scales")

##############################################################################
#Creating Shiny App

# Step 1 (Input): Define UI for application that draws a histogram
ui <- fluidPage(
  
# Application title
  titlePanel("JLL, Quarterly Net Absorption"),
  
# Sidebar with a slider input for number of bins 
sidebarLayout(
  sidebarPanel(
    selectInput("Class","Building Class:", choices = as.character(unique(Histdata$Class))),
    selectInput("Submarket","Submarket:", choices = as.character(unique(Histdata$Submarket)))
    ),
  mainPanel( 
    plotOutput("chart")
  )
))

# Step 2(Output): Define server logic required to draw a histogram
server <- function(input, output) {

##############################################################################
  #Opening Dataset
  
  # Reading Historical Data from JLL
  
  Histdata<-read.csv("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/Historical Data of Office Research/CSV Version/Historical Data Vacancies 20193.csv",header = TRUE,sep=",")
  
  #Fixing up dates so I can use Time Series., the format part is the most important
  Histdata$Quarter<- as.character(Histdata$Date)
  Histdata$Quarter<-as.Date(paste("01-", Histdata$Quarter, sep = ""), format = "%d-%y-%b")
  
  #Period of Interest, this is what I change (Be careful with the format part it changes everytime I open the csv)
  Period<-"2019-09-01"
  
  #Ordering submarket by Area
  Histdata$Submarket <- factor(Histdata$Submarket, levels = rev(c("Downtown","West Core", "Central Core","East Core","Suburbs","Beltline","North","Northwest","Northeast","South" ,"Greater Calgary" )))
  
  #Creating Positive and Negative
  Histdata$Sign<-as.factor(ifelse(Histdata$Total.net.absorption..s.f..>0,"Positive","Negative"))
  
  #Label Position
  Histdata$vjust <- ifelse(Histdata$Sign == "Positive", -0.1, 1)
    
############################################################################### 
#Modify database according to the inout selections
  
  cr <- reactive({
   a <-Histdata[Histdata$Class==input$Class &
                  Histdata$Submarket == input$Submarket
        ,]
    })
  
  output$chart <- renderPlot({
    validate(
      need(nrow(cr())!=0, "No Data to plot")
    )
   
    p<-ggplot(data = cr(), aes(x = Quarter, y = Total.net.absorption..s.f../1000))+ 
      geom_bar(stat = "identity",aes(fill = Sign))+
      theme(legend.position = "none") +
      scale_fill_manual(values=c("#E30613", "#000000"))+
      labs(x = "Date",
           y = " Square Feet ('000)",
           title = " ",
           subtitle = "Quarterly Net Absoption in Calgary's Submarkets ")+
      theme(axis.text.x=element_text(angle = -90, hjust = 0))+
      theme_bw()+theme(legend.position="none")+
      geom_text(aes(label= formatC(Total.net.absorption..s.f.., format="f", big.mark=",", digits=0), vjust= vjust),color = "Black")+ scale_y_continuous(breaks = scales::pretty_breaks(n = 10),limits=c(-900, 900))
     #geom_smooth(aes(x=Quarter,y=Total.net.absorption..s.f../1000),color="blue") 
   
 p
    
  }, height = 800, width = 1100)
}

shinyApp(ui = ui, server = server)
    
    
    
    