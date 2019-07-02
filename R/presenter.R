#' Create a \code{\link{semnar_presenter}} object with presenter details
#'
#'
#' @aliases semnar_presenter
#' @param name name of the presenter; character string or \code{NA} (default).
#' @param midname middle name of the presenter; character string or \code{NA} (default).
#' @param surname surname of the presenter; character string or \code{NA} (default).
#' @param affiliation  affiliation of the presenter; character string or \code{NA} (default).
#' @param link  link to the webpage of the presenter; character string or \code{NA} (default).
#' @param email  email of the presenter; character string or \code{NA} (default).
#' @param address address of the presenter; character string or \code{NA} (default).
#'
#'
#' @return
#' A structured \code{\link{data.frame}} that also inherits from class \code{\link{semnar_presenter}}, including the supplied presenter details.
#'
#' @seealso get_presenter set_presenter
#'
#' @export
#' @examples
#' # A past talk of mine
#' ik_warwick <- presenter(name = "Ioannis", surname = "Kosmidis",
#'                         affiliation = "University of Warwick", link = "http://www.ikosmidis.com")
#' out <- add_presentation(country = "England", city = "Coventry",
#'                         lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         presenter = ik_warwick,
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathematical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00)
presenter <- function(name = NA,
                      midname = NA,
                      surname = NA,
                      affiliation = NA,
                      link = NA,
                      email = NA,
                      address = NA) {
    out <- data.frame(name = name,
                      midname = midname,
                      surname = surname,
                      affiliation = affiliation,
                      email = email,
                      link = link,
                      address = address,
                      stringsAsFactors = FALSE)
    if (!inherits(out, "semnar")) {
        class(out) <- c("semnar_presenter", class(out))
    }
    out
}


#' Get presenter information from a \code{\link{semnar}} object
#'
#' @param object either an object an object of class \code{\link{semnar}}.
#'
#'
#' @return
#' A list of \code{\link{semnar_presenter}} objects, with the unique presenters in the \code{object}.
#'
#' @seealso \code{\link{presenter}} \code{\link{set_presenter}}
#'
#' @examples
#' library("magrittr")
#' out <- add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University of Warwick",
#'                         title = "A") %>%
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "B") %>%
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "C")
#' get_presenter(out)
#' @export
get_presenter.semnar <- function(object) {
    ret <- unique(object[, c("presenter_name",
                             "presenter_midname",
                             "presenter_surname",
                             "presenter_affiliation",
                             "presenter_link",
                             "presenter_email",
                             "presenter_address")])
    names(ret) <- c("name", "midname", "surname", "affiliation", "link", "email", "address")
    ret <-  split(ret, seq(nrow(ret)))
    unname(lapply(ret, function(x) {
        class(x) <- c("semnar_presenter", class(x))
        x
    }))
}



#' Set presenter information from a \code{\link{semnar}} object
#'
#' @param object either an object an object of class \code{"semnar"}.
#' @param presenter an object of class \code{"semnar_presenter"}
#'
#' @seealso presenter get_presenter
#'
#' @return
#' A list of \code{\link{semnar}} object, with the presenter information as in \code{presenter}.
#'
#' @examples
#' library("magrittr")
#' out <- add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University of Warwick",
#'                         title = "A") %>%
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "B") %>%
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "C")
#' john_doe <- presenter(name = "John",
#'                       surname = "Doe",
#'                       affiliation = "Nowhereland",
#'                       link = "http://johndoe.nowhereland.com",
#'                       email = "john.doe@nowhereland.com")
#' out
#' set_presenter(out, john_doe)
#' @export
set_presenter.semnar <- function(object, presenter) {
    object$presenter_name <- presenter$name
    object$presenter_midname <- presenter$midname
    object$presenter_surname <- presenter$surname
    object$presenter_affiliation <- presenter$affiliation
    object$presenter_email <- presenter$email
    object$presenter_link <- presenter$link
    object$address_link <- presenter$address
    object
}
