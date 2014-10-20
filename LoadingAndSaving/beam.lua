beams = { }

-- Update the beams
function updateBeams( )
    for i = #beams, 1, -1 do
        -- Update the beam
        local beam = beams[i]
        beam:update( )
        
        -- Delete inactive beams
        if ( beam:toggleDelete( ) == true ) then
            beam:removeMe( )
            removeTableRows( beams, i )
        end
    end
end

-- Beam class
Beam = Class( )

-- Beam constructor: create a blue line
function Beam:new( group, startX, startY, endX, endY )
    local beam = display.newLine( startX, startY, endX, endY )
    beam:setStrokeColor( 0, 0, 200/255 )
    beam.strokeWidth = 2
    beam.antialias = true
    group:insert( beam )
    self.beam = beam
    self.life = 8
end

-- Subtract 1 frame from the active counter
function Beam:update( )
    self.life = self.life - 1
end

-- Check if a beam is alive
function Beam:toggleDelete( )
    if ( self.life <= 0 ) then
        return true
    end
    
    return false
end

-- Remove a beam
function Beam:removeMe( )
    self.beam:removeSelf( )
    self.beam = nil
end