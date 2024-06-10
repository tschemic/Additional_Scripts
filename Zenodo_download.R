# Skript zum Download der Daten aus Zenodo

library(tidyr)
library(dplyr)
library(stringr)
library(rvest)
library(httr)
library(openxlsx)
# library(readr)




url_list <- read.xlsx("Link_Liste_Zenodo.xlsx") %>% tibble()



#### Links der Datensaetze aus einer Seite extrahieren ####
# url <- "https://zenodo.org/records/11517855"

link_list <- c()
for (url in url_list$Link) {
  html <- read_html(GET(url))
  
  links <- html %>% html_elements("body") %>% 
    html_elements(xpath = "//div[@class='collapse in']") %>% 
    html_elements(xpath = "//table[@class='table table-striped']") %>% 
    html_elements("tbody") %>% 
    html_elements("tr") %>% 
    html_elements(xpath = "//a[@class='filename']") %>% 
    html_attr('href') %>% 
    str_c("https://zenodo.org", .)
  
  links <- html %>% html_elements("body") %>% 
    html_elements(xpath = "//div[@class='active content pt-0']") %>% 
    html_elements(xpath = "//table[@class='ui striped table files fluid open']") %>% 
    html_elements("tbody") %>% 
    html_elements("tr") %>% 
    html_elements(xpath = "//a[@class='ui compact mini button']") %>% 
    html_attr('href') %>% 
    str_c("https://zenodo.org", .)
  
  link_list <- c(link_list, links)
}


write.csv2(tibble(datasets = link_list), "VMPR_Datensaetze.txt", 
           row.names = FALSE, quote = FALSE)

link_list <- read.csv2("VMPR_Datensaetze.txt")$datasets

link_list_sub <- link_list[1:5]

# Datensaetze downloaden

for (l in link_list_sub) {
  name <- str_extract(l, "VMPR_.+[Pz](?=\\?)")
  
  download.file(url = l, 
                destfile = file.path("datasets", name))
}

# Problem: ZIP Files enthalten zwar den Datensatz mit richtiger Größe, beim 
# entpacken gibt es aber einen Fehler. (header error)
# Bei Download im Browser können die ZIP Files problemlos entpackt werden.
# Download auf nicht-AGES Computer funktioniert - Files von dort transferiert



