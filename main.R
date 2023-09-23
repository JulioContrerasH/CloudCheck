# -----------------------------
# Step 1: Read the Dataset
# -----------------------------
library(rgee)
# ee_Initialize()

# Read the dataset from the specified path
df <- read.csv("D:/CURSOS_2022/Repos/CloudCheck/data/IDs.csv", sep = ";")

# -----------------------------
# Step 2: Format the 'scene_id'
# -----------------------------

# Extract scene_id from the dataframe 
# and format it by adding a '0' between the 2nd and 3rd characters
id1 <- paste0(substr(df$scene_id, 1, 2), "0", substr(df$scene_id, 3, nchar(df$scene_id)))

# Insert an underscore "_" after the 4th character of the string from id1
id2 <- paste0(substr(id1, 1, 4), "_", substr(id1, 5, nchar(id1)))

# Insert another underscore "_" after the 10th character of the string from id2
id3 <- paste0(substr(id2, 1, 11), "_", substr(id1, 11, nchar(id2)))

# -----------------------------
# Step 3: Extract and Convert Dates
# -----------------------------

# Extract the year and day values from the string in id3
anos <- as.numeric(substr(id3, 13, 16))
dias <- as.numeric(substr(id3, 17, 19))

# Convert the extracted year into a date format representing January 1st of that year
fechas <- as.Date(paste0(anos, "-01-01"))

# Calculate the actual date by adding the day value 
# (minus 1 because we started with January 1st)
new_fechas <- fechas + dias - 1

# -----------------------------
# Step 4: Extract Month and Day
# -----------------------------

# Extract month and day values from the new_fechas
mes <- format(new_fechas, "%m")
dia <- format(new_fechas, "%d")

# Combine the extracted month and day values
mes_dia <- paste0(mes, dia)

# -----------------------------
# Step 5: Finalize the 'scene_id'
# -----------------------------

# Combine the initial part of id3 with the newly formatted month and day values to get the final ids
ids <- paste0(substr(id3, 1, nchar(id3) - 8), mes_dia)

# Update the 'scene_id' column in the dataframe with the newly formatted ids
df$scene_id <- ids

# -----------------------------
# Step 6: Initialize Earth Engine and Check Image Existence
# -----------------------------

# Load external utility functions
source("D:/CURSOS_2022/Repos/CloudCheck/utils.R")

# Check existence of each image ID and update the dataframe
for (i in 1:nrow(df)) {
  df[i, "gee_id"] <- checkImageExistence(df$scene_id[i])
}

# -----------------------------
# Step 7: Save the Results
# -----------------------------

# Write the updated dataframe to a new CSV file
write.csv(df, "D:/CURSOS_2022/Repos/CloudCheck/results/table.csv", row.names = F)


