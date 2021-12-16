## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.asp = 0.7,
  fig.align = 'center'
)
options(tibble.print_min = 5L, tibble.print_max = 5L)

## ----setup--------------------------------------------------------------------
library(aba)
library(dplyr, warn.conflicts = FALSE)

## -----------------------------------------------------------------------------
data <- adnimerge %>% dplyr::filter(VISCODE == 'bl')

model <- aba_model() %>% 
  set_data(data) %>% 
  set_groups(DX_bl %in% c('MCI','AD')) %>% 
  set_outcomes(ConvertedToAlzheimers, CSF_ABETA_STATUS_bl) %>% 
  set_predictors(
    PLASMA_PTAU181_bl,
    PLASMA_NFL_bl,
    c(PLASMA_PTAU181_bl, PLASMA_NFL_bl)
  ) %>% 
  set_covariates(AGE, GENDER, EDUCATION) %>% 
  set_stats(stat_glm(std.beta=T))

## -----------------------------------------------------------------------------
print(model)

## -----------------------------------------------------------------------------
model <- model %>% fit()

## -----------------------------------------------------------------------------
model_summary <- model %>% summary()
print(model_summary)

## -----------------------------------------------------------------------------
model_summary %>% aba_plot_coef(coord_flip=T)

## -----------------------------------------------------------------------------
model_summary %>% aba_plot_metric()

## -----------------------------------------------------------------------------
model_summary %>% aba_plot_roc()

