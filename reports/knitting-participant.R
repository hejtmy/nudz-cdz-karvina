library(withr)
library(helprs)
UNITY_DIR =  "E:/Google Drive/NUDZ/Projects/CDZ Karvina/VR-tasks/logy/2-pilot_VR-pen-paper/"
parameters = list(data_dir = UNITY_DIR, participant = "bohdan")
with_locale(new = c('LC_CTYPE' = helprs::get_czech_platform_locale(),
                    'LC_TIME' = 'Czech'),
            rmarkdown::render("reports/participant.Rmd",
                              params = parameters,
                              output_dir = "reports/participants/",
                              output_file = parameters$participant))
