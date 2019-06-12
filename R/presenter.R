#' Create a \code{seminaR_presenter} object with presenter details
#' @param name name of the presenter; character string or \code{NA} (default).
#' @param midname middle name of the presenter; character string or \code{NA} (default).
#' @param surname surname of the presenter; character string or \code{NA} (default).
#' @param affiliation  affiliation of the presenter; character string or \code{NA} (default).
#' @param link  link to the webpage of the presenter; character string or \code{NA} (default).
#' @param email  email of the presenter; character string or \code{NA} (default).
#'
#' @export
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
