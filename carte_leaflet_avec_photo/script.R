

### Chargement des librairies
library(leaflet)
library(base64enc)
library(dplyr)

### Importation de données
df <- read.csv("data/df.csv")
head(df)

dossier_images = 'images'


### Création d'une colonne pour les images encodées en base64
df <- df |> 
  rowwise() |>
  mutate(photo_encoded = dataURI(
    file = file.path(dossier_images, photo_mild), 
    mime = "image/png"))

### Première carte 
(m <- leaflet(df) %>%
    addTiles())


### Ajout des points et affichage des photos
for (i in 1:nrow(df)) {
  m <- m %>%
    addMarkers(
      lng = df$longitude[i],
      lat = df$latitude[i],
      popup = paste0("<table>",
                     "<tr>",
                     "<td>Nom du chef de ménage</td>",
                     paste("<td>:", df$nom_chef[i], "</td>"),
                     "</tr>",
                     "</table>",
                     "<img src='", df$photo_encoded[i], "' width='200' height='150'>")
    )
}

### Afficher la carte
m





