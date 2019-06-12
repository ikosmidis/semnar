#' Create or add to a \code{seminaR} object
#'
#' @param object an object an object of class \code{"seminaR"}.
#' @param country country of the talk/seminar; character string or \code{NA} (default).
#' @param city city of the talk/seminar; character string or \code{NA} (default).
#' @param lon longitude of the venue of the talk/seminar; numeric or \code{NA} (default).
#' @param lat latitude of the venue of the talk/seminar; numeric or \code{NA} (default).
#' @param event name of the event at which the talk/seminar is/was given; character string or \code{NA} (default).
#' @param presenter either \code{NA} (default) or an object of class \code{\link{seminaR_presenter}}. In the latter case, all input to the \code{presenter_*} arguments below is ignored and populated according to the supplied object.
#' @param presenter_name name of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param presenter_midname middle name of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param presenter_surname surname of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param presenter_affiliation  affiliation of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param presenter_link  link to the webpage of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param presenter_email  email of the presenter of the talk/seminar; character string or \code{NA} (default).
#' @param title title of the talk/seminar; character string or \code{NA} (default).
#' @param abstract abstract of the talk/seminar; character string or \code{NA} (default).
#' @param type the type of the talk. Available options are \code{NA} (default), \code{"seminar"}, \code{"lecture"}, \code{"presentation"}, \code{"talk"}, \code{"poster"}.
#' @param link link to the event or seminar/talk page; character string or \code{NA} (default).
#' @param institution institution at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param department department at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param school school at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param venue venue at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param room room at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param year year of the talk/seminar; numeric, e.g. \code{2019}, or \code{NA} (default).
#' @param month month of the talk/seminar; numeric (1-12) or \code{NA} (default).
#' @param day day of the talk/seminar; numeric (1-31) or \code{NA} (default).
#' @param start_hour start hour of the talk/seminar; numeric (1-24) or \code{NA} (default).
#' @param end_hour end hour of the talk/seminar; numeric (1-24) or \code{NA} (default).
#' @param start_min start minute of the talk/seminar; numeric (0-60) or \code{NA} (default).
#' @param end_min end minute of the talk/seminar; numeric (0-60) or \code{NA} (default).
#' @param start_sec start second of the talk/seminar; numeric (0-60) or \code{NA} (default).
#' @param end_sec end second of the talk/seminar; numeric (0-60) or \code{NA} (default).
#' @param tz timezone. Default is \code{"UTC"}. See \code{\link{DateTimeClasses}} for details.
#'
#' @details
#' If \code{object} is not specified then \code{add_talk} will create an \code{seminaR} objects based on the supplied inputs, otherwise it will add the details of the new talk/seminar on \code{object}.
#'
#' @return
#' A structured \code{\link{data.frame}} that also inherits from class \code{seminaR}, including the supplied talk/seminar details.
#' @export
add_presentation <- function(object,
                             presenter = NA,
                             presenter_name = NA,
                             presenter_midname = NA,
                             presenter_surname = NA,
                             presenter_affiliation = NA,
                             presenter_email = NA,
                             presenter_link = NA,
                     country = NA,
                     city = NA,
                     lon = NA,
                     lat = NA,
                     event = NA,
                     title = NA,
                     abstract = NA,
                     type = NA,
                     link = NA,
                     institution = NA,
                     department = NA,
                     school = NA,
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
    types <- c(NA, "seminar", "lecture", "presentation", "talk", "poster")
    if (!(type %in% types)) {
        stop("`type` should be one of", types)
    }
    start_datetime <- make_datetime(year = year,
                                    month = month,
                                    day = day,
                                    hour = ifelse(is.na(start_hour), 0, start_hour),
                                    min = ifelse(is.na(start_min), 0, start_min),
                                    sec = ifelse(is.na(start_sec), 0, start_sec),
                                    tz = tz)
    end_datetime <- make_datetime(year = year,
                                  month = month,
                                  day = day,
                                  hour = ifelse(is.na(end_hour), 0L, end_hour),
                                  min = ifelse(is.na(end_min), 0L, end_min),
                                  sec = ifelse(is.na(end_sec), 0, end_sec),
                                  tz = tz)
    if (inherits(presenter, "seminaR_presenter")) {
        presenter_name <- presenter$name
        presenter_midname <- presenter$midname
        presenter_surname <- presenter$surname
        presenter_affiliation <- presenter$affiliation
        presenter_email <- presenter$email
        presenter_link <- presenter$link
    }
    next_seminar <-  data.frame(country = country,
                                city = city,
                                lon = lon,
                                lat = lat,
                                event = event,
                                presenter_name = presenter_name,
                                presenter_midname = presenter_midname,
                                presenter_surname = presenter_surname,
                                presenter_affiliation = presenter_affiliation,
                                presenter_link = presenter_link,
                                presenter_email = presenter_email,
                                title = title,
                                link = link,
                                abstract = abstract,
                                venue = venue,
                                institution = institution,
                                department = department,
                                school = school,
                                type = type,
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
    if (!inherits(next_seminar, "seminaR")) {
        class(next_seminar) <- c("seminaR", class(next_seminar))
    }
    return(next_seminar)
}
