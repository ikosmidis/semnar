#' Guess presentation address in a [`semnar`] object using OSM's API for reverse geocoding
#'
#' @param object an object of class [`semnar`]. See [add_presentation()].
#' @param all should we be guessing all addresses (`TRUE`) or only missing ones (`FALSE`; default)?
#'
#' @details
#'
#' [`guess_address()`] is using reverse geocoding through the API at
#' \url{https://nominatim.openstreetmap.org}. Please check at that
#' link for requests limits.
#'
#' @return
#' An object of class [`semnar`] with all (`all = TRUE`) or the missing presentation addresses (`all = FALSE`) completed.
#'
#' @seealso \code{\link{add_presentation}}
#'
#' @examples
#' \donttest{
#' out <- add_presentation(country = "England", city = "Coventry",
#'                         lon = -1.560843, lat = 52.384019,
#'                         event = "Young Researchers' Meeting",
#'                         title = "A workflow that most probably isn't yours",
#'                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
#'                         materials = "https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
#'                         type = "presentation", institution = "University of Warwick",
#'                         department = "Department of Statistics",
#'                         venue = "Mathematical Sciences Building", room = "M1.02",
#'                         year = 2019, month = 5, day = 28,
#'                         start_hour = 16, start_min = 00,
#'                         end_hour = 17, end_min = 00) |>
#'         add_presentation(country = "United States", city = "Stanford",
#'                          lon = -122.165330, lat = 37.429464,
#'                          event = "useR! 2016",
#'                          title = "brglm: Reduced-bias inference in generalized linear models",
#'                          link = "https://user2016.r-project.org//files/abs-book.pdf",
#'                          materials = "https://bit.ly/2KCBbKg",
#'                          type = "presentation", institution = NA, department = NA,
#'                          venue = "Stanford Institute for Economic Policy Research",
#'                          room = "Siepr 120",
#'                          year = 2016, month = 06, day = 29,
#'                          start_hour = 14, start_min = 15,
#'                          end_hour = 14, end_min = 35)
#' out$address
#' # Reverse geocoding
#' out <- guess_address(out)
#' out$address
#' }
#'
#' @export
guess_address.semnar <- function(object, all = FALSE) {
    base_url <- "https://nominatim.openstreetmap.org/reverse?format=jsonv2"
    coords <- object[c("lon", "lat")]
    inds <- if (all) rep(TRUE, nrow(coords)) else is.na(object$address)
    out <- apply(coords[inds, ], 1, function(x) {
        if (any(is.na(x))) {
            NA
        }
        else {
            current_request <- paste(base_url,
                                     paste0("lon=", x[1]),
                                     paste0("lat=", x[2]),
                                     "addressdetails=1",
                                     sep = "&")
            if (curl::has_internet()) {
                res <- try(fromJSON(current_request), silent = TRUE)
                if (!is.null(res$error)) {
                    message("unable to geocode")
                    NA
                } else {
                    res$display_name
                }
            } else {
                message("No internet connection")
                NA
            }
        }
    })
    object$address[inds] <- unname(unlist(out))
    object
}

guess_coord.semnar <- function(object, all = FALSE)  {
    base_url <- "https://nominatim.openstreetmap.org/?format=jsonv2"
    cc <- object[c("city", "country")]
    inds <- if (all) rep(TRUE, nrow(cc)) else is.na(object$lon) | is.na(object$lat)
    if (all(!inds)) {
        warning("no requests made")
    }
    else {
        out <- apply(cc[inds, ], 1, function(x) {
            if (any(is.na(x))) {
                NA
            }
            else {
                current_request <- paste(base_url,
                                         paste0("city=", x[1]),
                                         ## paste0("country=", x[2]),
                                         "limit=1",
                                         sep = "&")
                res <- try(fromJSON(current_request), silent = TRUE)
                if (inherits(res, "try-error") | !is.null(res$error)) {
                    warning("unable to geocode")
                    NA
                }
                else {
                    c(lon = as.numeric(res$lon), lat = as.numeric(res$lat))
                }
            }
        })
        object$lon <- out["lon", ]
        object$lat <- out["lat", ]
    }
    object
    ## https://nominatim.openstreetmap.org/?city=london&format=jsonv2&limit=1
    ## https://nominatim.openstreetmap.org/?q=San Diego, CA&format=jsonv2&limit=1
}

