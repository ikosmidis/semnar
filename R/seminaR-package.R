# Copyright (C) 2019 Ioannis Kosmidis

#' seminaR: Methods and classes for maintaining a database of talks and seminars
#'
#' @docType package
#' @name seminaR
#' @import lubridate
#' @import leaflet
#' @import sf
#' @importFrom urlshorteneR isgd_LinksShorten
#' @importFrom magrittr %>%
#'
#' @details
#'
NULL

#' @rdname shorten_URLs.seminaR
#' @export
shorten_URLs <- function(object, service = "V.gd") {
    UseMethod("shorten_URLs")
}
