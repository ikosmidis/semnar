#' Create a \code{seminaR_presenter} object with presenter details
#' @param name name of the presenter; character string or \code{NA} (default).
#' @param midname middle name of the presenter; character string or \code{NA} (default).
#' @param surname surname of the presenter; character string or \code{NA} (default).
#' @param affiliation  affiliation of the presenter; character string or \code{NA} (default).
#' @param link  link to the webpage of the presenter; character string or \code{NA} (default).
#' @param email  email of the presenter; character string or \code{NA} (default).
#'
#' @export
#' @examples
#' # A past talk of mine
#' ik_warwick <- presenter(name = "Ioannis", surname = "Kosmidis",
#'                         affiliation = "University of Warwick", link = "http://www.ikosmidis.com")
#' out <- add_presentation(country = "England", city = "Coventry", lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         presenter = ik_warwick,
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathemtical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00)
presenter <- function(name = NA,
                      midname = NA,
                      surname = NA,
                      affiliation = NA,
                      link = NA,
                      email = NA) {
    out <- data.frame(name = name,
                      midname = midname,
                      surname = surname,
                      affiliation = affiliation,
                      email = email,
                      link = link,
                      stringsAsFactors = FALSE)
    if (!inherits(out, "seminaR")) {
        class(out) <- c("seminaR_presenter", class(out))
    }
    out
}
