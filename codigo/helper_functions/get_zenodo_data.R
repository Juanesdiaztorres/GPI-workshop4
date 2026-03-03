#=========================== get_zenodo_data ==============================

# get_zonodo_data.R
#
# Purpose: This script automates the acquisition of data directly from Zenodo
# repositories using the Zenodo API. It downloads specified datasets and 
# prepares them for analysis.
#
# Dependencies:
# - rjson: For parsing JSON data from API response
# - rio: For importing various data formats
# - tidyr: For data tidying operations
# - dplyr: For data manipulation
# - here: For path management
# - janitor: For cleaning variable names

# Load required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(rjson, rio, tidyr, dplyr, here, janitor)

#' Download and prepare data from Zenodo repository
#'
#' @param zenodo_id The ID of the Zenodo repository
#' @param api_endpoint The Zenodo API endpoint (default: sandbox environment)
#' @param output_dir Directory to save the downloaded data (default: temporary directory)
#' @param filename Name to save the downloaded file (default: "data.csv")
#' @return A data frame containing the imported and cleaned data
#' @examples
#' # Get data from a specific Zenodo repository
#' survey_data <- get_zenodo_data("169207")
get_zenodo_data <- function(zenodo_id, 
                            api_endpoint = "https://zenodo.org/api/records/",
                            output_dir = tempdir(),
                            filename = "data.csv") {
  
  # Step 1: Construct API URL for the specified Zenodo record
  api_url <- paste0(api_endpoint, zenodo_id)
  
  # Step 2: Create a temporary file to store metadata
  metadata_file <- file.path(output_dir, "metadata.json")
  
  # Step 3: Download metadata from Zenodo API
  message("Downloading metadata from Zenodo...")
  download_status <- download.file(api_url, destfile = metadata_file)
  
  if (download_status != 0) {
    stop("Failed to download metadata from Zenodo API")
  }
  
  # Step 4: Parse the metadata JSON file
  message("Parsing metadata...")
  metadata <- fromJSON(file = metadata_file)
  
  # Step 5: Extract file info from metadata
  if (length(metadata$files) == 0) {
    stop("No files found in the Zenodo repository")
  }
  
  file_url  <- metadata$files[[1]]$links$self
  file_name <- metadata$files[[1]]$key
  
  # Step 6: Prepare output file path
  output_file <- file.path(output_dir, file_name)
  
  # Step 7: Download the actual data file
  message("Downloading data file...")
  download_status <- download.file(file_url, destfile = output_file)
  
  if (download_status != 0) {
    stop("Failed to download data file from Zenodo")
  }
  
  # Step 8: Import the downloaded data
  message("Importing data...")
  
  file_ext <- tools::file_ext(output_file)
  
  if (file_ext == "rds") {
    data <- readRDS(output_file)
  } else {
    data <- import(output_file)
  }
  
  # Return the cleaned data frame
  return(data)
}