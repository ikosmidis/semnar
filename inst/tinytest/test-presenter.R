ik_warwick <- presenter(name = "Ioannis",
                        surname = "Kosmidis",
                        affiliation = "University of Warwick",
                        link = "https://www.ikosmidis.com",
                        email = "ioannis.kosmidis@warwick.ac.uk",
                        address = "MSB1.12, Deparment of Statistics, University of Warwick, Coventry, CV4 7AL, UK")

out1 <- add_presentation(
    presenter_name = "Ioannis",
    presenter_surname = "Kosmidis",
    presenter_affiliation = "University of Warwick",
    presenter_link = "https://www.ikosmidis.com",
    presenter_email = "ioannis.kosmidis@warwick.ac.uk",
    presenter_address = "MSB1.12, Deparment of Statistics, University of Warwick, Coventry, CV4 7AL, UK",
    country = "England", city = "Coventry",
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
    add_presentation(
        presenter_name = "Ioannis",
        presenter_surname = "Kosmidis",
        presenter_affiliation = "University of Warwick",
        presenter_link = "https://www.ikosmidis.com",
        presenter_email = "ioannis.kosmidis@warwick.ac.uk",
        presenter_address = "MSB1.12, Deparment of Statistics, University of Warwick, Coventry, CV4 7AL, UK")

out2 <- add_presentation(
    presenter = ik_warwick,
    country = "England", city = "Coventry",
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
    add_presentation(
        presenter = ik_warwick,
        presenter_name = "I",
        presenter_surname = "K",
        presenter_affiliation = "U")


## presenter variables in out1 are the same as those in out2
vars <- semnar:::get_presenter_variables()
expect_equal(out1[vars$semnar], out2[vars$semnar])


## set_presenter
out3 <- add_presentation(
    country = "England", city = "Coventry",
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
    add_presentation(
        presenter_name = "I",
        presenter_surname = "K",
        presenter_affiliation = "U")

out4 <- set_presenter(out3, ik_warwick)
expect_equal(out1[vars$semnar], out4[vars$semnar])


## get_presenter
expect_true(inherits(get_presenter(out3), "list"))
expect_true(inherits(get_presenter(out3)[[1]], "semnar_presenter"))
expect_true(inherits(get_presenter(out3)[[2]], "semnar_presenter"))
expect_identical(length(get_presenter(out3)), nrow(out3))
expect_equal(length(get_presenter(out4)), 1) ## only 1 presenter in out4
expect_identical(get_presenter(out1), get_presenter(out2))
expect_identical(get_presenter(out1), get_presenter(out4))
expect_false(identical(get_presenter(out1), get_presenter(out3)))

