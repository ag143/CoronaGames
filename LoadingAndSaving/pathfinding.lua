function showPathCost( tileX, tileY, cost, group )
    -- Add a text box
    local nt = display.newText( group, cost, 13 + (tileX - 1) * TILE_WIDTH, 5 + (tileY - 1) * TILE_HEIGHT, TILE_WIDTH, 20, native.systemFont, 14 )
    nt:setFillColor( 1, 230/255, 200/255 )
end

-- START:findPathFunc
-- Find paths using Dijkstra
function findPath( startX, startY, endX, endY, group )
    -- Initialize arrays
    -- END:findPathFunc
    -- START:initTravelTimes
    -- Prepare our program to implement the pathfinding algorithms
    -- Initialize a list of open nodes and set the current node
    local currentNode = { startX, startY }
    local openNodes = { currentNode }
    local start = { startX, startY }
    local destination = { endX, endY }

    -- Create travel times (path cost) and previous tiles lists for 
    --    the whole map and set their values to -1 (unvisited)
    local pathCost = { }
    local previousTile = { }
    for i = 1, mapHeight do
        pathCost[i] = { }
        previousTile[i] = { }
        for j = 1, mapWidth do
            pathCost[i][j] = -1
            previousTile[i][j] = -1
        end
    end
    pathCost[startY][startX] = 0
    
    -- Show the path cost in a text box
    -- showPathCost( startX, startY, 0, group )
    -- END:initTravelTimes
    -- START:findPathFunc
    
    -- Loop until we scan all the map
    local loops = 1000
    repeat
        loops = loops - 1
        
        -- Get the next open node
        currentNode = openNodes[1]
        -- print( "node: " .. currentNode[1] .. ", " .. currentNode[2] .. ", " .. pathCost[startX][startY] )
        
        -- Get the current node's neighbors
        local neighbors = { 
        { currentNode[1] - 1, currentNode[2] }, 
        { currentNode[1], currentNode[2] - 1 }, 
        { currentNode[1] + 1, currentNode[2] }, 
        { currentNode[1], currentNode[2] + 1 } 
        }
        
        -- Loop through the neighbors 
        --   and add unvisited ones to the open list
        for i = 1, #neighbors do
            local neighbor = neighbors[i]
            -- print( neighbor[1] .. ", " .. neighbor[2] )
            
            -- Check this is a valid tile
            -- START:findPathCheck
            -- Find paths if the tile is within bounds and it is walkable
            if (neighbor[1] > 0) and (neighbor[1] <= mapWidth) 
                and (neighbor[2] > 0) 
                and (neighbor[2] <= mapHeight) 
                -- END:findPathFunc
                -- and getWalkableType( map[neighbor[2]][neighbor[1]] ) == TILE_WALK 
                -- START:findPathFunc
                then
                -- END:findPathCheck
                
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
                    -- showPathCost( neighbor[1], neighbor[2], newCost, group )
                    
                    -- Add the tile to the open nodes list
                    openNodes[#openNodes + 1] = neighbor
                end
            -- START:findPathCheck
            else
                if (neighbor[1] > 0) and (neighbor[1] <= mapWidth) 
                    and (neighbor[2] > 0) 
                    and (neighbor[2] <= mapHeight) then
                    
                    -- print( "not walkable " .. neighbor[1] .. ", " .. neighbor[2] .. "; " .. map[neighbor[2]][neighbor[1]] )
                end
            end
            -- END:findPathCheck
        end
        
        -- Remove the previous node from the list
        -- print( #openNodes .. " nodes" )
        removeTableRows( openNodes, 1, 1 )
        
    until (#openNodes == 0) or (loops < 0)
    
    -- Check whether we found a path
    if (map[destination[2]][destination[1]] ~= -1) then
        -- Path found! Return it. 
        local path = { destination }
        currentNode = destination
        -- print( currentNode[1] .. ", " .. currentNode[2] )
        
        -- Loop through the tiles until we reach the start of the path
        while ( currentNode[1] ~= start[1] ) or ( currentNode[2] ~= start[2] ) do
            -- print( currentNode[1] .. ", " .. currentNode[2] )
            -- showPathCost( currentNode[1], currentNode[2], "x", group )
            currentNode = previousTile[currentNode[2]][currentNode[1]]
            path[#path + 1] = currentNode
        end
        path[#path + 1] = start
        -- showPathCost( currentNode[1], currentNode[2], "x", group )
        
        -- Path found! 
        return path
    else
        -- No path found
        return {}
    end
    -- END:checkParentTile
    -- START:findPathFunc
end
-- END:findPathFunc



