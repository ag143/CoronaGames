-- START:showLives
-- Show the number of lives that the player has
function showLives( group )
    -- Add an image to display the life
    local lifeIcon = display.newImage( imagesheet, 
        spritedata:getFrameIndex( IMG_LIVES ) )
    lifeIcon.anchorX, lifeIcon.anchorY = 0, 0
    group:insert( lifeIcon )
    lifeIcon.x, lifeIcon.y = 4, 28
    
    -- Add a text box
    livesText = display.newText( group, lives, 28, 28, 100, 20, 
        native.systemFont, 18 )
    livesText.anchorX, livesText.anchorY = 0, 0
    livesText:setFillColor( 1, 200/255, 200/255 )
end
-- END:showLives

-- START:updateLives
-- Display the player's lives
function updateLivesDisplay( )
    livesText.text = lives
end
-- END:updateLives
