-- START:requires
require "class"
require "globals"
require "auxiliary"
-- END:requires

-- START:unitConstructor
Unit = Class( )
-- Unit constructor
function Unit:new( group, imagesheet )
    -- Create a new sprite and add it to the group
    local spriteInstance = display.newSprite( imagesheet, 
        spriteSequences.shipsSequence )
		
    spriteInstance.x = -50
    spriteInstance.y = -50
	
    group:insert( spriteInstance )
    self.spriteInstance = spriteInstance
end
-- END:unitConstructor

-- START:unitFunctions
-- Set the unit's position
function Unit:setPosition( x, y )
    self.spriteInstance.x = x
    self.spriteInstance.y = y
    self.x = x
    self.y = y
end
-- Move the unit in the y direction
function Unit:move( )
    self.y = self.y + self.vy
    self.spriteInstance.rotation = 0
    self.spriteInstance.y = self.y
    self.spriteInstance.x = self.x
end
-- Check whether the unit is out of bounds
function Unit:toggleDelete( )
    if (( self.y < -20 ) or ( self.y > 500 )) then
        return true
    end
    return false
end
-- Remove the unit
function Unit:removeMe( )
    self.spriteInstance:removeSelf( )
    self.spriteInstance = nil
end
-- END:unitFunctions

-- START:enemyConstructor
Enemy = Class( Unit )
-- Enemy constructor
function Enemy:new( group, imagesheet )
    -- Set position and speed
    self.x = 10 + math.random( 300 )
    self.y = -10
    self.vy = 3
    self.spriteInstance.x = self.x
    self.spriteInstance.y = self.y
    -- Prepare the enemy's sprite
    self.spriteInstance:setSequence( ENEMY_1 )
end
-- END:enemyConstructor

-- START:playerConstructor
Player = Class( Unit )

-- Player constructor
function Player:new( group, imagesheet )
    self.spriteInstance.x = WIDTH / 2
    self.spriteInstance.y = 400
    self.x = self.spriteInstance.x
    self.y = self.spriteInstance.y   
	
    -- Don't set a target coordinate when the game starts
    self.targetX = self.spriteInstance.x
    self.targetY = self.spriteInstance.y
    -- Display the player's ship
    self.spriteInstance:setSequence( PLAYER_CENTRE )
end
-- END:playerConstructor

-- START:playerFunctions
-- Set the player's target coordinates
function Player:setTargetPosition( x, y )
    self.targetX = x
    self.targetY = y
end
-- Remove target coordinates from the player's ship
function Player:resetTargetPosition( )
    self.targetX = self.spriteInstance.x
    self.targetY = self.spriteInstance.y
end
-- Move the player
function Player:move( )
end
-- END:playerFunctions

-- START:playerMovement
-- Move the player
function Player:move( )
    -- Calculate the distance to the target
    local dx = self.targetX - self.x
    local dy = self.targetY - self.y
    dx = dx / PLAYER_SPEED_COEFF
    local vx = math.max( math.min( PLAYER_MAXSPEED, dx ), -PLAYER_MAXSPEED )
    self.x = self.x + vx
    self.spriteInstance.x = self.x
    
    -- Steer the ship right or left if it's moving horizontally
    if ( self.targetX > self.spriteInstance.x + 15 ) then
        self.spriteInstance:setSequence( PLAYER_RIGHT )
    elseif ( self.targetX < self.spriteInstance.x - 15 ) then
        self.spriteInstance:setSequence( PLAYER_LEFT )
    else
        self.spriteInstance:setSequence( PLAYER_CENTRE )
    end
end
-- END:playerMovement
