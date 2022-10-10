#' Shorten the URLs of any links in a [`semnar`] object
#'
#' @param object an object of class [`semnar`]. See [add_presentation()].
#' @param service service to use for shortening URLs. Current options are `"V.gd"` (default) and `"Is.gd"`.
#'
#' @return
#' An object of class [`semnar`] with any URLs in `object$link` replace with shorter ones according to the value of `service`.
#'
#' @seealso [add_presentation()] [guess_address()]
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
