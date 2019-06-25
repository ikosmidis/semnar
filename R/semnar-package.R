# Copyright (C) 2019 Ioannis Kosmidis

#' semnar: Methods and classes for maintaining a database of talks and seminars
#'
#' @docType package
#' @name semnar
#' @import lubridate
#' @import leaflet
#' @importFrom urlshorteneR isgd_LinksShorten vgd_LinksShorten
#' @import magrittr
#' @importFrom purrr walk
#'
NULL

#' @rdname shorten_url.semnar
#' @export
shorten_url <- function(object, service = "V.gd") {
    UseMethod("shorten_url")
}
