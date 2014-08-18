# The results with the test dataset are:

library(randomForest)
load("data//model.Rda")
testing <- read.csv("data/pml-testing.csv", header=TRUE)
testPred <- predict(model, newdata=testing)
testPred

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("submit_results/problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(testPred)
