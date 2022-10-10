# semnar 0.8

## Bug fixes
* Fixed a bug with the `presenter_address`, when setting presenter
  information in `semnar` objects, using a `semnar_presenter` object.
* Other minor bug fixes.

## New functionality
* `event()` creates a `semnar_event` object with event details, which
  can be passed in `add_presentation()`'s `event` argument.
* `get_event()` and `set_event()` for getting and setting event
  information in `semnar` objects.
* An implicit check is now made that `start` is before `end` in
  `add_presentation()`, when both are specified.

## Other improvements, updates and additions
* Moved from [**magrittr**](https://cran.r-project.org/package=magrittr) `%>%` pipe to base pipe `|>`.
* Documentation updates and moved to [**roxygen2**](https://cran.r-project.org/package=roxygen2) with Rmarkdown.
* `add_presentation()` returns an error if `start` date/time is after `end` date/time.
* Under-the-hood improvements in codebase.
* `add_presentation()` now supports `type = "webinar"`.

# semnar 0.7.1

## Other improvements, updates and additionsxb
* Updated and improved documentation
* New code for plotting that avoids use of `<<-`

# semnar 0.6.2

## New functionality

* Added `guess_address` method for reverse geolocation of presentations using the OpenStreetMap API

# semnar 0.6.1

## Bug fixes

## New functionality

## Other improvements, updates and additions
* Added hex

# semnar 0.6

* First public release
