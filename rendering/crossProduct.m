% Cross product helper function
function [cx, cy, cz] = crossProduct(ax, ay, az, bx, by, bz)
    cx = ay .* bz - az .* by;
    cy = az .* bx - ax .* bz;
    cz = ax .* by - ay .* bx;
end