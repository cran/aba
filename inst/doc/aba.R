## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
options(tibble.print_min = 5L, tibble.print_max = 5L)

## ----setup--------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)
library(aba)

## -----------------------------------------------------------------------------
data <- adnimerge %>% dplyr::filter(VISCODE == 'bl')

model_spec <- aba_model() %>%
  set_data(data) %>% 
  set_groups(
    everyone(),
    DX_bl %in% c('MCI','AD'),
    labels = c('All','MCI+AD')
  ) %>%
  set_outcomes(ConvertedToAlzheimers, CSF_ABETA_STATUS_bl,
               labels=c('AD','CSF Abeta')) %>%
  set_predictors(
    PLASMA_ABETA_bl,
    PLASMA_PTAU181_bl,
    PLASMA_NFL_bl,
    c(PLASMA_ABETA_bl, PLASMA_PTAU181_bl, PLASMA_NFL_bl)
  ) %>%
  set_stats(stat_glm(std.beta=T))

model_fit <- model_spec %>% fit()
model_summary <- model_fit %>% summary()


## -----------------------------------------------------------------------------
model_summary %>% as_reactable()

