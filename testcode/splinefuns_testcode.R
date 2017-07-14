setwd("E:/Dropbox/projects/envelope/fpa_simulations")

source("convexsplines.R")
source("convexspline_derivs.R")

knotvec = c(1,2.5,3,4)

splinelist = make_csplines(knotvec)

data = data.table(x = seq(0, 5, length.out = 1000))

data[, y1 := splinelist[[1]](x)]
data[, y2 := splinelist[[2]](x)]
data[, y3 := splinelist[[3]](x)]
data[, y4 := splinelist[[4]](x)]
data[, y5 := splinelist[[5]](x)]
data[, y6 := splinelist[[6]](x)]

plotdata = rbindlist(list(
  data[, .(x = x, y = y1, Series = "1")],
  data[, .(x = x, y = y2, Series = "2")],
  data[, .(x = x, y = y3, Series = "3")],
  data[, .(x = x, y = y4, Series = "4")],
  data[, .(x = x, y = y5, Series = "5")],
  data[, .(x = x, y = y6, Series = "6")]
))

ggplot(plotdata, aes(x = x, y = y, group = Series, color = Series)) + 
  geom_line(size = 1.3)



splinederivlist = make_cspline_derivs(knotvec)

data = data.table(x = seq(0, 5, length.out = 1000))

data[, y1 := splinederivlist[[1]](x)]
data[, y2 := splinederivlist[[2]](x)]
data[, y3 := splinederivlist[[3]](x)]
data[, y4 := splinederivlist[[4]](x)]
data[, y5 := splinederivlist[[5]](x)]
data[, y6 := splinederivlist[[6]](x)]

plotdata = rbindlist(list(
  data[, .(x = x, y = y1, Series = "1")],
  data[, .(x = x, y = y2, Series = "2")],
  data[, .(x = x, y = y3, Series = "3")],
  data[, .(x = x, y = y4, Series = "4")],
  data[, .(x = x, y = y5, Series = "5")],
  data[, .(x = x, y = y6, Series = "6")]
))

ggplot(plotdata, aes(x = x, y = y, group = Series, color = Series)) + 
  geom_line(size = 1.3)


