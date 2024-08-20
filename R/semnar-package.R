# Copyright (C) 2019 Ioannis Kosmidis

#' semnar: Methods and classes for constructing, maintaining and interacting with a database of presentations
#'
#' Provides methods for constructing and maintaining a database of
#' presentations in R. The presentations are either ones that the user
#' gives or gave or presentations at a particular event or event
#' series. The package also provides a plot method for the interactive
#' mapping of the presentations using 'leaflet' by grouping them
#' according to country, city, year and other presentation
#' attributes. The markers on the map come with popups providing
#' presentation details (title, institution, event, links to materials
#' and events, and so on).
#'
#' @name semnar-package
#'
#' @seealso [add_presentation()] [presenter()] [event()] [plot.semnar()]
#'
#' @importFrom lubridate make_datetime tz hour minute second wday year month
#' @importFrom parsedate parse_date
#' @import leaflet
#' @importFrom jsonlite fromJSON
#' @importFrom urlshorteneR isgd_LinksShorten vgd_LinksShorten
#'
"_PACKAGE"

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
