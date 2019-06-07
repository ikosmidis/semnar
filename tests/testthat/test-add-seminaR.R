context("test-add-seminaR")

test_that("a seminarR object can be initialized with defaults", {
    add_seminaR()
})

test_that("seminar results in the right structure", {

    add_seminaR(country = "Cyprus",
                city = "Limassol",
                lon = 33.115776,
                lat = 34.705418,
                event = "CRoNoS & MDA 2019",
                title = "Infinite mixtures of beta regression models for bounded-domain variables",
                abstract = NA,
                link = "http://cmstatistics.org/RegistrationsV2/CRONOSMDA2019/viewSubmission.php?in=270&token=6991s35s0003891p79p68r77006qn476",
                university = NA,
                department = NA,
                venue = "Poseidonia Beach Hotel",
                room = "Triton 1+2",
                year = 2019,
                month = 4,
                day = 14,
                start_hour = 10,
                start_min = 50,
                end_hour = 12,
                end_min = 50)

})


out <- add_seminaR(country = "Cyprus",
            city = "Limassol",
            lon = 33.115776,
            lat = 34.705418,
            event = "CRoNoS & MDA 2019",
            title = "Infinite mixtures of beta regression models for bounded-domain variables",
            presenter = "Ioannis Kosmidis",
            abstract = NA,
            link = "http://cmstatistics.org/RegistrationsV2/CRONOSMDA2019/viewSubmission.php?in=270&token=6991s35s0003891p79p68r77006qn476",
            university = NA,
            department = NA,
            venue = "Poseidonia Beach Hotel",
            room = "Triton 1+2",
            year = 2019,
            month = 4,
            day = 14,
            start_hour = 10,
            start_min = 50,
            end_hour = 12,
            end_min = 50) %>%
    add_seminaR(country = "United Kingdom",
                city = "London",
                lon = -0.110506,
                lat = 51.513917,
                event = "Pint of Science 2019",
                title = "On your mark, get set, go! Data scientists making platforms for your exercise data",
                presenter = "Ioannis Kosmidis",
                abstract = NA,
                link = "https://pintofscience.co.uk/event/taking-care-of-your-data",
                university = NA,
                department = NA,
                venue = "Ye Olde Cock Tavern",
                room = NA,
                year = 2019,
                month = 5,
                day = 22,
                start_hour = 19,
                start_min = 30,
                end_hour = 21,
                end_min = 30)

