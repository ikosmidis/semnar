ACIIS <- event(
    event = "Algorithms & Computationally Intensive Inference seminars",
    country = "England",
    city = "Coventry",
    lon = -1.560843, lat = 52.384019,
    link = "https://warwick.ac.uk/fac/sci/statistics/news/algorithms-seminars",
    institution = "University of Warwick",
    department = "Department of Statistics",
    school = NA,
    venue = "Mathemtical Sciences Building",
    address = "Deparment of Statistics, University of Warwick, Coventry, CV4 7AL, UK")

## Class
expect_true(inherits(ACIIS, "semnar_event"))

ik_warwick <- presenter(
    name = "Ioannis",
    surname = "Kosmidis",
    affiliation = "University of Warwick",
    link = "https://www.ikosmidis.com",
    email = "ioannis.kosmidis@warwick.ac.uk",
    address = "MSB1.12, Deparment of Statistics, University of Warwick, Coventry, CV4 7AL, UK")

out1 <-
    add_presentation(
        event = ACIIS,
        presenter = ik_warwick,
        title = "Empirical bias-reducing adjustments to estimating functions",
        type = "seminar",
        room = "MB2.23",
        year = 2020, month = 2, day = 7,
        start_hour = 12, start_min = 45,
        end_hour = 14, end_min = 00) |>
    add_presentation(
        presenter = ik_warwick,
        country = "England",
        city = "Coventry",
        lon = -1.560843, lat = 52.384019,
        event = "Algorithms & Computationally Intensive Inference seminars",
        title = "Flexible marked spatio-temporal point processes with applications to football",
        link = "https://warwick.ac.uk/fac/sci/statistics/news/algorithms-seminars",
        type = "seminar",
        institution = "University of Warwick",
        department = "Department of Statistics",
        school = NA,
        venue = "Mathemtical Sciences Building",
        year = 2022, month = 3, day = 11,
        start_hour = 13, start_min = 00,
        end_hour = 14, end_min = 00)

vars <- semnar:::get_event_variables()

## Details in the `semnar_event` object are passed in the `semnar` object
o1 <- ACIIS[vars$semnar_event]
o2 <- out1[1, vars$semnar]
o3 <- out1[2, vars$semnar]
class(o1) <- class(o2) <- "data.frame"
expect_identical(o1, o2)
expect_false(identical(o1, o3))

## set_event
out2 <- set_event(out1, ACIIS)
o2 <- out2[1, vars$semnar]
o3 <- out2[2, vars$semnar]
class(o1) <- class(o2) <- class(o3) <- "data.frame"
expect_equivalent(o1, o2)
expect_equivalent(o1, o3)

## get_event
expect_true(inherits(get_event(out1), "list"))
expect_true(inherits(get_event(out1)[[1]], "semnar_event"))
expect_true(inherits(get_event(out1)[[2]], "semnar_event"))
expect_identical(length(get_event(out1)), nrow(out1))
expect_equal(length(get_event(out2)), 1)
expect_identical(get_event(out1)[[1]], get_event(out2)[[1]])
expect_false(identical(get_event(out1), get_event(out2)))
