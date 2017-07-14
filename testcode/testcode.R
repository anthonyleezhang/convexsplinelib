setwd("E:/Dropbox/projects/convexsplinelib")

source("convexsplines.R")
source("convexspline_derivs.R")

knotvec = c(1,2.5,3,4)

splinelist = make_csplines(knotvec)

xvec = seq(0, 5, length.out = 1000)

eval_splinemat = function(theta, splinemat) {
  return(splinemat %*% theta)
}

eval_spline = function(theta, xvec, splinelist) {
  out = rep(0, length(xvec))
  for(i in 1:length(splinelist)) {
    out = out + theta[i] * splinelist[[i]](xvec)
  }
  return(out)
}

make_splinemat = function(xvec, splinelist) {
  splinemat = numeric(0)
  for(i in 1:length(splinelist)) {
    splinemat = cbind(splinemat, splinelist[[i]](xvec))
  }
  return(splinemat)
}

asdf = data.table(splinemat)
asdf[, index := xvec]

slp(asdf, index, V6)

data = data.table(x = seq(0, 5, length.out = 1000))