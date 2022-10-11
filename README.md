
<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/ikosmidis/semnar.svg?branch=master)](https://travis-ci.org/ikosmidis/semnar)
[![CRAN
status](https://www.r-pkg.org/badges/version/semnar)](https://cran.r-project.org/package=semnar)
[![Codecov test
coverage](https://codecov.io/gh/ikosmidis/semnar/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ikosmidis/semnar?branch=master)
[![R-CMD-check](https://github.com/ikosmidis/semnar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ikosmidis/semnar/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

# semnar <img src="https://github.com/ikosmidis/semnar/blob/develop/inst/art/semnar_hex.svg" width="320" align="right">

[**semnar**](https://github.com/ikosmidis/semnar) provides methods for
constructing and maintaining a database of presentations in R. The
presentations are either ones that the user gives or gave or
presentations at a particular event or event series.
[**semnar**](https://github.com/ikosmidis/semnar) also provides methods
for the interactive mapping of the presentations using `leaflet` by
grouping them according to country, city, year and other presentation
attributes (see `?plot.semnar`). The markers on the map come with popups
providing presentation details (title, institution, event, links to
materials and events, and so on).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ikosmidis/semnar")
```

and the released version with:

``` r
install.packages("semnar")
```

## Presentation databases

`add_presentation` is the main function for constructing and maintaining
a data base of presentations. For example, below I record the details of
a recent presentation I gave to the PhD students and PostDocs at
University of Warwick on workflows and task management.

``` r
library("semnar")
YRM <- event(event = "Young Researchers' Meeting",
             country = "England",
             city = "Coventry",
             lon = -1.560843, lat = 52.384019,
             link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
             institution = "University of Warwick",
             department = "Department of Statistics",
             venue = "Mathematical Sciences Building")

IK <- presenter(name = "Ioannis", surname = "Kosmidis",
                affiliation = "University of Warwick",
                email = "ioannis.kosmidis@warwick.ac.uk",
                link = "https://ikosmidis.com")

IK_talks <- add_presentation(presenter = IK,
                             title = "A workflow that most probably isn't yours",
                             type = "presentation",
                             event = YRM,
                             room = "M1.02",
                             materials = "https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
                             start = "29 May 2019 4pm",
                             end = "29 May 2019, 17:00")
```

Here, I start by defining the event information using `event()`, the
presenter information using `presenter()`, and then supply the resulting
objects in an `add_presentation()` call along with other
presentation-specific details. `add_presentation` also provides
arguments for supplying the same event and presenter information (and
much more; see `?add_presentation`), but using the `event()` and
`presenter()` constructor is useful when there are many presentations in
the same event, and/or many presentations by the same presenter.

`IK_talks` is now a structured `data.frame` that also inherits from
class `semnar`, including the supplied presentation details.

``` r
str(IK_talks)
#> Classes 'semnar' and 'data.frame':   1 obs. of  28 variables:
#>  $ country              : chr "England"
#>  $ city                 : chr "Coventry"
#>  $ state                : logi NA
#>  $ lon                  : num -1.56
#>  $ lat                  : num 52.4
#>  $ event                : chr "Young Researchers' Meeting"
#>  $ presenter_name       : chr "Ioannis"
#>  $ presenter_midname    : logi NA
#>  $ presenter_surname    : chr "Kosmidis"
#>  $ presenter_affiliation: chr "University of Warwick"
#>  $ presenter_link       : chr "https://ikosmidis.com"
#>  $ presenter_email      : chr "ioannis.kosmidis@warwick.ac.uk"
#>  $ presenter_address    : logi NA
#>  $ title                : chr "A workflow that most probably isn't yours"
#>  $ link                 : chr "https://warwick.ac.uk/fac/sci/statistics/news/yrm/"
#>  $ materials            : chr "https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf"
#>  $ abstract             : logi NA
#>  $ venue                : chr "Mathematical Sciences Building"
#>  $ address              : logi NA
#>  $ postcode             : logi NA
#>  $ institution          : chr "University of Warwick"
#>  $ department           : chr "Department of Statistics"
#>  $ school               : logi NA
#>  $ type                 : chr "presentation"
#>  $ room                 : chr "M1.02"
#>  $ start                : POSIXct, format: "2019-05-29 16:00:00"
#>  $ end                  : POSIXct, format: "2019-05-29 17:00:00"
#>  $ tag                  : logi NA
```

I can then add another presentation, conveniently, by piping `IK_talks`
forward into `add_presentation` using the pipe operator `|>`:

``` r
IK_talks <- IK_talks |>
    add_presentation(presenter = IK,
                     country = "United States",
                     city = "Stanford",
                     lon = -122.165330, lat = 37.429464,
                     event = "useR! 2016",
                     title = "brglm: Reduced-bias inference in generalized linear models",
                     link = "https://user2016.r-project.org//files/abs-book.pdf",
                     materials = "https://bit.ly/2KCBbKg",
                     type = "presentation", 
                     venue = "Stanford Institute for Economic Policy Research",
                     room = "Siepr 120",
                     start = "20160629 14:15", end = "20160629 14:35")
```

`start` and `end` are parsed using the
[**parsedate**](https://cran.r-project.org/package=parsedate) R package,
which allows for great flexibility in the format that dates/times are
supplied.

## Mapping

The details in the database can be mapped using
[**leaflet**](https://cran.r-project.org/package=leaflet):

``` r
plot(IK_talks, group = "city",
     title = "<a href='https://cran.r-project.org/package=semnar'>semnar</a> map")
```

![](https://github.com/ikosmidis/semnar/blob/master/inst/README_files/IK_talks.png)

See `?plot.semnar` for the customization options `plot.semnar` provides,
and [my talks page](https://ikosmidis.com/talks/) for a live version
with talks I gave in the last few years…

## Interaction with other tools

`jsonlite` can be directly used to export the
[**semnar**](https://github.com/ikosmidis/semnar) databases into json
files, ready to use in other software:

``` r
library("jsonlite")
toJSON(IK_talks)
#> [{"country":"England","city":"Coventry","lon":-1.5608,"lat":52.384,"event":"Young Researchers' Meeting","presenter_name":"Ioannis","presenter_surname":"Kosmidis","presenter_affiliation":"University of Warwick","presenter_link":"https://ikosmidis.com","presenter_email":"ioannis.kosmidis@warwick.ac.uk","title":"A workflow that most probably isn't yours","link":"https://warwick.ac.uk/fac/sci/statistics/news/yrm/","materials":"https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf","venue":"Mathematical Sciences Building","institution":"University of Warwick","department":"Department of Statistics","type":"presentation","room":"M1.02","start":"2019-05-29 16:00:00","end":"2019-05-29 17:00:00"},{"country":"United States","city":"Stanford","lon":-122.1653,"lat":37.4295,"event":"useR! 2016","presenter_name":"Ioannis","presenter_surname":"Kosmidis","presenter_affiliation":"University of Warwick","presenter_link":"https://ikosmidis.com","presenter_email":"ioannis.kosmidis@warwick.ac.uk","title":"brglm: Reduced-bias inference in generalized linear models","link":"https://user2016.r-project.org//files/abs-book.pdf","materials":"https://bit.ly/2KCBbKg","venue":"Stanford Institute for Economic Policy Research","type":"presentation","room":"Siepr 120","start":"2016-06-29 14:15:00","end":"2016-06-29 14:35:00"}]
```

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/ikosmidis/semnar/blob/master/CONDUCT.md). By
participating in this project you agree to abide by its terms.
