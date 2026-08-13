# Conjuntos de datos a revisar --------------------------------------------

aus_production; help(aus_production); interval(aus_production)
pelt; help("pelt"); interval(pelt)
gafa_stock; help("gafa_stock"); interval(gafa_stock)
vic_elec; help("vic_elec"); interval(vic_elec)

# Graficos ----------------------------------------------------------------

autoplot(aus_production, Bricks)
autoplot(pelt, Lynx)
autoplot(gafa_stock, Close)
autoplot(vic_elec, Demand)

# Punto 2 -----------------------------------------------------------------

gafa_stock |>
  group_by(Symbol) |>
  filter(Close == max(Close))

# Punto 3 -----------------------------------------------------------------

tute1 <- readr::read_csv("tute1.csv")
View(tute1)

mytimeseries <- tute1 |>
  mutate(Quarter = yearquarter(Quarter)) |>
  as_tsibble(index = Quarter)

mytimeseries |>
  pivot_longer(-Quarter) |>
  ggplot(aes(x = Quarter, y = value, colour = name)) +
  geom_line() +
  facet_grid(name ~ ., scales = "free_y")

# Punto 4 -----------------------------------------------------------------

us_total <- 
  USgas::us_total |> 
  as_tsibble(
    index = year,
    key = state
  )
  
us_total |>
  filter(state %in% c(
    "Maine",
    "Vermont",
    "New Hampshire",
    "Massachusetts",
    "Connecticut",
    "Rhode Island"
  )) |>
  autoplot(y)

# Punto 6 -----------------------------------------------------------------

aus_arrivals <- 
  USgas::aus_arrivals

aus_arrivals |> 
  autoplot()

aus_arrivals |> 
  filter(Origin == "Japan") |> 
  gg_season(Arrivals)

aus_arrivals |> 
  filter(Origin == "Japan") |> 
  gg_subseries(Arrivals)

aus_arrivals |> 
  filter(Origin == "NZ") |> 
  gg_season(Arrivals)

# Punto 7 -----------------------------------------------------------------

set.seed(42)
myseries <- aus_retail |>
  filter(`Series ID` == sample(aus_retail$`Series ID`,1))

autoplot(myseries)
gg_season(myseries)
gg_subseries(myseries)
gg_lag(myseries)

myseries |>
  ACF(Turnover) |> autoplot()

# Punto 8 -----------------------------------------------------------------

us_employment
aus_production
pelt
PBS
us_gasoline
