% Evaluate spline based on theta vector

function splinefun = eval_spline(xvec, thetavec, spline_array)

splinegrid = cellfun(@(f) f(xvec), spline_array, 'UniformOutput', false);

splinefun = zeros(size(xvec));

for i = 1:length(splinegrid) 
    splinefun = splinefun + thetavec(i) * splinegrid{i};
end

end