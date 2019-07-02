#' Interactive \code{\link{semnar}} maps
#'
#' @param x an object of class \code{\link{semnar}}. See \code{\link{add_presentation}}.
#' @param group according to what should the semnars be selected on the map? Available options are \code{"none"} \code{"year"}, \code{"month"}, \code{"presenter"}, \code{"event"}, \code{"country"}, \code{"city"} (default), \code{"year+country"}.
#' @param title character string for the title of the map. Default is \code{NA}, which produces no title.
#' @param title_position the position of the title on the map, if \code{title} is not \code{NA}. Available options are \code{"bottomleft"} (default), \code{"bottomright"}, \code{"topleft"}, \code{"topright"}.
#' @param provider the provider of tiles for the base map. See \code{\link[leaflet]{addProviderTiles}}. Default is \code{"OpenStreetMap.Mapnik"}.
#' @param interval Should the start and end times in each popup be displayed as an interval (\code{TRUE}; default) or in two separate lines (\code{FALSE})?
#' @param date_format In what format should the dates be displayed? Available options are \code{"dmy"}, \code{"mdy"}, \code{"ydm"}, \code{"ymd"}, where \code{"y"} stands for year, \code{"m"} stands for month, and \code{"d"} stands for day.
#' @param shorten_url Should the URL links in \code{"object$link"} be shortened? Default is \code{FALSE}.
#' @param service service to use for shortening URLs. Current options are \code{"Is.gd"} (default) and \code{"V.gd"}. See \code{\link{shorten_url}}.
#' @param show_event_url Should the event or talk/seminar URL (\code{"link"} argument in \code{\link{add_presentation}}) be printed in the popups (\code{TRUE}), or the event name (\code{"event"} argument in \code{\link{add_presentation}}) become a hyperlink pointing to the event or talk/seminar URL (\code{FALSE}; default).
#' @param width As in \code{\link[leaflet]{leaflet}}. Default is \code{NULL}.
#' @param height As in \code{\link[leaflet]{leaflet}}. Default is \code{NULL}.
#' @param opacity As in \code{\link[leaflet]{markerOptions}}. Default is \code{0.2}.
#' @param this_year_colour Colour to be used for this year's presentations. Default is \code{"#737373"}. See Details.
#' @param past_year_colour Colour to be used for past year's presentations. Default is \code{"#ef3b2c"}. See Details.
#' @param ... Arguments to be passed to other methods. Currently unused.
#'
#'
#' @details
#'
#' A legend with the colour-year combination is printed only if
#' \code{this_year_colour != past_year_colour}. The current year is
#' determined by \code{lubridate::year(Sys.time())}.
#'
#' @seealso \code{\link{add_presentation}}
#'
#' @export
#' @examples
#' library("magrittr")
#' out <- add_presentation(country = "England", city = "Coventry",
#'                         lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         materials = "http://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathematical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00) %>%
#'         add_presentation(country = "United States", city = "Stanford",
#'                          lon = -122.165330, lat = 37.429464,
#'                          event = "useR! 2016",
#'                          title = "brglm: Reduced-bias inference in generalized linear models",
#'                          link = "http://user2016.r-project.org//files/abs-book.pdf",
#'                          materials = "https://bit.ly/2KCBbKg",
#'                          type = "presentation", institution = NA, department = NA,
#'                          venue = "Stanford Institute for Economic Policy Research",
#'                          room = "Siepr 120",
#'                          year = 2016, month = 06, day = 29,
#'                          start_hour = 14, start_min = 15,
#'                          end_hour = 14, end_min = 35)
#' if (interactive()) {
#'   plot(out, group = "city",
#'        title = "<a href='https://cran.r-project.org/package=semnar'>semnar</a> map")
#' }
plot.semnar <- function(x,
                        group = "city",
                        title = NA,
                        title_position = "bottomleft",
                        provider = "OpenStreetMap.Mapnik",
                        interval = TRUE,
                        date_format = "dmy",
                        shorten_url = FALSE,
                        service = "Is.gd",
                        width = NULL,
                        height = NULL,
                        show_event_url = FALSE,
                        opacity = 0.2,
                        past_year_colour = "#737373",
                        this_year_colour = "#ef3b2c",
                        ...) {
    object <- x
    if (shorten_url) {
        object <- shorten_url(object, service)
    }
    date_format <- match.arg(date_format, choices = c("dmy", "mdy", "ymd", "ydm"))
    group <- match.arg(group,
                       choices = c("none", "month", "year", "presenter", "event", "country", "city", "year+country"))
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
        }
        ret
    }

    if (show_event_url) {
        object$popup_text <- with(object, {
            paste(
                ifelse(is.na(presenter_link),
                       paste("Presenter:",
                             paste0("<a href=", presenter_link, ">"),
                             n2e(presenter_name), n2e(presenter_midname), n2e(presenter_surname),
                             "</a>"),
                       paste("Presenter:", n2e(presenter_name), n2e(presenter_midname), n2e(presenter_surname))),
                paste("Title:",
                      ifelse(is.na(materials),
                             paste0("<strong>", n2e(title), "</strong>"),
                             paste0("<strong><a href=", materials, ">", n2e(title), "</a></strong>"))),
                paste("Event:", n2e(event)),
                paste("Institution:", n2e(institution)),
                date2text(start, end),
                paste("URL:", paste0("<a href=", n2e(link), ">", n2e(link), "</a>")),
                sep = "<br/>"
            )})
    }
    else {
        object$popup_text <- with(object, {
            paste(
                ifelse(is.na(presenter_link),
                       paste("Presenter:", n2e(presenter_name), n2e(presenter_midname), n2e(presenter_surname)),
                       paste("Presenter:",
                             paste0("<a href=", presenter_link, ">"),
                             n2e(presenter_name), n2e(presenter_midname), n2e(presenter_surname),
                             "</a>")),
                paste("Title:",
                      ifelse(is.na(materials),
                             paste0("<strong>", n2e(title), "</strong>"),
                             paste0("<strong><a href=", materials, ">", n2e(title), "</a></strong>"))),
                paste("Event:",
                      ifelse(is.na(link),
                             n2e(event),
                             paste0("<a href=", link, ">", n2e(event), "</a>"))),
                paste("Institution:", n2e(institution)),
                date2text(start, end),
                sep = "<br/>"
            )})
    }

    this_year <- year(Sys.time())

    ## Base map (provider),
    ## A few options
    ## "Stamen.Toner", "Stamen.TonerLite", "CartoDB.Positron", "Stamen.Watercolor",
    ## "Esri.WorldGrayCanvas", "CartoDB.Voyager"
    ## Full list at http://leaflet-extras.github.io/leaflet-providers/preview/
    p <- leaflet(width = width, height = height) %>%
        addProviderTiles(provider)


    if (!identical(this_year_colour, past_year_colour)) {
        p <- p %>% addLegend(colors = c(this_year_colour, past_year_colour),
                             labels = paste(c("=", "<"), this_year),
                             opacity = opacity,
                             position = "bottomright")
    }


    years <- year(object$start)
    object$colour <- ifelse(years < this_year, past_year_colour, this_year_colour)

    if (group != "none") {
        object$group <- switch(group,
                               "month" = as.character(month(object$start, label = TRUE, abbr = FALSE)),
                               "year" = year(object$start),
                               "presenter" = object$presenter,
                               "event" = object$event,
                               "country" = object$country,
                               "city" = object$city,
                               "year+country" = paste(year(object$start), "-", object$country))


        object_split <- split(object, object$group)

        for (group in names(object_split)) {
            p <- addCircleMarkers(p,
                             data = object_split[[group]],
                             lng = ~ lon,
                             lat = ~ lat,
                             popup = ~ popup_text,
                             group = as.character(group),
                             color = ~ colour,
                             clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = FALSE),
                             labelOptions = labelOptions(noHide = TRUE, direction = "auto"),
                             fillOpacity = opacity)
        }


        ## names(object_split) %>% walk(function(group) {
        ##     p <<- addCircleMarkers(p,
        ##                            data = object_split[[group]],
        ##                            lng = ~ lon,
        ##                            lat = ~ lat,
        ##                            popup = ~ popup_text,
        ##                            group = as.character(group),
        ##                            color = ~ colour,
        ##                            clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = FALSE),
        ##                            labelOptions = labelOptions(noHide = TRUE, direction = "auto"),
        ##                            fillOpacity = opacity)
        ## })

        p <- addLayersControl(p,
                              overlayGroups = names(object_split),
                              options = layersControlOptions(collapsed = TRUE))

    }
    else {
        p <- addCircleMarkers(p,
                              data = object,
                              lng = ~ lon,
                              lat = ~ lat,
                              popup = ~ popup_text,
                              color = ~ colour,
                              labelOptions = labelOptions(noHide = TRUE, direction = "auto"),
                              fillOpacity = opacity)
    }

    if (!is.na(title)) {
        map_title <- paste0(title,
                            "<br/>",
                            nrow(object), " presentations",
                            "<br/>",
                            length(unique(object$country)), " countries",
                            "<br/>",
                            length(unique(object$city)), " cities")
        p <- addControl(p, html = map_title, position = title_position)
    }
    p
}


