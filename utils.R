library(rgee)

# Función para verificar la existencia de una imagen
checkImageExistence <- function(imageId, collectionPrefixes) {
  # Iterar sobre cada prefijo y verificar la existencia
  for (prefix in collectionPrefixes) {
    collectionPath <- paste0(prefix, imageId)
    
    # Intentar obtener información de la imagen
    # Si el siguiente comando no genera un error, significa que la imagen existe.
    image_exist <- tryCatch({
      img <- ee$Image(collectionPath)
      TRUE
    }, error = function(e) {
      FALSE
    })
    
    if (image_exist) {
      cat(sprintf("La imagen %s existe", collectionPath), "\n")
      return(collectionPath) # Salir de la función si la imagen se encuentra
    }
  }
  
  # Si llega aquí, es porque no encontró la imagen en ninguna colección
  cat('La imagen no fue encontrada en ninguna de las colecciones listadas.', "\n")
  return(NA)
}