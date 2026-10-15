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
  
  "ECCC", "Environment and Climate Change Canada",
  "CWS", "Canadian Wildlife Service",
  "ESRI", "Endemic Species Research Institute",
  
  "BirdsCan", "Birds Canada",
  
  "NPUST", "National Pingtung University of Science and Technology",
  "UNBC", "University of Northern British Columbia",
  "UBC", "University of British Columbia",
  "USask", "University of Saskatchewan"
)

# ---- Projects ----
projects <- tribble(
  ~start_date, 
  ~end_date, 
  ~host,           
  ~inst, 
  ~location,
  ~title,
  ~role,
  ~type,
  
  ## Data pipelines here
  
  "2026-09",   
  NA,        
  "Barbara Frei",  
  "ECCC",
  "Montreal, Quebec, Canada",
  "Species-specific threshold for Montreal urban bird ARU monitoring",
  "Data Analyst",
  "data_pipeline",
  
  
  "2026-09",   
  NA,        
  "Shiao-Yu Hong", 
  "NPUST",
  "Neipu, Pingtung, Taiwan",
  "Individual identification of Eastern Grass Owl with BirdNET embedding",
  "Data Analyst",
  "data_pipeline",
  
  "2024-09",   
  "2025-03", 
  "David Bradley", 
  "BirdsCan",
  "Delta, BC, Canada",
  "Process BC & Maritime provinces ARU data through BirdNET",
  "Data Analyst",
  "data_pipeline",
  
  "2023-09",   
  "2024-03", 
  "David Bradley", 
  "BirdsCan", 
  "Delta, BC, Canada",
  "Process BC ARU data through BirdNET",
  "Data Analyst",
  "data_pipeline",
  
  "2020-04",   
  "2021-07", 
  "Jerome Ko",     
  "ESRI",     
  "Jiji, Nantou, Taiwan",
  "Field bird survey & eBird citizen science data analysis", 
  "Data Analyst",
  "data_pipeline",
  
  "2020-02",   
  "2020-03", 
  "David Bradley", 
  "BirdsCan", 
  "Ladner, BC, Canada",
  "Digitalize historical BC bird survey data",
  "Data Analyst",
  "data_pipeline",
  
  
  ## Workshops here
  "2026-02", 
  NA,        
  "Library Graduate Student Workshop Development Program", 
  "UNBC",  
  "Virtual", 
  "Introduction to Git & GitHub",                              
  "Instructor",                     
  "workshop_data_science",
  
  
  "2025-08", 
  NA,        
  "SCO-SOC annual conference",                             
  "USask", 
  "Saskatoon, SK, Canada", 
  "BirdNET workshop",                                         
  "Co-instructor with Jenn Foote",  
  "workshop_bioacoustics",
  
  "2023-03", 
  NA,        
  "Jennifer Wigglesworth",                                 
  "UNBC",  
  "Virtual", 
  "Qualitative Analysis using R",                             
  "Instructor",                     
  "workshop_data_science",
  
  "2022-11", 
  NA,        
  "Applied Analysis Hub",                                  
  "UNBC",  
  "Virtual", 
  "Introduction to Git and GitHub",                           
  "Instructor",                     
  "workshop_data_science",
  
  "2022-03", 
  NA,        
  "Applied Analysis Hub",                                  
  "UNBC",  
  "Virtual", 
  "Data Wrangling with R",                                    
  "Instructor",                     
  "workshop_data_science",
  
  "2021-05", 
  "2021-07", 
  "Jerome Ko",                                             
  "ESRI",  
  "Jiji, Nantou, Taiwan", 
  "Data Wrangling with R (4 sessions)",                       
  "Instructor",                     
  "workshop_data_science",
  
  "2020-12", 
  "2021-03", 
  "Luna Fan",                                              
  "ESRI",  
  "Jiji, Nantou, Taiwan", 
  "Recording Techniques for Breeding Bird Surveys (6 sessions)", 
  "Instructor",                  
  "workshop_bioacoustics",
  
  "2018-10", 
  NA,        
  "Kathy Martin",                                          
  "CWS",   
  "Delta, BC, Canada", 
  "Automatic bird sound detection: ARU data analysis",        
  "Instructor",                     
  "workshop_bioacoustics",
  
  "2018-01", 
  "2018-04", 
  "Trevor Gareth Jones",                                   
  "UBC",   
  "Vancouver, BC, Canada", 
  "Statistical Analysis in Ecology (5 sessions)",             
  "Instructor",                     
  "workshop_data_science"
  
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


