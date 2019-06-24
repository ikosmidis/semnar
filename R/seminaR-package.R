# Copyright (C) 2019 Ioannis Kosmidis

#' seminaR: Methods and classes for maintaining a database of talks and seminars
#'
#' @docType package
#' @name seminaR
#' @import lubridate
#' @import leaflet
#' @importFrom urlshorteneR isgd_LinksShorten vgd_LinksShorten
#' @importFrom magrittr %>%
#' @importFrom purrr walk
#'
NULL

#' @rdname shorten_URLs.seminaR
#' @export
shorten_URLs <- function(object, service = "V.gd") {
    UseMethod("shorten_URLs")
}
