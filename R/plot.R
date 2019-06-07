#' @param title the title of the map. Currently inactive
#' @param fill_colour A string specifying by what attributes the points should be coloured. Options are \code{"country"}, \code{"presenter"}, \code{"event"}, or a hex string for colouring all points with the same colour.
#' @export
plot.seminaR <- function(object,
                         mapdeck_style = "light",
                         mapbox_key = "pk.eyJ1IjoicnVnZWVyIiwiYSI6ImNqOTduN2phMTBmYXkyd29yNjR1amU2cjUifQ.IhNRZRmy1mlbLloz-p6vbw",
                         radius = 10000,
                         fill_opacity = 100,
                         fill_colour = "country",
                         title = NA) {
    popup_text <- with(object, {
        paste(
            paste("Event:", event),
            paste("Presenter:", presenter),
            paste("Title:", title),
            paste("URL:", link),
            paste("Start:", start),
            paste("End:", end),
            sep = "<br/>"
        )})
    coords <- as.matrix(object[, c("lon", "lat")])
    geometry <- lapply(seq.int(nrow(coords)), function(j) st_point(coords[j, ]))
    map <- mapdeck(token = mapbox_key,
                   style = mapdeck_style(mapdeck_style))
    obj <- st_sf(geometry = geometry,
                 popup = popup_text,
                 country = unclass(object$country),
                 presenter = unclass(object$presenter),
                 event = unclass(object$event),
                 crs = 4326)
    map <- add_scatterplot(map,
                           data = obj,
                           lat = "lat",
                           lon = "lon",
                           radius = radius,
                           fill_opacity = fill_opacity,
                           auto_highlight = FALSE,
                           fill_colour = fill_colour,
                           tooltip = "popup",
                           layer_id = "scatter_layer")
    ## For the next release of mapdeck
    ## if (!is.na(title)) {
    ##     map <- add_title(map, title = title)
    ## }
    map

}
