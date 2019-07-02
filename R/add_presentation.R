#' Create or add to a \code{\link{semnar}} object
#'
#' @aliases semnar
#' @param object either an object an object of class \code{\link{semnar}} or unspecified (default). See Details.
#' @param country country where the presentation took place; character string or \code{NA} (default).
#' @param city city where the presentation took place; character string or \code{NA} (default).
#' @param state state where the presentation took place; character string or \code{NA} (default).
#' @param lon longitude of the venue of the presentation; numeric or \code{NA} (default).
#' @param lat latitude of the venue of the presentation; numeric or \code{NA} (default).
#' @param event name of the event at which the presentation is/was given; character string or \code{NA} (default).
#' @param presenter either \code{NA} (default) or an object of class \code{\link{semnar_presenter}}. In the latter case, all input to the \code{presenter_*} arguments below is ignored and populated according to the supplied object.
#' @param presenter_name name of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_midname middle name of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_surname surname of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_affiliation  affiliation of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_link  link to the webpage of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_email  email of the presenter of the presentation; character string or \code{NA} (default).
#' @param presenter_address address of the presenter; character string or \code{NA} (default).
#' @param title title of the presentation; character string or \code{NA} (default).
#' @param abstract abstract of the presentation; character string or \code{NA} (default).
#' @param type the type of the talk. Available options are \code{NA} (default), \code{"seminar"}, \code{"lecture"}, \code{"presentation"}, \code{"talk"}, \code{"poster"}.
#' @param link link to the event or seminar/talk page; character string or \code{NA} (default).
#' @param materials link to the slides or materials from the seminar/talk; character string or \code{NA} (default).
#' @param institution institution at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param department department at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param school school at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param venue venue at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param address address where the seminar/talk took place; character string or \code{NA} (default).
#' @param postcode post code where the seminar/talk took place; character string or \code{NA} (default).
#' @param room room at which the event or seminar/talk page took/will take space; character string or \code{NA} (default).
#' @param year year of the presentation; numeric, e.g. \code{2019}, or \code{NA} (default).
#' @param month month of the presentation; numeric (1-12) or \code{NA} (default).
#' @param day day of the presentation; numeric (1-31) or \code{NA} (default).
#' @param start_hour start hour of the presentation; numeric (1-24) or \code{NA} (default).
#' @param end_hour end hour of the presentation; numeric (1-24) or \code{NA} (default).
#' @param start_min start minute of the presentation; numeric (0-60) or \code{NA} (default).
#' @param end_min end minute of the presentation; numeric (0-60) or \code{NA} (default).
#' @param start_sec start second of the presentation; numeric (0-60) or \code{NA} (default).
#' @param end_sec end second of the presentation; numeric (0-60) or \code{NA} (default).
#' @param tz timezone. Default is \code{"UTC"}. See \code{\link{DateTimeClasses}} for details.
#' @param tag a tag for the presentation; character string or \code{NA} (default).
#'
#' @details
#' If \code{object} is not specified then \code{add_presentation} will create an \code{\link{semnar}} object based on the supplied inputs, otherwise it will add the details of the new presentation on \code{object}.
#'
#' @return
#' A structured \code{\link{data.frame}} that also inherits from class \code{\link{semnar}}, including the supplied presentation details.
#'
#' @seealso \code{\link{presenter}} \code{\link{plot.semnar}} \code{\link{shorten_url}} \code{\link{guess_address}}
#'
#' @examples
#' # Two of my past talks
#'
#'
#' library("magrittr")
#' out <- add_presentation(country = "England", city = "Coventry",
#'                         lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         materials = "http://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathematical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00) %>%
#'         add_presentation(country = "United States", city = "Stanford",
#'                          lon = -122.165330, lat = 37.429464,
#'                          event = "useR! 2016",
#'                          title = "brglm: Reduced-bias inference in generalized linear models",
#'                          link = "http://user2016.r-project.org//files/abs-book.pdf",
#'                          materials = "https://bit.ly/2KCBbKg",
#'                          type = "presentation", institution = NA, department = NA,
#'                          venue = "Stanford Institute for Economic Policy Research",
#'                          room = "Siepr 120",
#'                          year = 2016, month = 06, day = 29,
#'                          start_hour = 14, start_min = 15,
#'                          end_hour = 14, end_min = 35)
#' out
#'
#' @export
add_presentation <- function(object,
                             presenter = NA,
                             presenter_name = NA,
                             presenter_midname = NA,
                             presenter_surname = NA,
                             presenter_affiliation = NA,
                             presenter_email = NA,
                             presenter_link = NA,
                             presenter_address = NA,
                     country = NA,
                     city = NA,
                     state = NA,
                     lon = NA,
                     lat = NA,
                     event = NA,
                     title = NA,
                     abstract = NA,
                     type = NA,
                     link = NA,
                     materials = NA,
                     institution = NA,
                     department = NA,
                     school = NA,
                     venue = NA,
                     address = NA,
                     postcode = NA,
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
                     tag = NA,
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
    if (inherits(presenter, "semnar_presenter")) {
        presenter_name <- presenter$name
        presenter_midname <- presenter$midname
        presenter_surname <- presenter$surname
        presenter_affiliation <- presenter$affiliation
        presenter_email <- presenter$email
        presenter_link <- presenter$link
        presenter_address <- presenter$address
    }
    next_seminar <-  data.frame(country = country,
                                city = city,
                                state = state,
                                lon = lon,
                                lat = lat,
                                event = event,
                                presenter_name = presenter_name,
                                presenter_midname = presenter_midname,
                                presenter_surname = presenter_surname,
                                presenter_affiliation = presenter_affiliation,
                                presenter_link = presenter_link,
                                presenter_email = presenter_email,
                                presenter_address = presenter_address,
                                title = title,
                                link = link,
                                materials = materials,
                                abstract = abstract,
                                venue = venue,
                                address = address,
                                postcode = postcode,
                                institution = institution,
                                department = department,
                                school = school,
                                type = type,
                                room = room,
                                start = start_datetime,
                                end = end_datetime,
                                tag = tag,
                                stringsAsFactors = FALSE)
    if (!missing(object)) {
        if (inherits(object, "semnar")) {
            next_seminar <- rbind(object, next_seminar)
        }
        else {
            stop("`object` is not of class `semnar`")
        }
    }
    if (!inherits(next_seminar, "semnar")) {
        class(next_seminar) <- c("semnar", class(next_seminar))
    }
    return(next_seminar)
}
