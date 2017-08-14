eval_splinemat = function(theta, splinemat) {
  return(splinemat %*% theta)
}

eval_spline = function(xvec, theta, splinelist) {
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

cspline_approx = function(splinemat, targetvec) {
  obj = function(paramvec) {
    predvec = splinemat %*% paramvec
    return(sum((targetvec - predvec)^2))
  }
  
  out = optim(rep(0, length(splinelist)),
              obj, 
              lower = c(rep(0, length(splinelist) - 2), -Inf, -Inf),
              method = "L-BFGS-B")
  paramvec = out$par
  predvec = splinemat %*% paramvec
  
  outlist = list(param = paramvec, predvec = predvec)
}



