
#check that Java and Rstudio are running on 64.(Very important)
#Run the installation for Java and then give it the path so Rjava and and Rselenium can load.

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_251')

library("rJava")
library("tabulizer")
library("miniUI")


Boma<- locate_areas("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/bomad.pdf",pages = 32)
test<-extract_tables("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/bomad.pdf",pages = c(32,32,32,32,32),guess=FALSE,area=list(c(53,35,739,559)),output = "data.frame")

Boma_table_clean <- reduce(test, bind_rows)

bomadone<-as.data.frame(test[1])

CBRE<- locate_areas("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/TablesPDF/CBREbeltlinemarch2020.pdf",pages = 2)
CBREtest<-extract_tables("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/TablesPDF/CBREbeltlinemarch2020.pdf",pages = c(2,2,2,2,2),guess=FALSE,area=list(c(136,123,570,753)),output = "data.frame")
CBREdone<-as.data.frame(CBREtest[1])
            