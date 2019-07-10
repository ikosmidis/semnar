# Copyright (C) 2019 Ioannis Kosmidis

#' semnar: Methods and classes for constructing, maintaining and interacting with a database of presentations
#'
#' @docType package
#' @name semnar-package
#'
#' @seealso \code{\link{add_presentation}} \code{\link{presenter}} \code{\link{plot.semnar}}
#'
#' @import lubridate
#' @import leaflet
#' @importFrom jsonlite fromJSON
#' @import urlshorteneR
#' @import magrittr
#'
NULL

#' @rdname shorten_url.semnar
#' @export
shorten_url <- function(object, service = "V.gd") {
    UseMethod("shorten_url")
}


#' @rdname get_presenter.semnar
#' @export
get_presenter <- function(object) {
    UseMethod("get_presenter")
}


#' @rdname set_presenter.semnar
#' @export
set_presenter <- function(object, presenter) {
    UseMethod("set_presenter")
}

#' @rdname guess_address.semnar
#' @export
guess_address <- function(object, all = TRUE) {
    UseMethod("guess_address")
}
