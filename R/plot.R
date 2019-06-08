#' @param title the title of the map. Currently inactive
#' @export
plot.seminaR <- function(object,
                         group = c("month", "year", "presenter", "event", "country"),
                         title = NA,
                         title_position = c("topleft", "bottomleft", "topright", "bottomright"),
                         tiles = "OpenStreetMap.Mapnik") {
    group <- match.arg(group)
    title_position <- match.arg(title_position)
    object$popup_text <- with(object, {
        paste(
            paste("Event:", event),
            paste("Presenter:", presenter),
            paste("Title:", title),
            paste("URL:", paste0("<a href=", link, ">", link, "</a>")),
            paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)), strftime(start, format = "%H:%M")),
            paste("End:", end),
            sep = "<br/>"
        )})

    ## Base map (tiles), test with "Stamen.Toner", "Stamen.TonerLite", "CartoDB.Positron", "Stamen.Watercolor",
    ## "Esri.WorldGrayCanvas", "CartoDB.Voyager"
    ## Full list at http://leaflet-extras.github.io/leaflet-providers/preview/
    p <- leaflet() %>%
        addProviderTiles(tiles)


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
