#Set working directory

setwd("C:/Users/310300894/Desktop/Kaggle/Titanic")

#Import the training dataset and test dataset

library(readxl)
train <- read.csv("train.csv")
View(train)
test <- read.csv("test.csv")
View(test)

#check the structure of the dataframe
str(train)

#check who survived
table(train$Survived)
prop.table(table(train$Survived))


#create/overwrite Survived column and set it to 0 in all 418 rows
nrow(test) #to find no of rows
test$Survived <- rep(0,418)

#create a file to submit to Kaggle
submit<- data.frame(PassengerId = test$PassengerId, Survived= test$Survived)
write.csv(submit, file= "theyallperish.csv", row.names = FALSE)

#check the proportion in each sex -- the 1 at the end is for each row, 2 is for columns
prop.table(table(train$Sex,train$Survived),1)

#to view only the survived/dead ppl
train[train[,"Survived"] == 1,]
train[train[,"Survived"] == 0,]

#set only females as survived
test$Survived[test$Sex=='female'] <- 1

#create a file to submit to Kaggle
submit<- data.frame(PassengerId = test$PassengerId, Survived= test$Survived)
write.csv(submit, file= "onlywomenlive.csv", row.names = FALSE)

#create new column- Child and set it to 0. set to 1 if age <18
train$Child <- 0
train$Child[train$Age<18] <- 1

#view the survivors based on child and sex
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)



