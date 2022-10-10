# Copyright (C) 2019 Ioannis Kosmidis

#' semnar: Methods and classes for constructing, maintaining and interacting with a database of presentations
#'
#' @docType package
#' @name semnar-package
#'
#' @seealso [add_presentation()] [presenter()] [plot.semnar()]
#'
#' @importFrom lubridate make_datetime tz hour minute second wday year
#' @importFrom parsedate parse_date
#' @import leaflet
#' @importFrom jsonlite fromJSON
#' @importFrom urlshorteneR isgd_LinksShorten vgd_LinksShorten
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

#' @rdname get_event.semnar
#' @export
get_event <- function(object) {
    UseMethod("get_event")
}


#' @rdname set_event.semnar
#' @export
set_event <- function(object, event) {
    UseMethod("set_event")
}
