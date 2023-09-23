library(terra)

# Function to process directories and reference the files
process_folder <- function(path) {
  # Get all directories within the specified path
  dirs <- list.dirs(path, recursive = FALSE)
  
  # Iterate over each directory
  for (dir in dirs) {
    print(dir)
    
    # Define the filenames for B1.TIF and fixedmask.img
    b1_file <- list.files(dir, pattern = "_B1.TIF$", full.names = TRUE)
    mask_file <- list.files(dir, pattern = "_fixedmask.img$", full.names = TRUE)
    
    # Read the raster files
    B1 <- rast(b1_file)
    mask <- rast(mask_file)
    
    # Adjust the projection and extent of the mask to match B1
    crs(mask) <- crs(B1)
    ext(mask) <- ext(B1)
    
    # Create the output filename for the mask with the _ref.tif suffix
    output_mask_file <- gsub("_fixedmask.img$", "_fixedmask_ref.tif", mask_file)
    
    # Save the modified raster file
    writeRaster(mask, output_mask_file, overwrite = TRUE)
  }
}

# Call the function to process the directories
process_folder("E:/Jose luis/Tesis Nubes/Biome8/Imagenes")



