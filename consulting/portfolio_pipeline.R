# portfolio_pipeline.r
# ---------------------------------------------------------------
# Source of truth for the portfolio on the website.
#
# To update:
#   1. Add / edit a row in `projects` (one line = one project)
#      - use a short code for `inst` (defined in `institutions`);
#        a code that isn't listed is used as-is, so a one-off
#        institution can just be typed out in full
#      - dates are "YYYY-MM"; use NA for an ongoing project
#   2. Run this script: source("portfolio_pipeline.r")
#   3. Re-render the website
#
# To add a column: add it to the tribble header, fill every row,
# then use it in portfolio_functions.r / the .qmd.
# ---------------------------------------------------------------

library(dplyr)
library(tibble)

# ---- Institution lookup (type the short code, get the full name) ----
institutions <- tribble(
  ~short,     ~long,
  "ECCC",     "Environment and Climate Change Canada",
  "NPUST",    "National Pingtung University of Science and Technology",
  "BirdsCan", "Birds Canada",
  "ESRI",     "Endemic Species Research Institute"
)

# ---- Projects ----
# type: "ARU & acoustics" | "Field survey & analysis" | "Data digitization"
projects <- tribble(
  ~start_date, 
  ~end_date, 
  ~host,           
  ~inst,      
  ~title,
  ~location,                   
  ~type,
  
  "2026-09",   
  NA,        
  "Barbara Frei",  
  "ECCC",     
  "Species-specific threshold for Montreal urban bird ARU monitoring",
  "Montreal, Quebec, Canada",              
  "data_pipeline",
  
  "2026-09",   
  NA,        
  "Shiao-Yu Hong", 
  "NPUST",    
  "Individual identification of Eastern Grass Owl with BirdNET embedding",  
  "Neipu, Pingtung, Taiwan",  
  "data_pipeline",
  
  "2024-09",   
  "2025-03", 
  "David Bradley", 
  "BirdsCan", 
  "Process BC & Maritime provinces ARU data through BirdNET",
  "Delta, BC, Canada",                
  "data_pipeline",
  
  "2023-09",   
  "2024-03", 
  "David Bradley", 
  "BirdsCan", 
  "Process BC ARU data through BirdNET",
  "Delta, BC, Canada",                
  "data_pipeline",
  
  "2020-04",   
  "2021-07", 
  "Jerome Ko",     
  "ESRI",     
  "Field bird survey & eBird citizen science data analysis",  
  "Jiji, Nantou, Taiwan",     
  "data_pipeline",
  
  "2020-02",   
  "2020-03", 
  "David Bradley", 
  "BirdsCan", 
  "Digitalize historical BC bird survey data",  
  "Ladner, BC, Canada",                
  "data_pipeline"
)

# ---- Build the final table ----
portfolio_pipeline <- projects |>
  mutate(end_date = as.character(end_date)) |>
  left_join(institutions, by = c("inst" = "short")) |>
  mutate(institution = coalesce(long, inst)) |>   
  select(-long, -inst)

# ---- Save as .rda ----
save(portfolio_pipeline,
     file = "consulting/portfolio_pipeline.rda")


