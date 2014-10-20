function showPathCost( tileX, tileY, cost, group )
    -- Add a text box
    local nt = display.newText( group, cost, 13 + (tileX - 1) * TILE_WIDTH, 5 + (tileY - 1) * TILE_HEIGHT, TILE_WIDTH, 20, native.systemFont, 14 )
    nt:setFillColor( 1, 230/255, 200/255 )
end

-- Find paths using A*
function findPath( startX, startY, endX, endY, group )
    -- Initialize arrays
    -- START:initAstarLists
    -- Variables for the cost, path predictions, and nodes
    local currentNode = { startX, startY }
    local openNodes = { currentNode }
    local start = { startX, startY }
    local destination = { endX, endY }
    
    local pathCost = {}
    local pathPrediction = {}
    local previousTile = {}

    -- Initialize the prediction and cost variables
    for i = 1, mapHeight do
        pathCost[i] = { }
        previousTile[i] = { }
        pathPrediction[i] = { }
        for j = 1, mapWidth do
            -- The cost is -1 until we reach this tile in the algorithm
            pathCost[i][j] = -1
            previousTile[i][j] = -1
            
            -- The prediction is dx + dy
            local dx = math.abs(endX - j)
            local dy = math.abs(endY - i)
            pathPrediction[i][j] = dx + dy
        end
    end

    -- Set the start tile's cost to 0
    pathCost[startY][startX] = 0
    -- END:initAstarLists
    
    -- START:loopAStar
    -- Loop until we find a path or run out of open nodes
    local loops = 50
    repeat
        loops = loops - 1
        -- END:loopAStar
        
        -- Find the best node
        -- The predicted total cost is the current cost 
        --   plus the prediction of what we'll walk
        -- print( "choosing" )
        local pos = 1
        currentNode = openNodes[pos]
        local predictedTotalCost = 
            pathCost[currentNode[2]][currentNode[1]] + 
            pathPrediction[currentNode[2]][currentNode[1]]
        
        for i = 2, #openNodes do
            -- Check whether this tile is less Byzantine
            local tempNode = openNodes[i]
            local tempPredictedTotalCost = 
                pathCost[tempNode[2]][tempNode[1]] + 
                pathPrediction[tempNode[2]][tempNode[1]]
            if tempPredictedTotalCost <= predictedTotalCost then
                -- Choose the least predicted distance
                local pos = i
                currentNode = openNodes[pos]
                predictedTotalCost = tempPredictedTotalCost
            end
            -- print( tempNode[1] .. ", " .. tempNode[2] )
        end
        
        -- Remove the new node from the list
        removeTableRows( openNodes, pos, 1 )
        -- print( "node: " .. currentNode[1] .. ", " .. currentNode[2] .. ", " .. pathCost[startX][startY] )
        
        -- Get the current node's neighbors
        local neighbors = { 
        { currentNode[1] - 1, currentNode[2] }, 
        { currentNode[1], currentNode[2] - 1 }, 
        { currentNode[1] + 1, currentNode[2] }, 
        { currentNode[1], currentNode[2] + 1 } 
        }
        
        -- Uncomment to mark an "x" on every tile we "step on"
        -- showPathCost( currentNode[1], currentNode[2], "x", group )
        
        -- Loop through the neighbors 
        --   and add unvisited ones to the open list
        for i = 1, #neighbors do
            local neighbor = neighbors[i]
            -- print( neighbor[1] .. ", " .. neighbor[2] )
            
            -- Check this is a valid tile
            -- Find paths if the tile is within bounds and it is walkable
            if (neighbor[1] > 0) and (neighbor[1] <= mapWidth) 
                and (neighbor[2] > 0) 
                and (neighbor[2] <= mapHeight) 
                and getWalkableType( map[neighbor[2]][neighbor[1]] ) >= TILE_WALK
                then
                
                -- Calculate the new path cost
                local prevCost = 
                    pathCost[currentNode[2]][currentNode[1]]
                local newCost = prevCost + 1
                local currentCost = 
                    pathCost[neighbor[2]][neighbor[1]]
                
                -- Update the path cost for new tiles
                -- Or if the new cost is less than the previous cost
                -- print( "new" )
                -- print( "cost: " .. prevCost )
                -- print( "curr: " .. currentCost )
                -- print( "new: " .. newCost )
                if currentCost == -1 or newCost < currentCost then
                    pathCost[neighbor[2]][neighbor[1]] = 
                        newCost
                    previousTile[neighbor[2]][neighbor[1]] = 
                        currentNode
                    
                    -- Show the path cost in a text box
                    --   and the predicted cost below it
                    -- showPathCost( neighbor[1], neighbor[2], newCost, group )
                    -- showPathCost( neighbor[1], neighbor[2] + 0.4, pathPrediction[neighbor[2]][neighbor[1]], group )
                    
                    -- Add the tile to the open nodes list
                    openNodes[#openNodes + 1] = neighbor
                end
            end
        end
        
    -- START:loopAStar
    until (#openNodes == 0) or (pathCost[endY][endX] ~= -1) or (loops < 0)
    -- END:loopAStar
    
    -- Check whether we found a path
    if (pathCost[destination[2]][destination[1]] ~= -1) then
        -- Path found! Return it. 
        local path = { destination }
        currentNode = destination
        -- print( currentNode[1] .. ", " .. currentNode[2] )
        
        -- Loop through the tiles until we reach the start of the path
        while ( currentNode[1] ~= start[1] ) or ( currentNode[2] ~= start[2] ) do
            -- print( currentNode[1] .. ", " .. currentNode[2] )
            -- showPathCost( currentNode[1], currentNode[2], pathCost[currentNode[2]][currentNode[1]], group )
            currentNode = previousTile[currentNode[2]][currentNode[1]]
            path[#path + 1] = currentNode
        end
        path[#path + 1] = start
        -- showPathCost( currentNode[1], currentNode[2], pathCost[currentNode[2]][currentNode[1]], group )
        
        -- Path found! 
        return path
    else
        -- No path found
        return {}
    end
end



