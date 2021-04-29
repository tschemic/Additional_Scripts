library(tidyverse)
library(xml2)
library(XML)

d <- as_tibble(matrix(rnorm(200*50), nrow = 200, ncol = 50))
head(d)
dim(d)


convertToXML <- function(df) {
  xml <- xmlTree()
  xml$addNode("dataset", close=FALSE)
  for (i in 1:nrow(df)) {
    xml$addNode("result", close=FALSE)
    for (j in names(df)) {
      xml$addNode(j, df[i, j])
    }
    xml$closeTag()
  }
  xml$closeTag()
  return(xml)
}

system.time(d_xml <- convertToXML(d))

cat(saveXML(d_xml))

##############################
library(kulife)

system.time(d_xml2 <- write.xml(d, file = "test.xml"))

###############################
library(flatxml)

system.time(d_xml3 <- fxml_toXML(d))

###############################
library(xmlconvert)
system.time(d_xml4 <- df_to_xml(d, record.tag = "result", root.node = "dataset"))
d_xml4

################################
library(xml2)

df <- data.frame(d)
d_list <- vector("list", nrow(df))
for (i in 1:nrow(df)) {
  d_list[[i]] <- df[i,]
}
d_list[[1]]

for (l in d_list) {
  x <- as_xml_document(l)
}
as_xml_document()

as_xml_document(list(dataset = list(result = list(a=1,b=2,c=3,d=4,e=5))))

as_xml_document(list(foo = list(bar = list(baz = list()))))

as_xml_document(list(foo = structure(list(), id = "a")))

