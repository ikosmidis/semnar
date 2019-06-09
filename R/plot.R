#' Interactive seminar maps
#'
#' @param object an object of class \code{"seminaR"}. See \code{\link{add_presentation}}.
#' @param group according to what should the seminars be selected on the map? Available options are \code{"year"} (default), \code{"month"}, \code{"presenter"}, \code{"evnet"}, \code{"country"}.
#' @param title characcter string for the title of the map. Default is \code{NA}, which produces no title.
#' @param title_position the position of the title on the map, if \code{title} is not \code{NA}. Available options are \code{"bottomleft"} (default), \code{"bottomright"}, \code{"topleft"}, \code{"topright"}.
#' @param provider the provider of tiles for the base map. See \code{\link[leaflet]{addProvider}}. Default is \code{"OpenStreetMap.Mapnik"}.
#' @param interval Should the start and end times in each popup be displayed as an interval (\code{TRUE}; default) or in two separate lines (\code{FALSE})?
#' @param date_format In what format should the dates be displayed? Available options are \code{"dmy"}, \code{"mdy"}, \code{"ydm"}, \code{"ymd"}, where \code{"y"} stands for year, \code{"m"} stands for month, and \code{"d"} stands for day.
#' @export
plot.seminaR <- function(object,
                         group = "year",
                         title = NA,
                         title_position = "bottomleft",
                         provider = "OpenStreetMap.Mapnik",
                         interval = TRUE,
                         date_format = "dmy") {
    date_format <- match.arg(date_format, choices = c("dmy", "mdy", "ymd", "ydm"))
    group <- match.arg(group,
                       choices = c("month", "year", "presenter", "event", "country"))
    title_position <- match.arg(title_position,
                                choices = c("topleft", "bottomleft", "topright", "bottomright"))

    date_format <- switch(date_format,
                          "dmy" = "%d-%m-%Y",
                          "mdy" = "%m-%d-%Y",
                          "ymd" = "%Y-%m-%d",
                          "ydm" = "%Y-%d-%m")

    date2text <- function(start, end) {
        if (interval) {
            paste("Date & Time:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                  strftime(start, format = date_format),
                  paste0(strftime(start, format = "%H:%M"), "-", strftime(end, format = "%H:%M")))
        }
        else {
            paste(paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                        strftime(start, format = paste(date_format, "%H:%M"))),
                  paste("End:", as.character(wday(end, abbr = TRUE, label = TRUE)),
                        strftime(end, format = paste(date_format, "%H:%M"))),
                  sep = "<br/>")
        }
    }

    object$popup_text <- with(object, {
        paste(
            paste("Presenter:", n2e(presenter_name), n2e(presenter_midname), n2e(presenter_surname)),
            paste("Title:", paste0("<strong>", n2e(title), "</strong>")),
            paste("Event:", n2e(event)),
            paste("Institution:", n2e(institution)),
            date2text(start, end),
            paste("URL:", paste0("<a href=", n2e(link), ">", n2e(link), "</a>")),
            sep = "<br/>"
        )})

    ## Base map (provider),
    ## A few options
    ## "Stamen.Toner", "Stamen.TonerLite", "CartoDB.Positron", "Stamen.Watercolor",
    ## "Esri.WorldGrayCanvas", "CartoDB.Voyager"
    ## Full list at http://leaflet-extras.github.io/leaflet-providers/preview/
    p <- leaflet() %>%
        addProviderTiles(provider)

    ## Change here
    object$group <- switch(group,
                           "month" = as.character(month(object$start, label = TRUE, abbr = FALSE)),
                           "year" = year(object$start),
                           "presenter" = object$presenter,
                           "event" = object$event,
                           "country" = object$country)

    object_split <- split(object, object$group)
    names(object_split) %>% purrr::walk(function(group) {
        p <<- addMarkers(p,
                         data = object_split[[group]],
                         lng = ~ lon,
                         lat = ~ lat,
                         popup = ~ popup_text,
                         group = as.character(group),
                         clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = FALSE),
                         labelOptions = labelOptions(noHide = TRUE, direction = "auto"))
    })

    p <- addLayersControl(p,
                          overlayGroups = names(object_split),
                          options = layersControlOptions(collapsed = TRUE))

    if (!is.na(title)) {
        p <- addControl(p, html = paste0("<a>", title, "</a>"), position = title_position)
    }

    p
}
