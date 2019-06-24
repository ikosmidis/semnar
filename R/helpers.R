n2e <- function(x) {
    ifelse(is.na(x), "", x)
}

date2text <- function(start, end, tz, interval = TRUE) {
    h <- hour(start) == hour(end)
        m <- minute(start) == minute(end)
    s <- second(start) == second(end)
    if (interval) {
        ret <- ifelse(h & m & s,
                      paste("Date & Time:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                            strftime(start, format = date_format, tz = tz)),
                      paste("Date & Time:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                            strftime(start, format = date_format, tz = tz),
                            ifelse(is.na(start), "", paste0(strftime(start, format = "%H:%M", tz = tz), "-",
                                                            strftime(end, format = "%H:%M", tz = tz)))))
    }
    else {
            ret <- ifelse(inds,
                          paste(paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                      ifelse(is.na(start), "",
                                             strftime(start, format = paste(date_format, "%H:%M"), tz = tz))),
                                paste("End:", as.character(wday(end, abbr = TRUE, label = TRUE)),
                                      ifelse(is.na(end), "",
                                             strftime(end, format = paste(date_format, "%H:%M"), tz = tz))),
                                sep = "<br/>"),
                          paste(paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE))),
                                paste("End:", as.character(wday(end, abbr = TRUE, label = TRUE))),
                                sep = "<br/>"))
    }
    ret
}
