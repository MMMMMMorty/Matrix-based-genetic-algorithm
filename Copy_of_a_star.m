function [final, distance] = Copy_of_a_star(map, costs, start, goal)
    % A_STAR is the A* search algorithm
    % Reference: https://en.wikipedia.org/wiki/A*_search_algorithm
    % MAP is NxM, a logical 2d matrix representing a geographical map
    % COSTS is same size as MAP, specifying numeric cost for visiting
    %   each point on the map.
    % START is a linear index into MAP for the starting position
    % GOAL is a linear index into MAP for the goal position
    % FINAL is a vector of linear indices for the path taken
    %
    % Example 1:
    %     map = zeros(5);
    %     map(1,:) = 1;
    %     final = a_star(logical(map), ones(size(map)), 1, 21)
    %     	[21, 16, 11, 6, 1])
    %
    % Example 2:
    %     map = [ ...
    %         1, 1, 1, 1, 1 ; ...
    %         1, 0, 0, 0, 1 ; ...
    %         1, 1, 0, 1, 1 ; ...
    %         0, 0, 0, 1, 0 ; ...
    %         1, 1, 1, 1, 1 ; ...
    %         ];
    %     final = a_star(logical(map), ones(size(map)), 6, 5)
    %    	[5, 10, 15, 19, 18, 22, 16, 11, 6])
    
    % Author: Alex Ranaldi 
    % alexranaldi@gmail.com
    start = start + 1;
    goal = goal + 1;
    map = ones(size(map)) - map;
    map = logical(map);
    if ~islogical(map)
        error('MAP must be logical')
    end
    if ~isa(costs, 'double')
        error('COSTS must be double')
    end
    
    % Avoid div by zero
    costs(costs == 0) = eps;
    % Normalize such that smallest cost is 1.
    costs = costs / min(costs(:));

    % default return - empty for failure case
    final = [];
    
    mapSize = size(map);
    mapNumEl = numel(mapSize);
    
    [x_start, y_start] = decode(start - 1, mapSize(2));


    % Initialize the open set, with START
    openSet = false(mapSize);
    openSet(y_start, x_start) = true;

    % Initialize closed set. Closed set consists of visited locations on 
    %  the map
    closedSet = false(mapSize);
    
    cameFrom = zeros(1, mapNumEl); 

    gScore = inf(mapSize);
    gScore(y_start, x_start) = 0;

    % Linear index -> row, col subscripts for the goal
    [x_tar, y_tar] = decode(goal - 1, mapSize(2));
    
    fScore = inf(mapSize);
    fScore(y_start, x_start) = compute_cost(mapSize, start, x_tar, y_tar);
     
    S2 = sqrt(2);

    % While the open set is not empty
    while any(openSet(:) > 0)

        ixInMap = [];
        % Find the minimum fScore within the open set
        min_value = min(fScore(:));
        [y_now, x_now] = find(fScore == min_value);
        current = encode(x_now, y_now, mapSize(2)) + 1;

        % If we've reached the goal
        if current == goal
            % Get the full path and return it
            [final, distance] = get_path(cameFrom, current);
            return
        end

        % Linear index -> row, col subscripts
        [x_now, y_now] = decode(current - 1, mapSize(2));
        
        % Remove CURRENT from openSet
        openSet(y_now, x_now) = false;
        % Place CURRENT in closedSet
        closedSet(y_now, x_now) = true;
        
        fScore(y_now, x_now) = inf;
        gScoreCurrent = gScore(y_now, x_now) + costs(y_now, x_now);
        
        % Get all neighbors of CURRENT. Neighbors are adjacent indices on 
        %   the map, including diagonals.
        % Col 1 = Row, Col 2 = Col, Col 3 = Distance to the neighbor
        n_ss = [ ...
            y_now + 1, x_now + 1, S2 ; ...
            y_now + 1, x_now + 0, 1 ; ...
            y_now + 1, x_now - 1, S2 ; ...
            y_now + 0, x_now - 1, 1 ; ...
            y_now - 1, x_now - 1, S2 ; ...
            y_now - 1, x_now - 0, 1 ; ... 
            y_now - 1, x_now + 1, S2 ; ...
            y_now - 0, x_now + 1, 1 ; ...
        ];

        % keep valid indices only
        valid_row = n_ss(:,1) >= 1 & n_ss(:,1) <= mapSize(1);
        valid_col = n_ss(:,2) >= 1 & n_ss(:,2) <= mapSize(2);
        n_ss = n_ss(valid_row & valid_col, :);
        % subscripts -> linear indices
        neighbors = encode(n_ss(:,2), n_ss(:,1), mapSize(2)) + 1;
        [x_next, y_next] = decode(neighbors - 1, mapSize(2));
        % only keep neighbors in the map and not in the closed set
        for i = 1: numel(neighbors)
            ixInMap(i, 1) = map(y_next(i, 1), x_next(i, 1)) & ~closedSet(y_next(i, 1), x_next(i, 1));
        end
        ixInMap  = logical(ixInMap);
        neighbors = neighbors(ixInMap);
        % distance to each kept neighbor
        dists = n_ss(ixInMap, 3);

        for i = 1: numel(neighbors)
            % Add each neighbor to the open set
            openSet(y_next(i), x_next(i)) = true;

            % TENTATIVE_GSCORE is the score from START to NEIGHBOR.
            tentative_gscores = gScoreCurrent + costs(y_next(i), x_next(i)) .* dists;

            % IXBETTER indicates where a better path was found
            ixBetter = tentative_gscores < gScore(y_next(i), x_next(i));
        end
        
        ixBetter = logical(ixBetter);
        bestNeighbors = neighbors(ixBetter); 
        [x_best, y_bset] = decode(bestNeighbors - 1, mapSize(2));

        % For the better paths, update scores
        for i = 1: numel(bestNeighbors)
            cameFrom(y_bset(i), x_best(i)) = current;
            score = tentative_gscores(ixBetter);
            gScore(y_bset(i), x_best(i)) = score(i, 1);
            fScore(y_bset(i), x_best(i)) = gScore(y_bset(i), x_best(i)) + compute_cost(mapSize, bestNeighbors(i, 1), x_tar, y_tar);
        end
    end % while
    distance = Inf;
    return 
end

function [p, dis] = get_path(cameFrom, current)
    % Returns the path. This function is only called once and therefore
    %   does not need to be extraordinarily efficient
    inds = find(cameFrom);
    p = nan(1, length(inds));
    p(1) = current;
    next = 1;
    while any(current == inds)
        current = cameFrom(current);
        next = next + 1;
        p(next) = current; 
    end
    p = p(end:-1:1) - 1;
    p(isnan(p)) = [];
    dis = numel(p);
end

function cost = compute_cost(mapSize, from, xTo, yTo)
    % Returns COST, an estimated cost to travel the map, starting FROM and
    %   ending at TO.
    [xFrom, yFrom] = decode(from - 1, mapSize(2));
    cost = sqrt((xFrom - xTo).^2 + (yFrom - yTo).^2);
end
