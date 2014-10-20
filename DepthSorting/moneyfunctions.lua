-- START:moneyVariable
-- Gold amount
playerGold = 100
-- Text box to show gold amount
goldText = nil
-- END:moneyVariable

-- START:moneyMinusFunctions
-- Check we have enough gold, but don't spend it. 
function hasEnoughMoneyToSpend( amount )
    if ( playerGold >= amount ) then
        -- The player has enough gold
        return true
    else
        return false
    end
end
-- Spend gold
function subtractMoney( amount )
    -- Subtract the gold
    playerGold = playerGold - amount
    -- Update the gold text box
    updateGoldDisplay( )
end
-- END:moneyMinusFunctions

-- START:moneyPlusFunctions
function addMoney( amount )
    playerGold = playerGold + amount
    
    -- Update the gold text box
    updateGoldDisplay( )
end
-- END:moneyPlusFunctions

-- START:currencyDisplay
function showCurrency( group )
    -- Add an icon to display the currency
    local goldIcon = display.newImage( imagesheet, 
        spritedata:getFrameIndex( IMG_GOLD ) )
    goldIcon.anchorX, goldIcon.anchorY = 0, 0
    group:insert( goldIcon )
    goldIcon.x, goldIcon.y = 4, 4
    
    -- Add a text box
    goldText = display.newText( group, playerGold, 28, 4, 100, 
        20, native.systemFont, 18 )
    goldText.anchorX, goldText.anchorY = 0, 0
    goldText:setFillColor( 1, 230/255, 200/255 )
end
-- END:currencyDisplay

-- START:updateGoldDisplay
-- Display the player's gold
function updateGoldDisplay( )
    goldText.text = playerGold
end
-- START:updateGoldDisplay
