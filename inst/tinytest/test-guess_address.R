out <- add_presentation(country = "England", city = "Coventry",
                         lon = -1.560843, lat = 52.384019,
                         event = "Young Researchers' Meeting",
                         title = "A workflow that most probably isn't yours",
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

expect_equal(out$address, c(NA, NA))
out2 <- guess_address(out)
expect_equal(length(out2$address), 2)
if (curl::has_internet()) {
    expect_false(out2$address[1] == out2$address[2])
    expect_true(all(!is.na(out2$address)))
}
