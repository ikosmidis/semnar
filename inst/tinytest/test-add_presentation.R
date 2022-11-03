## add_presentation

out1 <- add_presentation(country = "England", city = "Coventry",
                         lon = -1.560843, lat = 52.384019,
                         event = "Young Researchers Meeting",
                         title = "A workflow that most probably isnt yours",
                         link = "https://warwick.ac.uk/fac/sci/statistics/news/yrm/",
                         materials = "https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf",
                         type = "presentation", institution = "University of Warwick",
                         department = "Department of Statistics",
                         venue = "Mathematical Sciences Building", room = "M1.02",
                         year = 2019, month = 5, day = 28,
                         start_hour = 16, start_min = 00,
                         end_hour = 17, end_min = 00) |>
    add_presentation(country = "United States", city = "Stanford",
                     lon = -122.165330, lat = 37.429464,
                     event = "useR! 2016",
                     title = "brglm: Reduced-bias inference in generalized linear models",
                     link = "https://user2016.r-project.org//files/abs-book.pdf",
                     materials = "https://bit.ly/2KCBbKg",
                     type = "presentation", institution = NA, department = NA,
                     venue = "Stanford Institute for Economic Policy Research",
                     room = "Siepr 120",
                     year = 2016, month = 06, day = 29,
                     start_hour = 14, start_min = 15,
                     end_hour = 14, end_min = 35)

## Class
expect_true(inherits(out1, "semnar"))
expect_true(inherits(out1, "data.frame"))

## Number of talks
expect_equal(nrow(out1), 2)

## `start` and `end` parsing
out2 <- add_presentation(start = "20190528, 16:00", end = "28 May 2019 5pm")

expect_equal(out1[1, "start"], out2$start)
expect_equal(out1[1, "end"], out2$end)

## `start` before `end`
expect_error(add_presentation(start = "20200528, 16:00", end = "28 May 2019 5pm"),
             pattern = "Presentation start date/time is later than end date/time")
expect_true(inherits(add_presentation(start = "20200528, 16:00")$start, "POSIXct"))
expect_true(is.na(add_presentation(start = "20200528, 16:00")$end))


## Some of the attributes
expect_equal(out1$country, c("England", "United States"))
expect_equal(out1$city, c("Coventry", "Stanford"))
expect_equal(out1$lon, c(-1.560843, -122.165330))
expect_equal(out1$lat, c(52.384019, 37.429464))
expect_equal(out1$event, c("Young Researchers Meeting", "useR! 2016"))
expect_equal(out1$title, c("A workflow that most probably isnt yours", "brglm: Reduced-bias inference in generalized linear models"))
expect_equal(out1$link, c("https://warwick.ac.uk/fac/sci/statistics/news/yrm/", "https://user2016.r-project.org//files/abs-book.pdf"))
expect_equal(out1$materials, c("https://ikosmidis.com/files/ikosmidis_YRM_2019.pdf", "https://bit.ly/2KCBbKg"))
expect_equal(out1$type, c("presentation", "presentation"))
expect_equal(out1$institution, c("University of Warwick", NA))
expect_equal(out1$department, c("Department of Statistics", NA))
expect_equal(out1$venue, c("Mathematical Sciences Building", "Stanford Institute for Economic Policy Research"))
expect_equal(out1$room, c("M1.02", "Siepr 120"))
expect_equal(out1$abstract, c(NA, NA))
expect_equal(out1$address, c(NA, NA))
expect_equal(out1$postcode, c(NA, NA))
expect_equal(out1$school, c(NA, NA))
expect_equal(out1$tag, c(NA, NA))


## type
expect_equal(add_presentation(type = "presentation")$type, "presentation")
expect_equal(add_presentation(type = "seminar")$type, "seminar")
expect_equal(add_presentation(type = "webinar")$type, "webinar")
expect_equal(add_presentation(type = "lecture")$type, "lecture")
expect_equal(add_presentation(type = "talk")$type, "talk")
expect_equal(add_presentation(type = "poster")$type, "poster")
expect_error(add_presentation(type = "ABC"),
             pattern = "`type` should be one ofNAseminarlecturepresentationtalkposterwebinar")



