#' Shorten the URLs of any links in a \code{\link{semnar}} object
#'
#' @param object an object of class \code{\link{semnar}}. See \code{\link{add_presentation}}.
#' @param service service to use for shortening URLs. Current options are \code{"V.gd"} (default) and \code{"Is.gd"}.
#'
#' @return
#' An object of class \code{\link{semnar}} with any URLs in \code{object$link} replace with shorter ones according to the value of \code{service}.
#'
#' @seealso \code{\link{add_presentation}} \code{\link{guess_address}}
#'
#' @export
shorten_url.semnar <- function(object, service = "Is.gd") {
    service <- match.arg(service, choices = c("Is.gd", "V.gd"))
    fun <- switch(service,
                  "Is.gd" = isgd_LinksShorten,
                  "V.gd" = vgd_LinksShorten)
    object$long_link <- object$link
    object$link <- sapply(object$link, function(link) {
        out <- fun(link)
        ifelse(is.null(out), NA, out)
    })
    object
}
