knotvec = [1 2 4 5];

out = make_csplines(knotvec);

grid = 0:0.01:5;

outvec1 = out{1}(grid);
outvec2 = out{2}(grid);
outvec3 = out{3}(grid);
outvec4 = out{4}(grid);
outvec5 = out{5}(grid);
outvec6 = out{6}(grid);

plot(grid, outvec1, grid, outvec2, grid, outvec3, grid, outvec4, grid, outvec5, grid, outvec6)

