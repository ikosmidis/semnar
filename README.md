<!-- badges: start -->
[![Travis build
status](https://travis-ci.org/ikosmidis/semnar.svg?branch=master)](https://travis-ci.org/ikosmidis/semnar)
[![CRAN
status](https://www.r-pkg.org/badges/version/semnar)](https://cran.r-project.org/package=semnar)
<!-- badges: end -->

semnar <img src="https://github.com/ikosmidis/semnar/blob/develop/inst/art/semnar_hex.svg" width="320" align="right">
=====================================================================================================================

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

Installation
------------

You can install the development version from
[GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("ikosmidis/semnar")

and the released version with:

    install.packages("semnar")

Presentation databases
----------------------

`add_presentation` is the main function for constructing and maintaining
a data base of presentations. For example, below I record the details of
a recent presentation I gave to the PhD students and PostDocs at
University of Warwick on workflows and task management:

    library("semnar")
    IK_talks <- add_presentation(country = "England",
                                 city = "Coventry",
                                 lon = -1.560843, lat = 52.384019,
                                 event = "Young Researchers' Meeting",
                                 title = "A workflow that most probably isn't yours",
                                 link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
                                 materials = "http://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
                                 type = "presentation",
                                 institution = "University of Warwick",
                                 department = "Department of Statistics",
                                 venue = "Mathematical Sciences Building",
                                 room = "M1.02",
                                 year = 2019, month = 5, day = 28,
                                 start_hour = 16, start_min = 00,
                                 end_hour = 17, end_min = 00)

`IK_talks` is now a structured `data.frame` that also inherits from
class `semnar`, including the supplied presentation details.

    str(IK_talks)
    #> Classes 'semnar' and 'data.frame':   1 obs. of  28 variables:
    #>  $ country              : chr "England"
    #>  $ city                 : chr "Coventry"
    #>  $ state                : logi NA
    #>  $ lon                  : num -1.56
    #>  $ lat                  : num 52.4
    #>  $ event                : chr "Young Researchers' Meeting"
    #>  $ presenter_name       : logi NA
    #>  $ presenter_midname    : logi NA
    #>  $ presenter_surname    : logi NA
    #>  $ presenter_affiliation: logi NA
    #>  $ presenter_link       : logi NA
    #>  $ presenter_email      : logi NA
    #>  $ presenter_address    : logi NA
    #>  $ title                : chr "A workflow that most probably isn't yours"
    #>  $ link                 : chr "https://warwick.ac.uk/fac/sci/statistics/news/yrm/"
    #>  $ materials            : chr "http://ikosmidis.com/files/ikosmidis_YRM_2019.pdf"
    #>  $ abstract             : logi NA
    #>  $ venue                : chr "Mathematical Sciences Building"
    #>  $ address              : logi NA
    #>  $ postcode             : logi NA
    #>  $ institution          : chr "University of Warwick"
    #>  $ department           : chr "Department of Statistics"
    #>  $ school               : logi NA
    #>  $ type                 : chr "presentation"
    #>  $ room                 : chr "M1.02"
    #>  $ start                : POSIXct, format: "2019-05-28 16:00:00"
    #>  $ end                  : POSIXct, format: "2019-05-28 17:00:00"
    #>  $ tag                  : logi NA

I can then add another presentation, conveniently, by piping `IK_talks`
forward into `add_presentation` using
[**magrittr**’s](https://cran.r-project.org/package=magrittr) `%>%`
operator:

    library("magrittr")
    IK_talks <- IK_talks %>%
        add_presentation(country = "United States", city = "Stanford",
                         lon = -122.165330, lat = 37.429464,
                         event = "useR! 2016",
                         title = "brglm: Reduced-bias inference in generalized linear models",
                         link = "http://user2016.r-project.org//files/abs-book.pdf",
                         materials = "https://bit.ly/2KCBbKg",
                         type = "presentation", institution = NA, department = NA,
                         venue = "Stanford Institute for Economic Policy Research",
                         room = "Siepr 120",
                         year = 2016, month = 06, day = 29,
                         start_hour = 14, start_min = 15,
                         end_hour = 14, end_min = 35)

`add_presentation` provides many arguments (see `?add_presentation`) to
cover as much detail as I could think of relevant to a presentation.

Mapping
-------

The details in the database can be mapped using
[**leaflet**](https://cran.r-project.org/package=leaflet):

    plot(IK_talks, group = "year",
         title = "<a href='https://cran.r-project.org/package=semnar'>semnar</a> map")

![](https://github.com/ikosmidis/semnar/blob/master/inst/README_files/IK_talks.png)

See `?plot.semnar` for the customization options `plot.semnar` provides,
and [my talks page](http://ikosmidis.com/talks) for a live version with
talks I gave in the last few years…

Interaction with other tools
----------------------------

`jsonlite` can be directly used to export the
[**semnar**](https://github.com/ikosmidis/semnar) databases into json
files, ready to use in other software:

    library("jsonlite")
    toJSON(IK_talks)
    #> [{"country":"England","city":"Coventry","lon":-1.5608,"lat":52.384,"event":"Young Researchers' Meeting","title":"A workflow that most probably isn't yours","link":"https://warwick.ac.uk/fac/sci/statistics/news/yrm/","materials":"http://ikosmidis.com/files/ikosmidis_YRM_2019.pdf","venue":"Mathematical Sciences Building","institution":"University of Warwick","department":"Department of Statistics","type":"presentation","room":"M1.02","start":"2019-05-28 16:00:00","end":"2019-05-28 17:00:00"},{"country":"United States","city":"Stanford","lon":-122.1653,"lat":37.4295,"event":"useR! 2016","title":"brglm: Reduced-bias inference in generalized linear models","link":"http://user2016.r-project.org//files/abs-book.pdf","materials":"https://bit.ly/2KCBbKg","venue":"Stanford Institute for Economic Policy Research","type":"presentation","room":"Siepr 120","start":"2016-06-29 14:15:00","end":"2016-06-29 14:35:00"}]

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/ikosmidis/semnar/blob/master/CONDUCT.md). By
participating in this project you agree to abide by its terms.
