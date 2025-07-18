library(tidyverse)
library(rvest)
library(scales)

# 1. Read the page
url <- "https://en.wikipedia.org/wiki/List_of_natural_disasters_by_death_toll"
page <- rvest::read_html(url)
tables <- page %>% rvest::html_nodes("table.wikitable")

# Inspect table headers
for (i in seq_along(tables)) {
  cat("Table", i, "columns:\n")
  print(tables[[i]] %>% html_table(fill = TRUE) %>% names())
  cat("\n")
}

# tables[[2]] = 20th‑century, tables[[3]] = 21st‑century
df_20th <- tables[[2]] %>%
  html_table(fill = TRUE) %>%
  as_tibble() %>%
  mutate(Century = "20th")

df_21st <- tables[[3]] %>%
  html_table(fill = TRUE) %>%
  as_tibble() %>%
  mutate(Century = "21st") %>%
  rename(`Death tolls` = `Death toll`)

df_all <- bind_rows(df_20th, df_21st)


write.csv(df_all,file='raw_table.csv', row.names = T)


df_clean <- df_all %>%
  # strip commas, unify dashes, remove spaces
  mutate(
    `dt_clean` = `Death tolls` %>%
      str_remove_all(",") %>%
      str_remove_all("\\[.*?\\]") %>%
      str_replace_all("\u2013", "-") %>%  # unify all punctuation marks to hyphen
      str_remove_all("\\s")
  ) %>%
  # split all data into low/high 
  separate(dt_clean, into = c("low","high"), sep = "-", fill = "right", remove = FALSE) %>%
  # strip any trailing “+” and convert
  mutate(
    low  = as.numeric(str_remove_all(low, "\\+")),
    high = as.numeric(str_remove_all(high, "\\+")),
    death_toll_num = if_else(
      !is.na(high),        # if a range was given
      ceiling((low + high) / 2),    # use midpoint and take the ceiling
      low                  # otherwise take the single or bound value
    )
  ) %>%
  select(-`Death tolls`, -dt_clean, -low, -high)


write.csv(df_clean,file='cleaned_table.csv', row.names = T)

# Plot death toll by year, colored by disaster Type
plot <- ggplot(df_clean, aes(x = Year, y = death_toll_num, color = Type)) +
  geom_point(alpha = 0.7) +
  scale_y_continuous(labels = comma) +
  labs(
    x     = "Year",
    y     = "Estimated Death Toll",
    color = "Disaster Type",
    title = "20th & 21st Century Natural Disasters by Death Toll"
  ) +
  theme_minimal()


# save as PDF
ggsave(
  filename = "question_1_plot.pdf",
  plot     = plot,
  device   = "pdf",
  width    = 12,
  height   = 6
)

# save as PNG
ggsave(
  filename = "question_1_plot.png",
  plot     = plot,
  device   = "png",
  width    = 12,
  height   = 6,
  dpi      = 320
)


