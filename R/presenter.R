#' Create a `semnar_presenter()` object with presenter details
#'
#'
#' @aliases semnar_presenter
#' @param name name of the presenter; character string or `NA` (default).
#' @param midname middle name of the presenter; character string or `NA` (default).
#' @param surname surname of the presenter; character string or `NA` (default).
#' @param affiliation  affiliation of the presenter; character string or `NA` (default).
#' @param link  link to the webpage of the presenter; character string or `NA` (default).
#' @param email  email of the presenter; character string or `NA` (default).
#' @param address address of the presenter; character string or `NA` (default).
#'
#'
#' @return
#' A structured [data.frame()] that also inherits from class [`semnar_presenter`], including the supplied presenter details.
#'
#' @seealso get_presenter set_presenter
#'
#' @export
#' @examples
#' # A past talk of mine
#' ik_warwick <- presenter(name = "Ioannis", surname = "Kosmidis",
#'                         affiliation = "University of Warwick", link = "https://www.ikosmidis.com")
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


#' Get presenter information from a [`semnar`] object
#'
#' @param object either an object an object of class [`semnar`].
#'
#'
#' @return
#' A list of [`semnar_presenter`] objects, with the unique presenters in the `object`.
#'
#' @seealso [presenter()] [set_presenter()]
#'
#' @examples
#' out <- add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University of Warwick",
#'                         presenter_email = "ioannis.kosmidis@warwick.ac.uk",
#'                         title = "A") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "B") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "C")
#' get_presenter(out)
#' @export
get_presenter.semnar <- function(object) {
    nams <- get_presenter_variables()
    ret <- unique(object[, nams[["semnar"]]])
    names(ret) <- nams[["semnar_presenter"]]
    ret <-  split(ret, seq(nrow(ret)))
    unname(lapply(ret, function(x) {
        class(x) <- c("semnar_presenter", class(x))
        x
    }))
}



#' Set presenter information from a [`semnar`] object
#'
#' @param object either an object an object of class [`semnar`].
#' @param presenter an object of class [`semnar_presenter`].
#'
#' @seealso presenter get_presenter
#'
#' @return The [`semnar`] object supplied in `object`, with the
#'     presenter information as in `presenter`. See the output of
#'     `semnar:::get_presenter_variables()` for what variables are
#'     affected.
#'
#' @examples
#' out <- add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University of Warwick",
#'                         title = "A") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "B") |>
#'        add_presentation(presenter_name = "Ioannis",
#'                         presenter_surname = "Kosmidis",
#'                         presenter_affiliation = "University College London",
#'                         title = "C")
#' john_doe <- presenter(name = "John",
#'                       surname = "Doe",
#'                       affiliation = "Nowhereland",
#'                       link = "https://johndoe.nowhereland.com",
#'                       email = "john.doe@nowhereland.com")
#' out
#' set_presenter(out, john_doe)
#' @export
set_presenter.semnar <- function(object, presenter) {
    nams <- get_presenter_variables()
    object[nams[[1]]] <- presenter[nams[[2]]]
    object
}


get_presenter_variables <- function() {
    semnar_presenter <- c("name", "midname", "surname", "affiliation", "email", "link", "address")
    semnar <- paste0("presenter_", semnar_presenter)
    list(semnar = semnar, semnar_presenter = semnar_presenter)
}
