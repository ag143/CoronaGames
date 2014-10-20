-- Remove a file extension from a file name
function removeExtension( filename )
    return string.sub( filename, 0, string.len(filename) - 4 )
end

-- START:calculateDistance
-- Calculate the distance between two objects
function CalculateDistance( objA, objB ) 
    local hyp = 0
    if ( objB ~= nil) then
        local dx = objA.x - objB.x
        local dy = objA.y - objB.y
        local hypsq = dx * dx + dy * dy
        hyp = math.sqrt( hypsq )
    else
        hyp = 10000000
    end
    
    return hyp
end
-- END:calculateDistance
