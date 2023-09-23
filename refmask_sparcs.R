# Load the 'terra' library
library(terra)

# Get the path
path <- "Z:/cloudcheck/validation/sparcs/sending"

# Function to reference and convert png to tif
process_folder <- function(path) {
  # List files with names ending in "_data.tif"
  stack_files <- list.files(path, pattern = "_data.tif$", full.names = TRUE)
  
  # Loop through the stack files
  for (stack_file in stack_files) {
    print(stack_file)
    
    # Remove the last 9 characters to get the stack path
    stack_path <- substr(stack_file, 1, nchar(stack_file) - 9)
    
    # Create the mask file path
    mask_file <- paste0(stack_path, "_mask.png")
    
    # Read the raster files
    stack <- rast(stack_file)
    mask <- rast(mask_file)
    
    # Adjust the projection and extent of the mask to match the stack
    crs(mask) <- crs(stack)
    ext(mask) <- ext(stack)
    
    # Create the output mask file name with the suffix "_ref.tif"
    output_mask_file <- gsub("_mask.png", "_mask_ref.tif", mask_file)
    
    # Save the modified raster file
    writeRaster(mask, output_mask_file, overwrite = TRUE)
  }
}

# Call the function to process the folders
process_folder(path)
  