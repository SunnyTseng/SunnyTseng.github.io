# portfolio_functions.r
# Helpers that turn the portfolio data into a display table.
# Used by the .qmd:  source("portfolio_functions.r")

library(dplyr)
library(gt)

# "2026-09" -> Date; NA stays NA (no "NA-01" errors)
parse_ym <- function(x) {
  as.Date(if_else(is.na(x), NA_character_, paste0(x, "-01")))
}

# Add the display columns `Date` and `Details`, newest first
format_portfolio <- function(d) {
  d |>
    arrange(desc(start_date)) |>
    mutate(
      start_fmt = format(parse_ym(start_date), "%b %Y"),
      end_fmt   = format(parse_ym(end_date), "%b %Y"),
      Date = if_else(is.na(end_date),
                     paste0(start_fmt, " \u2013 Present"),
                     paste0(start_fmt, " \u2013 ", end_fmt)),
      # "  \n" = markdown hard line break
      Details = paste0("**", title, "**  \n",
                       host, " - ", institution, "  \n",
                       location)
    ) |>
    select(Date, Details)
}

# Shared table look: no header row, full width, narrow date column
fmt_gt <- function(d) {
  
  gt(d) |>
    fmt_markdown(columns = any_of(c("Details"))) |>
    cols_align(align = "left") |>
    tab_options(column_labels.hidden = TRUE,
                table.width = "100%",
                table.font.size = pct(80),
                data_row.padding = px(6)) |>      # tighter rows
    cols_width(1 ~ "20%")
}