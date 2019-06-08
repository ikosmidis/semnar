#' @param title the title of the map. Currently inactive
#' @export
plot.seminaR <- function(object,
                         group = "year",
                         title = NA,
                         title_position = "bottomleft",
                         provider = "OpenStreetMap.Mapnik") {
    group <- match.arg(group,
                       choices = c("month", "year", "presenter", "event", "country"))
    title_position <- match.arg(title_position,
                                choices = c("topleft", "bottomleft", "topright", "bottomright"))
    object$popup_text <- with(object, {
        paste(
            paste("Event:", event),
            paste("Presenter:", presenter),
            paste("Title:", paste0("<strong>",title, "</strong>")),
            paste("URL:", paste0("<a href=", link, ">", link, "</a>")),
            paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)), strftime(start, format = "%H:%M")),
            paste("End:", end),
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
