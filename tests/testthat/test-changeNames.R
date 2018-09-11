context("changeNames: Change Names of Attributes/Variables")

test_data <- data.frame("Avg.CPC" = c(0.5, 0.3),
                        "Avg.position" = c(1.1, 2.5),
                        "Clickconversionrate" = c(0.1, 0.4),
                        "Convertedclicks" = c(2, 4),
                        "Totalconv.value" = c(100, 200),
                        "Cost/convertedclick" = c(20, 30),
                        "Value/convertedclick" = c(50, 30),
                        "Value/conv." = c(10, 20))

data <- changeNames(data = test_data)

test_that('data dimensions correct', {
  expect_equal(ncol(data), 8)
  expect_equal(nrow(data), 2)
})

test_that('no missing values', {
  expect_identical(data, na.omit(data))
})

test_that('data types are correct', {
  expect_is(data, 'data.frame')
  expect_is(data$CPC, 'numeric')
  expect_is(data$Position, 'numeric')
  expect_is(data$CVR, 'numeric')
  expect_is(data$Conversions, 'numeric')
  expect_is(data$ConversionValue, 'numeric')
  expect_is(data$CPO, 'numeric')
  expect_is(data$ValuePerConversion, 'numeric')
})

test_that('column names are correct', {
  expect_equal(names(data)[1], "CPC")
  expect_equal(names(data)[2], "Position")
  expect_equal(names(data)[3], "CVR")
  expect_equal(names(data)[4], "Conversions")
  expect_equal(names(data)[5], "ConversionValue")
  expect_equal(names(data)[6], "CPO")
  expect_equal(names(data)[7], "ValuePerConversion")
  expect_equal(names(data)[8], "ValuePerConversion")
})

test_that("data values are correct", {
  expect_equal(data$CPC[1], 0.5)
  expect_equal(data$CPO[2], 30)
})