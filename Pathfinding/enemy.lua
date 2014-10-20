-- START:enemyClass
Enemy = Class( )

-- Constructor
function Enemy:new( position, group, creepData )
    -- Create a new sprite and add it to the group
    local spriteInstance = display.newImage( 
        imagesheet, spritedata:getFrameIndex( IMG_ENEMY ) )
    self.speed = creepData.speed
    self.direction = 0
    self.health = creepData.hp
    self.maxHealth = self.health
    self.bounty = creepData.moneyPerKill
    self.alive = true
    self.spriteInstance = spriteInstance
    self.spriteInstance.object = self
    
    -- Create a group and insert the sprites in it
    self.unitGroup = display.newGroup( )
    group:insert( self.unitGroup )
    self.unitGroup:insert( spriteInstance )
    self:drawHealthRect( )
    self:updateHealth( )

    -- Coordinates
    self.x = position.x
    self.y = position.y
    self.unitGroup.x = position.x
    self.unitGroup.y = position.y
    self.targetX = self.x
    self.targetY = self.y
    self.spriteInstance.x = 0
    self.spriteInstance.y = 0
    
    -- END:enemyClass
    -- START:addEnemyToStage
    -- Find a path from the spawn point to the exit point
    -- Calculate the path
    self.path = findPath( math.ceil( position.x / TILE_WIDTH ), 
        math.ceil( position.y / TILE_HEIGHT ), endTile.x, 
        endTile.y, group )
    -- END:addEnemyToStage
-- START:enemyClass
end
-- END:enemyClass

-- START:enemyClass2
-- Movement
function Enemy:move( )
    -- Move the unit using the speed and angle
    self.x = self.x + self.speed * math.sin( self.direction )
    self.y = self.y + self.speed * math.cos( self.direction )
end

-- Check whether the unit should be deleted
function Enemy:toggleDelete( )
    if (( self.y < -20 ) or ( self.y > 340 ) 
    or ( self.x < -20 ) or ( self.x > 500 )) then
        -- The unit is out of bounds
        return true
    elseif self.alive == false then
        -- The unit is dead
        return true
    end
    
    -- Alive
    return false
end

-- Remove function
function Enemy:removeMe( )
    self.spriteInstance:removeSelf( )
    self.spriteInstance = nil
    self.rectangleForeground:removeSelf( )
    self.rectangleForeground = nil
    self.rectangleBackground:removeSelf( )
    self.rectangleBackground = nil
    self.unitGroup:removeSelf( )
    self.unitGroup = nil
end
-- END:enemyClass2

-- START:moveEnemiesPathfinding
-- START:killEnemies
function Enemy:move( )
    -- END:killEnemies
    -- Calculate the x and y distances to the target
    local dx = self.targetX - self.x
    local dy = self.targetY - self.y
    local hypotenusesq = dx * dx + dy * dy
    
    -- print( hypotenusesq )
    -- START:killEnemies
    -- If we're close to the target coordinates, get the next target tile
    if hypotenusesq < 100 then
        -- print( "path: " .. #(self.path) )
        if #(self.path) == 0 then
            -- The unit reached the end of the path. It wins. 
            -- END:moveEnemiesPathfinding
            self.alive = false
            lives = lives - 1
            updateLivesDisplay( )
            -- START:moveEnemiesPathfinding
        else
            -- Get the next tile
            -- END:killEnemies
            local destinationPos = self.path[#(self.path)]
            self.targetX = ( destinationPos[1] - 0.5 ) * TILE_WIDTH
            self.targetY = ( destinationPos[2] - 0.5 ) * TILE_HEIGHT
            dx = self.targetX - self.x
            dy = self.targetY - self.y
            self.direction = math.atan2( dy, dx )
            self.spriteInstance.rotation = 90 + 
                self.direction * 180 / math.pi
            removeTableRows(self.path, #self.path, 1)
            -- START:killEnemies
        end
    end
    -- END:killEnemies
    
    -- Move the unit
    -- print( self.direction) 
    -- print( self.direction )
    self.x = self.x + self.speed * math.cos( self.direction )
    self.y = self.y + self.speed * math.sin( self.direction )
    self.unitGroup.x = self.x
    self.unitGroup.y = self.y
    
    -- print( self.spriteInstance.rotation * 90 )
-- START:killEnemies
end
-- END:killEnemies
-- END:moveEnemiesPathfinding

-- START:healthBars
-- Draw the health rectangles
function Enemy:drawHealthRect( )
    -- Draw the background rectangle (grey with transparency)
    local rectangleBG = display.newRect( -HEALTH_BAR_WIDTH / 2, -35, 
        HEALTH_BAR_WIDTH, HEALTH_BAR_HEIGHT )
    rectangleBG:setFillColor( 200/255, 200/255, 200/255 )
    rectangleBG.anchorX = 0
    rectangleBG.alpha = 0.5
    -- Draw the foreground rectangle (red) 
    local rectangleFG = display.newRect( -HEALTH_BAR_WIDTH / 2, -35, 
        HEALTH_BAR_WIDTH * ( self.health / self.maxHealth ), 
        HEALTH_BAR_HEIGHT )
    rectangleFG:setFillColor( 150/255, 50/255, 50/255 )
    -- Set the reference point to the left to be able to scale it afterwards
    rectangleFG.anchorX = 0
    -- Add both bars to the enemy's group
    self.unitGroup:insert( rectangleBG )
    self.unitGroup:insert( rectangleFG )
    -- Store the rectangles for quick access
    self.rectangleBackground = rectangleBG
    self.rectangleForeground = rectangleFG
end
-- END:healthBars

-- START:healthBarsUpdate
function Enemy:updateHealth( amount )
    -- Subtract amount and add gold to the player
    if ( amount ~= nil ) then
        self.health = self.health - amount
        if ( self.health <= 0 ) then
            addMoney( self.bounty )
            self.alive = false
        end
    end
    -- Update the health bar's width
    self.rectangleForeground.xScale = self.health / self.maxHealth + 0.01
end
-- END:healthBarsUpdate
