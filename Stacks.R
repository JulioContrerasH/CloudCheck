library(terra)

# Function to process directories and reference the files
process_folder <- function(path) {
  # Get all directories within the specified path
  dirs <- list.dirs(path, recursive = FALSE)
  
  # Iterate over each directory
  for (dir in dirs) {
    print(dir)
    
    # Define the filenames for B1.TIF and fixedmask.img
    files <- list.files(dir, pattern = "_B[1-7]\\.TIF$", full.names = TRUE)
    files <- sort(files)
    stack_bands <- rast(files)
    
    # Create the output filename for the mask with the _ref.tif suffix
    output_mask_file <- gsub("_B[1-7]\\.TIF$", "stack.tif", files[1])
    
    # Save the modified raster file
    writeRaster(stack_bands, output_mask_file, overwrite = TRUE)
  }
}

# Call the function to process the directories
process_folder("E:/Jose luis/Tesis Nubes/Biome8/Imagenes")
