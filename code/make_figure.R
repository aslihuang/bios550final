# make_figure.R
# Creates Figure 1: Maximum Heart Rate by Chest Pain Type and Heart Disease Status
# Output: output/figure1.png

library(tidyverse)

heart <- read.csv("data/heart.csv")

heart <- heart %>%
  mutate(
    HeartDisease_label = ifelse(HeartDisease == 1, "Heart Disease", "Normal"),
    ChestPainType_label = case_when(
      ChestPainType == "TA"  ~ "Typical Angina",
      ChestPainType == "ATA" ~ "Atypical Angina",
      ChestPainType == "NAP" ~ "Non-Anginal Pain",
      ChestPainType == "ASY" ~ "Asymptomatic"
    )
  )

p <- ggplot(heart, aes(x = ChestPainType_label, y = MaxHR, fill = HeartDisease_label)) +
  geom_boxplot(alpha = 0.75, outlier.shape = 21, outlier.size = 1.5) +
  scale_fill_manual(
    values = c("Heart Disease" = "#E74C3C", "Normal" = "#3498DB")
  ) +
  labs(
    title = "Maximum Heart Rate by Chest Pain Type and Heart Disease Status",
    x = "Chest Pain Type",
    y = "Maximum HR"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "top",
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12)
  )

ggsave("output/figure1.png", plot = p, width = 9, height = 5.5, dpi = 300)
