# make_table.R
# Creates Table 1: Clinical Characteristics by Heart Disease Status
# Output: output/table1.rds

library(tidyverse)

heart <- read.csv("data/heart.csv")

heart <- heart %>%
  mutate(
    HeartDisease_label = ifelse(HeartDisease == 1, "Heart Disease", "Normal"),
    Sex_label = ifelse(Sex == "M", "Male", "Female"),
    FastingBS_label = ifelse(FastingBS == 1, "> 120 mg/dl", "<= 120 mg/dl"),
    ExerciseAngina_label = ifelse(ExerciseAngina == "Y", "Yes", "No")
  )

summary_df <- heart %>%
  group_by(HeartDisease_label) %>%
  summarise(
    N = as.character(n()),
    `Age, mean (SD)` = paste0(round(mean(Age), 1), " (", round(sd(Age), 1), ")"),
    `Male, n (%)` = paste0(sum(Sex == "M"), " (", round(100 * mean(Sex == "M"), 1), "%)"),
    `Resting BP, mean (SD)` = paste0(round(mean(RestingBP), 1), " (", round(sd(RestingBP), 1), ")"),
    `Cholesterol, mean (SD)` = paste0(round(mean(Cholesterol), 1), " (", round(sd(Cholesterol), 1), ")"),
    `Fasting BS > 120, n (%)` = paste0(sum(FastingBS == 1), " (", round(100 * mean(FastingBS == 1), 1), "%)"),
    `Max HR, mean (SD)` = paste0(round(mean(MaxHR), 1), " (", round(sd(MaxHR), 1), ")"),
    `Exercise Angina, n (%)` = paste0(sum(ExerciseAngina == "Y"), " (", round(100 * mean(ExerciseAngina == "Y"), 1), "%)"),
    `Oldpeak, mean (SD)` = paste0(round(mean(Oldpeak), 1), " (", round(sd(Oldpeak), 1), ")")
  ) %>%
  pivot_longer(-HeartDisease_label, names_to = "Characteristic", values_to = "Value") %>%
  pivot_wider(names_from = HeartDisease_label, values_from = Value)

saveRDS(summary_df, file = "output/table1.rds")
