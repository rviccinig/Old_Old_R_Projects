#Load Packages, # Hay que darle el PATH con la version de Java Correcta!!!!!!! Yuhuu

#check that Java and Rstudio are running on 64.(Very important)
#Run the installation for Java and then give it the path so Rjava and and Rselenium can load.

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_251')

library("rJava")
library('RSelenium')

#####Create Urls for All Properties

#Marketsphere Ids I would like to modify
y=c(1111,222,333,3333,33444,33333)

#Editing Parking Stalls, standard URL for the Market Slide

URLS<-c()
for(i in y){
  url1<-"https://apps.jll.com/MarketSphere/PropertyEdit/Overview/"
  # Here I am creating the URL
  property<-paste0(url1,i)
  #Here I am Concatanating URLs to the Empty Vector URLS 
  URLS<-c(URLS,property)
}

#Managing the Browser

#Open RSelenium, Write the version of chrome I am currently using. (force it into a version that he accepts) it will tell you once you specificy the version.
rD <- rsDriver(browser=c("chrome"), chromever="83.0.4103.39")
remote_driver <- rD[["client"]]
remote_driver$open()

# This Works perfectly for a single URL
#Navigate a URL. first 1 usually needs me to sign in
remote_driver$navigate("https://apps.jll.com/MarketSphere/PropertyEdit/Overview/591343")
# Select the Parking tab , check the CSS code in Chrome first and then write a number 
address_textfield <- remote_driver$findElement(using = "name", value = "ParkingSpaces")
address_textfield$sendKeysToElement(list("75"))
#Locate and Save the Save button, All this looking at the CSS code
Save_button <- remote_driver$findElement(using = 'id', value = 'btnSaveChanges')
#Press the Button
Save_button$clickElement()

# Lets try for Several URLS
Urls<-c("https://apps.jll.com/MarketSphere/PropertyEdit/Overview/591343", "https://apps.jll.com/MarketSphere/PropertyEdit/Overview/591448")
Parking<-c("121","160")        
clean=c("\uE003","\uE003","\uE003","\uE003")

i = 1
Sys.sleep(1)
for(url in Urls) {
  remote_driver$refresh()
  remote_driver$navigate(url)
  address_textfield <- remote_driver$findElement(using = "name", value = "ParkingSpaces")
  address_textfield$sendKeysToElement(list("\uE003"))
  address_textfield$sendKeysToElement(list("\uE003"))
  address_textfield$sendKeysToElement(list("\uE003"))
  address_textfield$sendKeysToElement(list(Parking[i]))
  address_textfield$sendKeysToElement(list("\uE007"))
  Sys.sleep(5)
  Save_button <- remote_driver$findElement(using = 'id', value = 'btnSaveChanges')
  Save_button$clickElement()
  i = i+1
  Sys.sleep(5)
}

#To Close The rest of the Session.
#remote_driver$close()
