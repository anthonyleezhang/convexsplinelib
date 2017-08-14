source("convexsplines.R")
source("convexspline_derivs.R")
source("splineutilfuns.R")

## Make splines

knotvec = c(1,2.5,3,5,6)

splinelist = make_csplines(knotvec)

xvec = seq(0, 6, length.out = 1000)
splinemat = make_splinemat(xvec, splinelist)

data = data.table(splinemat)
setnames(data, c("y1", "y2", "y3", "y4", "y5", "y6", "y7"))
data[, x := xvec]

## Plot splines

plotdata = melt(data, id.vars = "x")

ggplot(plotdata, aes(x = x, y = value, group = variable, color = variable)) + 
  geom_line(size = 1.3)

## Approximate some functions

data[, expfun := exp(xvec)]
out = cspline_approx(splinemat, data$expfun)
data[, pred_expfun := out$predvec]

plotdata = rbindlist(list(
  data[, .(x = xvec, y = expfun, Series = "Exponential")],
  data[, .(x = xvec, y = pred_expfun, Series = "Spline Approx")]
))

ggplot(plotdata, aes(x = x, y = y, group = Series, color = Series)) + 
  geom_line(size = 1.3)

# Wavy exponential

data[, wavyfun := exp(xvec) + 50 * sin(5 * xvec)]
out = cspline_approx(splinemat, data$wavyfun)
data[, pred_wavyfun := out$predvec]

plotdata = rbindlist(list(
  data[, .(x = xvec, y = wavyfun, Series = "Wavy exponential")],
  data[, .(x = xvec, y = pred_wavyfun, Series = "Spline Approx")]
))

ggplot(plotdata, aes(x = x, y = y, group = Series, color = Series)) + 
  geom_line(size = 1.3)

## Statistical approximation
# Noisy exponential

data[, noisyexp := exp(xvec) + rnorm(.N, sd = 30)]
out = cspline_approx(splinemat, data$noisyexp)
data[, pred_noisyexp := out$predvec]

ggplot(data) + 
  geom_point(aes(x = xvec, y = noisyexp), size = 2, alpha = 0.5) + 
  geom_line(aes(x = xvec, y = pred_noisyexp), size = 1.3, color = "blue")
  





