add_seminaR <- function(object,
                        country = NA,
                        city = NA,
                        lon = NA,
                        lat = NA,
                        event = NA,
                        presenter = NA,
                        title = NA,
                        abstract = NA,
                        link = NA,
                        university = NA,
                        department = NA,
                        venue = NA,
                        room = NA,
                        year = NA,
                        month = NA,
                        day = NA,
                        start_hour = NA,
                        end_hour = start_hour,
                        start_min = 0L,
                        end_min = start_min,
                        start_sec = 0L,
                        end_sec = 0L,
                        tz = "UTC") {
    ## Allow seminars that last hours but not days
    start_datetime <- make_datetime(year = year,
                                    month = month,
                                    day = day,
                                    hour = start_hour,
                                    min = start_min,
                                    sec = start_sec,
                                    tz = "UTC")
    end_datetime <- make_datetime(year = year,
                                  month = month,
                                  day = day,
                                  hour = end_hour,
                                  min = end_min,
                                  sec = end_sec,
                                  tz = "UTC")
    next_seminar <-  data.frame(country = country,
                                city = city,
                                lon = lon,
                                lat = lat,
                                event = event,
                                presenter = presenter,
                                title = title,
                                link = link,
                                abstract = abstract,
                                venue = venue,
                                university = university,
                                department = department,
                                room = room,
                                start = start_datetime,
                                end = end_datetime,
                                stringsAsFactors = FALSE)
    if (!missing(object)) {
        if (inherits(object, "seminaR")) {
            next_seminar <- rbind(object, next_seminar)
        }
        else {
            stop("`object` is not of class `seminaR`")
        }
    }
    class(next_seminar) <- c("seminaR", class(next_seminar))
    return(next_seminar)
}
