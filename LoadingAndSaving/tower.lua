towers = { }

function shootBeam( tower, target ) 
    target:updateHealth( 1 )
    beams[ #beams + 1 ] = Beam( beamsLayer, tower.x, tower.y - 40, target.x, target.y )
end

-- START:towerUpdateCall
function updateTowers( )
    -- Update the towers each frame
    for i = 1, #towers do
        local target = towers[i]:update( enemies )
        
        -- If the tower returns a target, shoot a new bullet
        if target ~= 0 then
            shootBeam( towers[i], target )
        end
    end
end
-- END:towerUpdateCall


-- Tower Class
Tower = Class( )

function Tower:new( posx, posy, group )
    -- Create a new sprite and add it to the group
    local spriteInstance = display.newImage( imagesheet, spritedata:getFrameIndex( IMG_TOWER ) )
    spriteInstance.anchorX, spriteInstance.anchorY = 0.5, 1
    spriteInstance.x = posx * TILE_WIDTH - TILE_WIDTH / 2
    spriteInstance.y = posy * TILE_HEIGHT
    group:insert( spriteInstance )
    self.spriteInstance = spriteInstance
    self.spriteInstance.object = self
    self.x = spriteInstance.x
    self.y = spriteInstance.y
    
    -- Shooting properties
    self.reloadTime = 20
    self.reloadNotShoot = 5
    self.reload = self.reloadTime
    self.range = 150
    
    -- START:enemyTargetVariable
    -- Store the enemy target
    self.target = 0
    -- END:enemyTargetVariable
end

-- START:towerUpdate
-- Make the towers aim and shoot at enemies
-- Return an enemy target if we're shooting; 0 if we're not. 
function Tower:update( enemies )
    -- Update reload count
    self.reload = self.reload - 1
    
    -- Only update if we're able to shoot
    if self.reload <= 0 then
        if ( self.target == 0 ) or ( self.target == nil ) or ( self.target.alive == false ) 
            or ( CalculateDistance( self, target ) > self.range ) then
            
            -- The previous target isn't valid. Look for a new target. 
            self.target = 0
            if #enemies > 0 then
                -- Loop through the list of enemies 
                --  to find the nearest target
                local pos = 0
                local distance = 99999999
                for i = 1, #enemies do
                    -- Ignore dead enemies
                    if ( enemies[i].alive == true ) then
                        
                        -- Calculate the distance 
                        --   to the enemy
                        local tempDistance = 
                            CalculateDistance( self, 
                                enemies[i] )
                        
                        -- Compare to current distance;
                        --  store the smaller value
                        if tempDistance < distance then
                            distance = tempDistance
                            pos = i
                        end
                    end
                end
                
                -- Check whether we found a good target
                if ( pos > 0 ) and ( distance < self.range ) then
                    -- We found one! Let's shoot at it. 
                    self.target = enemies[pos]
                    self.reload = self.reloadTime
                    return self.target
                else
                    -- We didn't find any targets
                    --  reset the reload counter
                    self.reload = self.reloadNotShoot
                end
            end
            
        else
            -- Keep shooting at the current target
            self.reload = self.reloadTime
            return self.target
        end
    end
    
    -- We're not shooting. 
    return 0
end
-- END:towerUpdate