-- Sounds

bgMusic = audio.loadStream('sound/POL-rocket-station-short.wav')
explo = audio.loadSound('sound/explo.wav')

-- Variables
KIWI = "kiwi"

yPos = {90, 140, 180}
speed = 5
up = false
impulse = -60
counter = 0

-- START:globalPlanetVars
-- The planet's coordinates
PLANET_X = 160
PLANET_Y = 480
-- END:globalPlanetVars

-- Starting radius for the ships
SHIP_DIST = 400 

-- Planet parameters
PLANET_RADIUS_SQ = 6400
PLANET_RADIUS = 80

-- Sprites
SPR_SHIP = "player"

-- START:lifeIcon
-- Icons
IMG_LIFE = "player_life"
-- END:lifeIcon
