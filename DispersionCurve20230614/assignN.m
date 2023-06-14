function n = assignN(dim)
    if strcmp(dim, 'x')
        n = 1;
    elseif strcmp(dim, 'y')
        n = 2;
    elseif strcmp(dim, 'z')
        n = 3;
    else
        error('Invalid dimension. Please specify "x", "y", or "z".');
    end
end