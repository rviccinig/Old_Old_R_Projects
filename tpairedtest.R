# T-Test

library("tidyverse")

#datasets
Before<-read.csv("C:/Users/reinaldo.viccini/Desktop/Sharon/Before.csv")
After<-read.csv("C:/Users/reinaldo.viccini/Desktop/Sharon/After.csv")

#subset shared questions
After<-subset(After, Shared.questions==1)

#Complete data

Complete<-merge(Before,After,by=c("ID","Question"))
levels(Complete$Question)

# Question 1
quest1<-subset(Complete,Question=="I have an excellent understanding of my diagnosis")
res <- t.test(quest1$Score.x,quest1$Score.y , paired = TRUE)
res

#Questions 2
quest2<-subset(Complete,Question=="I am aware of the ways to protect my joints and exercise safety")
res <- t.test(quest2$Score.x,quest2$Score.y , paired = TRUE)
res

#Questions 3
quest3<-subset(Complete,Question=="I am familiar with the role of the social worker in management of inflamatory arthritis")
res <- t.test(quest3$Score.x,quest3$Score.y, paired = TRUE)
res

#Questions 4
quest4<-subset(Complete,Question=="I feel Informed about the different medicatioons that are used to treat my arthritis" )
res <- t.test(quest4$Score.x,quest4$Score.y, paired = TRUE)
res

#Questions 5
quest5<-subset(Complete,Question=="I feel knowledgeable about how to stay healthy with inflamatory Arthritis" )
res <- t.test(quest5$Score.x,quest5$Score.y, paired = TRUE)
res

#Questions 6
quest6<-subset(Complete,Question=="I have a clear understanding of the management of inflamatory arthritis and its treatment options" )
res <- t.test(quest6$Score.x,quest6$Score.y , paired = TRUE)
res


#Questions 8
quest8<-subset(Complete,Question=="I have an excellent understanding of my diagnosis")
res <- t.test(quest8$Score.x,quest8$Score.y , paired = TRUE)
res

