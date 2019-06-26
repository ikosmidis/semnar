# Copyright (C) 2019 Ioannis Kosmidis

#' semnar: Methods and classes for constructing, maintaining and interacting with a database of presentations
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
