library(tidyverse)
library(xml2)
library(httr)

API_key <- "c481e0da54e241c8bc738412a8f9e55f"
catalog <- "GENDER"

# REST APIs
# Catalogue List
url <- "https://openapi.efsa.europa.eu/api/catalogues/catalogue-list"

body <- '{     
   "getCatalogueList": 
   { 			  
    "arg0" : "SSD2", 			  
    "arg1" : "", 			  
    "arg2" : "XML" 		
   } 
}'

r <- POST(url,
          add_headers(`Content-Type` = "application/json",
                      `Ocp-Apim-Subscription-Key` = API_key),
          body = body,
          verbose(),
          progress())

content(r, "text", encoding = "UTF-8")

# Gibt "Internal Server Error" mit Status Code 500, gleich wie im Online Portal
# Ebenso fuer die Catalogues REST API



# SOAP APIs
# Catalogue List
url <- "https://openapi.efsa.europa.eu/api/catalogues.soap"

body <- ('<?xml version="1.0" encoding="utf-8"?>
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
  <Body>
    <getCatalogueList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ws.catalog.dc.efsa.europa.eu/">
      <arg0 xmlns="">SSD2</arg0>
      <arg1 xmlns=""></arg1>
      <arg2 xmlns="">XML</arg2>
    </getCatalogueList>
  </Body>
</Envelope>')

r <- POST(url,
          add_headers(`Content-Type` = "text/xml",
                      `SOAPAction` = "getCatalogueList",
                      `Ocp-Apim-Subscription-Key` = API_key),
          body = body,
          verbose(),
          progress())

xml <- content(r, "text", encoding = "latin1") %>% 
  str_replace_all(pattern = "&lt;", "<") %>% 
  str_extract(., str_c("<catalogue><catalogueDesc><code>",
                catalog,
                "</code>",
                "[[:print:]\\s]+?</catalogue>")
              )

version <- read_xml(xml) %>% 
  xml_find_all("/catalogue/catalogueVersion/version") %>% 
  xml_text()


# Catalogue
url <- "https://openapi.efsa.europa.eu/api/catalogues.soap"

body <- str_c('<?xml version="1.0" encoding="utf-8"?>
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
  <Body>
    <ExportCatalogueFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ws.catalog.dc.efsa.europa.eu/">
      <catalogueCode xmlns="">',
      catalog,
      '</catalogueCode>
      <exportType xmlns="">catalogFullDefinition</exportType>
      <group xmlns="">?</group>
      <dcCode xmlns="">?</dcCode>
      <fileType xmlns="">XML</fileType>
    </ExportCatalogueFile>
  </Body>
</Envelope>')

r <- POST(url,
          add_headers(`Content-Type` = "text/xml",
                      `SOAPAction` = "ExportCatalogueFile",
                      `Ocp-Apim-Subscription-Key` = API_key),
          body = body,
          verbose(),
          progress())

r_text <- content(r, "text", encoding = "latin1")

start_xml <- str_locate(r_text, "<\\?xml version") %>% .[1]
end_xml <- str_locate(r_text, "</message>") %>% .[2]
output <- r_text %>% 
  str_sub(start_xml, end_xml) %>% 
  read_xml()

