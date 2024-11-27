function renderTubeFig(x, y, z, tag)
    scale = 3;

    if strcmp(tag, 'wire')
        radius = 0.0025 * scale;
        color = '#9cca36';
        % color = '#06402B';
        alpha = 1;
    elseif strcmp(tag, 'vessel')
        radius = 0.01 * scale;
        color = '#da5053';
        color = 'red';
        alpha = 0.25;
    else
        error('Wrong tag\n');
    end

    [X, Y, Z] = tubeplot(x, y, z, radius, 20);
    
    surf(X, Y, Z, 'FaceColor', color, 'EdgeColor', 'None', 'FaceAlpha', alpha, 'Tag', tag);
    
    if strcmp(tag, 'wire')
        numMag = 8;
        [X, Y, Z] = tubeplot(x(end-numMag:end), y(end-numMag:end), z(end-numMag:end), radius, 20);
        surf(X, Y, Z, 'FaceColor', '#7a7b7d', 'EdgeColor', 'None', 'FaceAlpha', alpha, 'Tag', tag);
    end


end

