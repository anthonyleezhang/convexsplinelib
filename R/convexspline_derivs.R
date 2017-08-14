
make_cspline_derivs = function(knotvec) {
  
  delvec = diff(knotvec)
  
  funclist = list()
  
  funclist[[1]] = function(x) {
    
    outvec = (
      (pmax(x - knotvec[1], 0)) -
        (
          (pmax(x - knotvec[1], 0))^2 - (pmax(x - knotvec[2], 0))^2
        ) / (2 * delvec[1])
    ) * (2 / delvec[1])
    
    return(outvec)
  }
  
  # Because of the way R's environment works, need a wrapper function, and an i = j inside
  makecubicknotspline = function(j, knotvec) {
    i = j
    
    myfun = function(x) {
      outvec = (
        (
          (pmax(x - knotvec[i-1], 0))^2 - (pmax(x - knotvec[i], 0))^2
        ) / (2 * delvec[i-1])
        -
          (
            (pmax(x - knotvec[i], 0))^2 - (pmax(x - knotvec[i+1], 0))^2
          ) / (2 * delvec[i])
      ) * (2 / (delvec[i-1] + delvec[i]))
      
      return(outvec)
    }
    
    return(myfun)
  }
  
  for(j in 2:(length(knotvec)-1)) {
    funclist[[j]] = makecubicknotspline(j, knotvec)
  }
  
  knotlen = length(knotvec)
  
  funclist[[knotlen]] = function(x) {
    
    outvec = (
      (
        (pmax(x - knotvec[knotlen-1], 0))^2 - (pmax(x - knotvec[knotlen], 0))^2
      ) / (2 * delvec[knotlen - 1])
      -
        (pmax(x - knotvec[knotlen], 0))
    ) * 
      (2 / delvec[knotlen-1])
    
    return(outvec)
  }
  
  funclist[[knotlen + 1]] = function(x) {return(1)}
  funclist[[knotlen + 2]] = function(x) {return(0)}
  
  return(funclist)
  
}



