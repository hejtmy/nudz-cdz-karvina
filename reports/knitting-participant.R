library(withr)
library(helprs)
UNITY_DIR <- "E:/Google Drive/NUDZ/Projects/CDZ Karvina/VR-tasks/logy/2-pilot_VR-pen-paper/"
participants <- list.dirs(file.path(UNITY_DIR, "supermarket"), recursive = FALSE, full.names = FALSE)

#19 is zaloha
for(n in participants[20:21]){
parameters <- list(data_dir = UNITY_DIR, participant = n)
with_locale(new = c('LC_CTYPE' = helprs::get_czech_platform_locale(),
                    'LC_TIME' = 'Czech'),
            rmarkdown::render("reports/participant.Rmd",
                              params = parameters,
                              output_dir = "reports/participants/",
                              output_file = parameters$participant))
}
