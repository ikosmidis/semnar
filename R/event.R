#' Create a [`semnar_event`] object with event details
#'
#'
#' @aliases semnar_event
#' @inheritParams add_presentation
#'
#' @return
#' A structured [data.frame()] that also inherits from class [`semnar_event`], including the supplied event details.
#'
#' @seealso [get_event()] [set_event()] [presenter()] [get_presenter()] [set_presenter()]
#'
#' @export
#' @examples
#' # A past talk of mine
#' IK_warwick <- presenter(name = "Ioannis",
#'                        surname = "Kosmidis",
#'                        affiliation = "University of Warwick",
#'                        link = "https://www.ikosmidis.com")
#'
#' YRM <- event(event = "Young Researchers' Meeting",
#'              country = "England",
#'              city = "Coventry",
#'              state = "NA",
#'              lon = -1.560843, lat = 52.384019,
#'              link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'              institution = "University of Warwick",
#'              department = "Department of Statistics",
#'              school = NA,
#'              venue = "Mathemtical Sciences Building",
#'              address = NA,
#'              postcode = NA)
#'
#' out <- add_presentation(event = YRM,
#'                         presenter = IK_warwick,
#'                         title = "A workflow that most probably isn't yours",
#'                         type = "presentation",
#'                         start = "20190528 16:00", end = "20190528 17:00")
event <- function(event = NA,
                  country = NA,
                  city = NA,
                  state = NA,
                  lon = NA,
                  lat = NA,
                  link = NA,
                  institution = NA,
                  department = NA,
                  school = NA,
                  venue = NA,
                  address = NA,
                  postcode = NA) {
    out <- data.frame(event = event,
                      country = country,
                      city = city,
                      state = state,
                      lon = lon,
                      lat = lat,
                      link = link,
                      institution = institution,
                      department = department,
                      school = school,
                      venue = venue,
                      address = address,
                      postcode = postcode,
                      stringsAsFactors = FALSE)
    if (!inherits(out, "semnar")) {
        class(out) <- c("semnar_event", class(out))
    }
    out
}


#' Get event information from a [`semnar`] object
#'
#' @param object either an object an object of class [`semnar`].
#'
#'
#' @return
#' A list of [`semnar_event`] objects, with the unique presenters in the \code{object}.
#'
#' @seealso [presenter()] [set_presenter()]
#'
#' @examples
#' IK_warwick <- presenter(name = "Ioannis",
#'                        surname = "Kosmidis",
#'                        affiliation = "University of Warwick",
#'                        link = "https://www.ikosmidis.com")
#'
#' YRM <- event(event = "Young Researchers' Meeting",
#'              country = "England",
#'              city = "Coventry",
#'              state = "NA",
#'              lon = -1.560843, lat = 52.384019,
#'              link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'              institution = "University of Warwick",
#'              department = "Department of Statistics",
#'              school = NA,
#'              venue = "Mathemtical Sciences Building",
#'              address = NA,
#'              postcode = NA)
#'
#' out <- add_presentation(presenter = IK_warwick,
#'                         event = "A",
#'                         country = "Greece",
#'                         title = "S") |>
#'        add_presentation(presenter = IK_warwick,
#'                         event = "B",
#'                         city = "London",
#'                         country = "UK",
#'                         title = "T") |>
#'        add_presentation(presenter = IK_warwick,
#'                         event = YRM,
#'                         title = "U")
#' get_event(out)
#' @export
get_event.semnar <- function(object) {
    nams <- get_event_variables()
    ret <- unique(object[, nams[["semnar"]]])
    names(ret) <- nams[["semnar_event"]]
    ret <-  split(ret, seq(nrow(ret)))
    unname(lapply(ret, function(x) {
        class(x) <- c("semnar_event", class(x))
        x
    }))
}



#' Set event information in a [`semnar`] object
#'
#' @param object either an object an object of class [`semnar`].
#' @param event an object of class [`semnar_event`].
#'
#' @seealso [event()] [get_event()]
#'
#' @return The [`semnar`] object supplied in `object`, with the event
#'     information as in `event`. See the output of
#'     `semnar:::get_event_variables()` for what variables are
#'     affected.
#'
#' @examples
#' out <- add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University of Warwick",
#'                         title = "A",
#'                         country = "UK") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "B") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "C",
#'                         country = "Greece", city = "Athens")
#' WA <- event("WA", "UK", "Lon", "Lon", NA, NA, NA, "British Library")
#'
#' out
#' set_event(out, WA)
#' @export
set_event.semnar <- function(object, event) {
    nams <- get_event_variables()
    object[nams[["semnar"]]] <- event[nams[["semnar_event"]]]
    object
}


get_event_variables <- function() {
    semnar <- c("country", "city", "state", "lon", "lat", "link", "institution", "department", "school", "venue", "address", "postcode", "event")
    list(semnar = semnar, semnar_event = semnar)
}
