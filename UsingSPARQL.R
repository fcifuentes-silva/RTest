# ---- Instalar los packages la primera vez
#install.packages("SPARQL")
library(SPARQL)
library(dplyr)

# ---- Inicializar datos básicos
endpoint<-"http://datos.bcn.cl/sparql"
prefix <- c('bcnbio','<http://datos.bcn.cl/ontologies/bcn-biographies#>',
            "bio","http://purl.org/vocab/bio/0.1/",
            "foaf","http://xmlns.com/foaf/0.1/",
            "time","http://www.w3.org/2006/time#")

# ---- Primera consulta
consulta1 <- "SELECT count(*) as ?total WHERE {
     ?s a foaf:Person 
     }"

res1 <- SPARQL(url=endpoint,
            query=consulta1,
            ns=prefix)


View(res1$results)


# ---- Segunda consulta
consulta2 <- "SELECT ?s ?nombre ?anio WHERE {
     ?s a foaf:Person;
     foaf:name ?nombre;
     bcnbio:hasBorn ?nacimiento .
     ?nacimiento bio:date ?fecha .
     ?fecha time:year ?anio .
     }"

res2 <- SPARQL(url=endpoint,
            query=consulta2,
            ns=prefix)

View(res2$results)

# ---- Agrupar datos y graficar

datos <- res2$results

datos %>% summary

hist(datos$anio)

