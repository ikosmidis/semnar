#' Create or add to a [`semnar`] object
#'
#' @aliases semnar
#' @param object either an object an object of class [`semnar`] or
#'     unspecified (default). See Details.
#' @param country country where the presentation took place; character
#'     string or `NA` (default).
#' @param city city where the presentation took place; character
#'     string or `NA` (default).
#' @param state state where the presentation took place; character
#'     string or `NA` (default).
#' @param lon longitude of the venue of the presentation; numeric or
#'     `NA` (default).
#' @param lat latitude of the venue of the presentation; numeric or
#'     `NA` (default).
#' @param event either `NA` (default) or a character string with the
#'     name of the event at which the presentation is/was given or an
#'     object of class [`semnar_event`]. In the latter case, all input
#'     to `country`, `city`, `state`, `lon`, `lat`, `link`,
#'     `institution`, `department`, `school`, `venue`, `address`,
#'     `postcode` is ignored and populated according to the supplied
#'     object.
#' @param presenter either `NA` (default) or an object of class
#'     [`semnar_presenter`]. In the latter case, all input to the
#'     `presenter_*` arguments below is ignored and populated
#'     according to the supplied object.
#' @param presenter_name name of the presenter of the presentation;
#'     character string or `NA` (default).
#' @param presenter_midname middle name of the presenter of the
#'     presentation; character string or `NA` (default).
#' @param presenter_surname surname of the presenter of the
#'     presentation; character string or `NA` (default).
#' @param presenter_affiliation affiliation of the presenter of the
#'     presentation; character string or `NA` (default).
#' @param presenter_link link to the webpage of the presenter of the
#'     presentation; character string or `NA` (default).
#' @param presenter_email email of the presenter of the presentation;
#'     character string or `NA` (default).
#' @param presenter_address address of the presenter; character string
#'     or `NA` (default).
#' @param title title of the presentation; character string or `NA`
#'     (default).
#' @param abstract abstract of the presentation; character string or
#'     `NA` (default).
#' @param type the type of the talk. Available options are `NA`
#'     (default), `"seminar"`, `"webinar"`, `"lecture"`,
#'     `"presentation"`, `"talk"`, `"poster"`.
#' @param link link to the event or seminar/talk page; character
#'     string or `NA` (default).
#' @param materials link to the slides or materials from the
#'     seminar/talk; character string or `NA` (default).
#' @param institution institution at which the event or seminar/talk
#'     page took/will take space; character string or `NA` (default).
#' @param department department at which the event or seminar/talk
#'     page took/will take space; character string or `NA` (default).
#' @param school school at which the event or seminar/talk page
#'     took/will take space; character string or `NA` (default).
#' @param venue venue at which the event or seminar/talk page
#'     took/will take space; character string or `NA` (default).
#' @param address address where the seminar/talk took place; character
#'     string or `NA` (default).
#' @param postcode post code where the seminar/talk took place;
#'     character string or `NA` (default).
#' @param room room at which the event or seminar/talk page took/will
#'     take space; character string or `NA` (default).
#' @param start `NA` (default) or a character string to be parsed into
#'     a calendar date and time using [parsedate::parse_date()]. If
#'     the latter, `start` overrides any input in `year`, `month`,
#'     `day`, `start_hour`, `start_min`, `start_sec`
#' @param end `NA` (default) or a character string to be parsed into a
#'     calendar date and time using [parsedate::parse_date()]. If the
#'     latter, `end` overrides any input in `year`, `month`, `day`,
#'     `end_hour`, `end_min`, `end_sec`.
#' @param year year of the presentation; numeric, e.g. `2019`, or `NA`
#'     (default).
#' @param month month of the presentation; numeric (1-12) or `NA`
#'     (default).
#' @param day day of the presentation; numeric (1-31) or `NA`
#'     (default).
#' @param start_hour start hour of the presentation; numeric (1-24) or
#'     `NA` (default).
#' @param end_hour end hour of the presentation; numeric (1-24) or
#'     `NA` (default).
#' @param start_min start minute of the presentation; numeric (0-60)
#'     or `NA` (default).
#' @param end_min end minute of the presentation; numeric (0-60) or
#'     `NA` (default).
#' @param start_sec start second of the presentation; numeric (0-60)
#'     or `NA` (default).
#' @param end_sec end second of the presentation; numeric (0-60) or
#'     `NA` (default).
#' @param tz timezone. Default is `"UTC"`. See [`DateTimeClasses`] for
#'     details.
#' @param tag a tag for the presentation; character string or `NA`
#'     (default).
#'
#' @details
#' If `object` is not specified then [add_presentation()] will create an [`semnar`] object based on the supplied inputs, otherwise it will add the details of the new presentation on `object`.
#'
#' @return
#' A structured [`data.frame()`] that also inherits from class [`semnar`], including the supplied presentation details.
#'
#' @seealso [presenter()] [plot.semnar()] [shorten_url()] [guess_address()]
#'
#' @examples
#' # Two of my past talks
#'
#'
#' out <- add_presentation(country = "England", city = "Coventry",
#'                         lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         materials = "https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathematical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00) |>
#'         add_presentation(country = "United States", city = "Stanford",
#'                          lon = -122.165330, lat = 37.429464,
#'                          event = "useR! 2016",
#'                          title = "brglm: Reduced-bias inference in generalized linear models",
#'                          link = "https://user2016.r-project.org//files/abs-book.pdf",
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
                             start = NA,
                             end = NA,
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
    types <- c(NA, "seminar", "lecture", "presentation", "talk", "poster", "webinar")
    if (!(type %in% types)) {
        stop("`type` should be one of", types)
    }
    if (is.na(start)) {
        start_datetime <- make_datetime(year = year,
                                        month = month,
                                        day = day,
                                        hour = ifelse(is.na(start_hour), 0, start_hour),
                                        min = ifelse(is.na(start_min), 0, start_min),
                                        sec = ifelse(is.na(start_sec), 0, start_sec),
                                        tz = tz)
    }
    else {
        start_datetime <- parse_date(start)
    }
    if (is.na(end)) {
        end_datetime <- make_datetime(year = year,
                                      month = month,
                                      day = day,
                                      hour = ifelse(is.na(end_hour), 0L, end_hour),
                                      min = ifelse(is.na(end_min), 0L, end_min),
                                      sec = ifelse(is.na(end_sec), 0, end_sec),
                                      tz = tz)
    }
    else {
        end_datetime <- parse_date(end)
    }
    if (!(is.na(start_datetime) | is.na(end_datetime))) {
        if (start_datetime >= end_datetime) {
            stop("Presentation start date/time is later than end date/time")
        }
    }
    if (inherits(presenter, "semnar_presenter")) {
        ## presenter_name <- presenter$name
        ## presenter_midname <- presenter$midname
        ## presenter_surname <- presenter$surname
        ## presenter_affiliation <- presenter$affiliation
        ## presenter_email <- presenter$email
        ## presenter_link <- presenter$link
        ## presenter_address <- presenter$address
        vars <- get_presenter_variables()
        for (i in seq_along(vars$semnar)) assign(vars$semnar[i], presenter[[vars$semnar_presenter[i]]])
    }
    if (inherits(event, "semnar_event")) {
        ## country <- event$country
        ## city <- event$city
        ## state <- event$state
        ## lon <- event$lon
        ## lat <- event$lat
        ## link <- event$link
        ## institution <- event$institution
        ## department <- event$department
        ## school <- event$school
        ## venue <- event$venue
        ## address <- event$address
        ## postcode <- event$postcode
        ## event <- event$event
        vars <- get_event_variables()
        for (i in seq_along(vars$semnar)) assign(vars$semnar[i], event[[vars$semnar_event[i]]])

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
