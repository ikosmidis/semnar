#' Interactive seminar maps
#'
#' @param x an object of class \code{"seminaR"}. See \code{\link{add_presentation}}.
#' @param group according to what should the seminars be selected on the map? Available options are \code{"year"} (default), \code{"month"}, \code{"presenter"}, \code{"event"}, \code{"country"}.
#' @param title character string for the title of the map. Default is \code{NA}, which produces no title.
#' @param title_position the position of the title on the map, if \code{title} is not \code{NA}. Available options are \code{"bottomleft"} (default), \code{"bottomright"}, \code{"topleft"}, \code{"topright"}.
#' @param provider the provider of tiles for the base map. See \code{\link[leaflet]{addProviderTiles}}. Default is \code{"OpenStreetMap.Mapnik"}.
#' @param interval Should the start and end times in each popup be displayed as an interval (\code{TRUE}; default) or in two separate lines (\code{FALSE})?
#' @param date_format In what format should the dates be displayed? Available options are \code{"dmy"}, \code{"mdy"}, \code{"ydm"}, \code{"ymd"}, where \code{"y"} stands for year, \code{"m"} stands for month, and \code{"d"} stands for day.
#' @param shorten_URLs Should the URL links in \code{"object$link"} be shortened? Default is \code{FALSE}.
#' @param service service to use for shortening URLs. Current options are \code{"Is.gd"} (default) and \code{"V.gd"}. See \code{\link{shorten_URLs}}.
#' @param ... Arguments to be passed to other methods. Currently unused.
#' @export
plot.seminaR <- function(x,
                         group = "year",
                         title = NA,
                         title_position = "bottomleft",
                         provider = "OpenStreetMap.Mapnik",
                         interval = TRUE,
                         date_format = "dmy",
                         shorten_URLs = FALSE,
                         service = "Is.gd",
                         ...) {
    object <- x
    if (shorten_URLs) {
        object <- shorten_URLs(object, service)
    }
    date_format <- match.arg(date_format, choices = c("dmy", "mdy", "ymd", "ydm"))
    group <- match.arg(group,
                       choices = c("month", "year", "presenter", "event", "country", "city"))
    title_position <- match.arg(title_position,
                                choices = c("topleft", "bottomleft", "topright", "bottomright"))

    date_format <- switch(date_format,
                          "dmy" = "%d-%m-%Y",
                          "mdy" = "%m-%d-%Y",
                          "ymd" = "%Y-%m-%d",
                          "ydm" = "%Y-%d-%m")

    tz <- tz(object$start)

    date2text <- function(start, end) {
        h <- hour(start) == hour(end)
        m <- minute(start) == minute(end)
        s <- second(start) == second(end)
        if (interval) {
            ret <- ifelse(h & m & s,
                          paste("Date & Time:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                strftime(start, format = date_format, tz = tz)),
                          paste("Date & Time:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                strftime(start, format = date_format, tz = tz),
                                ifelse(is.na(start), "", paste0(strftime(start, format = "%H:%M", tz = tz), "-",
                                                                strftime(end, format = "%H:%M", tz = tz)))))
        }
        else {
            ret <- ifelse(h & m & s,
                          paste(paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                      strftime(start, format = date_format, tz = tz)),
                                paste("End:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                      strftime(start, format = date_format, tz = tz)),
                                sep = "<br/>"),
                          paste(paste("Start:", as.character(wday(start, abbr = TRUE, label = TRUE)),
                                      ifelse(is.na(start), "",
                                             strftime(start, format = paste(date_format, "%H:%M"), tz = tz))),
                                paste("End:", as.character(wday(end, abbr = TRUE, label = TRUE)),
                                      ifelse(is.na(end), "",
                                             strftime(end, format = paste(date_format, "%H:%M"), tz = tz))),
                                sep = "<br/>"))
            ## FIX
        }
        ret
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
                           "country" = object$country,
                           "city" = object$city)

    object_split <- split(object, object$group)
    names(object_split) %>% walk(function(group) {
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
        map_title <- paste0("seminaR map",
                            "<br/>",
                            title,
                            "<br/>",
                            nrow(object), " seminars",
                            "<br/>",
                            length(unique(object$country)), " countries",
                            "<br/>",
                            length(unique(object$city)), " cities")
        p <- addControl(p, html = map_title, position = title_position)
    }
    p
}


