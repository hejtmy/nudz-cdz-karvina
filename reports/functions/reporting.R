report_mixed_effect <- function(model, pred){
  coefs <- summary(model)$coefficients
  res <- coefs[pred, ]
  txt <- paste0("$b = ", round(res[1], 2), "$, ",
                "95% CI [", round(res[1] - 1.96 * res[2], 2), ", ",
                round(res[1] + 1.96 * res[2], 2), "]", ", ",
                "$t(", round(res[3], 2),") = ", round(res[4], 2), "$, ",
                "$p = ", papaja::printp(res[5]), "$")
  return(txt)
}