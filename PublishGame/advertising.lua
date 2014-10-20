-- START:requireAdsLib
-- Load the ads library

local ads = require "ads"
ADS_APP_ID = nil -- This should be your ads app ID
--END:requireAdsLib

-- START:showAds
-- Store the settings for the game's ads
AD_NETWORK = "inmobi"
-- Init the ads API
ads.init( AD_NETWORK, ADS_APP_ID )
-- Show an inMobi ad
function showInMobiAds( )
    ads.show( "banner300x250", { x=0, y=0, interval=60, testMode=true } )
    -- Remember to set testMode = false when you build your app! 
end
--END:showAds

-- START:inneractiveAds
AD_NETWORK = "inneractive"

-- Show inneractive ads
function showInneractiveAds( )
    ads.show( "fullscreen", { x=adX, y=adY, interval=60, 
        testMode=true }, inneractiveListener )
    -- Remember to set testMode = false when you build your app! 
end
--END:inneractiveAds

