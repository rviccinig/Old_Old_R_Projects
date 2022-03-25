# Histograms Op.Cost

library("flexdashboard")
library("pdftools")
library("tidyverse")
library("ggplot2")
library("ggthemes")
library("gridExtra")
library("dplyr")
library("RColorBrewer")
library("plotly")
library("readr")

# Opening File: 


Building_Export <- read_csv("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/Rprojects/Building_Export.csv", 
                            col_types = cols(`Asking Rent` = col_number(), 
                                             Availa = col_number(), Avgfloor = col_number(), 
                                             `Max Asking Rent` = col_number(), 
                                             `Min Asking Rent` = col_number(), 
                                             OcRate = col_number(), Size = col_number(), 
                                             Stories = col_number(), parking = col_number(), 
                                             parkingspaces = col_number(),
                                             ))

# Modifying several Variables as factors
names(Building_Export)
Building_Export$Class<-factor(Building_Export$Class)


# Hisogram of total Floor Plates
hist(Building_Export$Avgfloor, col = 'skyblue3', breaks = 70)

ggplot(Building_Export, aes(x = OcRate, fill = Class)) + geom_histogram(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()
ggplot(Building_Export, aes(x = Avgfloor, fill = Class)) + geom_histogram(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()


##################################################################
# Buildings by Average Floor Platess Less than 10,000 Square Feet.

less10<-subset(Building_Export, Building_Export$Avgfloor<=10000 )

#Densities of Vacancy
ggplot(less10, aes(x = OcRate, fill = Class)) + geom_density(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()

#Cummulative Distribution of Ocuppancy rates Very Interesting

p1<-ggplot(less10 , aes(x = OcRate)) +
  stat_ecdf(aes(color = Class,linetype = Class), 
            geom = "step", size = 1.5) +
  scale_color_manual(values = c("#1b9e77", "#d95f02" ,"#7570b3"))+
  labs(x=" Ocuppancy Rate (%)",y = "f(Ocupancy)") + ggtitle("Ocuppancy Rates of Office Buildings with Avg Floor Plate <10,000 s.f.")+
  scale_x_continuous(breaks=seq(0,100,10))

p1

##################################################################
# Buildings by Average Floor Platess Less than 10,000<x<=20,000 Square Feet.
less1020<-subset(Building_Export, 10000<Building_Export$Avgfloor & Building_Export$Avgfloor<=20000 )

#Densities of Vacancy
ggplot(less1020, aes(x = OcRate, fill = Class)) + geom_density(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()

#Cummulative Distribution of Ocuppancy rates Very Interesting
p2<-ggplot(less1020 , aes(x = OcRate)) +
  stat_ecdf(aes(color = Class,linetype = Class), 
            geom = "step", size = 1.5) +
  scale_color_manual(values = c("#1b9e77", "#d95f02" ,"#7570b3"))+
  labs(x="Ocuppancy Rate (%)",y = "f(Ocupancy)") + ggtitle("Ocuppancy Rates of Office Buildings with Avg Floor Plate 10,000<x<20,000 s.f.")+
  scale_x_continuous(breaks=seq(0,100,10))


##################################################################
# Buildings by Average Floor Platess Less than 20,000<x<=30,000 Square Feet.
less2030<-subset(Building_Export, 20000<Building_Export$Avgfloor & Building_Export$Avgfloor<=30000 )

#Densities of Vacancy
ggplot(less2030, aes(x = OcRate, fill = Class)) + geom_density(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()


#Cummulative Distribution of Ocuppancy rates Very Interesting
p3<-ggplot(less2030 , aes(x = OcRate)) +
  stat_ecdf(aes(color = Class,linetype = Class), 
            geom = "step", size = 1.5) +
  scale_color_manual(values = c("#1b9e77", "#d95f02" ,"#7570b3"))+
  labs(x="Ocuppancy Rate (%)",y = "f(Ocupancy)") + ggtitle("Ocuppancy Rates of Office Buildings with Avg Floor Plate 20,000<x<=30,000 s.f.")+
  scale_x_continuous(limits = c(0, 100),breaks=seq(0,100,10))
p3



##################################################################
# Buildings by Average Floor Platess Less than 10,000<x<20,000 Square Feet.
more30<-subset(Building_Export,Building_Export$Avgfloor>=30000 )


#Densities of Vacancy
ggplot(more30, aes(x = OcRate, fill = Class)) + geom_density(alpha = 0.5)+facet_wrap(~ Class)+theme_bw()

#Cummulative Distribution of Ocuppancy rates Very Interesting
p4<-ggplot(more40 , aes(x = OcRate)) +
  stat_ecdf(aes(color = Class,linetype = Class), 
            geom = "step", size = 1.5) +
  scale_color_manual(values = c("#1b9e77", "#d95f02" ,"#7570b3"))+
  labs(x="Ocuppancy Rate (%)",y = "f(Ocupancy)") + ggtitle("Ocuppancy Rates of Office Buildings with Avg Floor Plate x>30,000 s.f.")+
  scale_x_continuous(limits = c(0, 100),breaks=seq(0,100,10))
p4



grid.arrange(p1, p2, p3, p4, ncol=2)

