-- Stage size
WIDTH = 320
HEIGHT = 480

-- START:bulletInfo
-- Object type IDs
TYPE_PLAYER = 1
TYPE_ENEMY = 2
TYPE_PLAYER_BULLET = 3
TYPE_ENEMY_BULLET = 4
TYPE_POWERUP = 5
POWERUP_HEALTH = 1
POWERUP_LIFE = 2
-- END:bulletInfo

-- Toggle delete statuses
DO_NOT_REMOVE = 0
REMOVE_EXPLODE = 1
REMOVE_QUIET = 2

-- START:asteroidInfo
ASTEROID_NAME = "asteroid_"
-- ASTEROID_FRAME = 16
ASTEROID_VARIANCE = 3
CRATER_NAME = "crater_"
-- CRATER_FRAME = ASTEROID_FRAME + ASTEROID_VARIANCE
CRATER_VARIANCE = 4
-- END:asteroidInfo

-- START:lives
-- Game variables
MAX_LIVES = 5
lives = MAX_LIVES
-- END:lives

-- START:enemySpawn
ENEMY_DELAY = 30
-- END:enemySpawn

-- START:playerSpeed
PLAYER_MAXSPEED = 10
PLAYER_SPEED_COEFF = 15
-- END:playerSpeed

-- START: parallaxGlobals
-- Parallax layer speeds
parallaxCoefficient1 = 2
parallaxCoefficient2 = 1
-- END: parallaxGlobals

-- START:shipSpriteInfo
-- Player images
PLAYER_LEFT = "player_l"
PLAYER_CENTRE = "player"
PLAYER_RIGHT = "player_r"
-- END:shipSpriteInfo

-- Enemy images
ENEMY_1 = "enemy1"
ENEMY_2 = "enemy2"
ENEMY_3 = "enemy3"

-- START:bulletInfo

-- Bullet variables
BULLET_RELOAD = 20
ENEMY_BULLET_RELOAD = 100

-- Bullet sprite
PLAYER_BULLET = "player_bullet"
ENEMY_BULLET = "enemy_bullet"
-- END:bulletInfo

-- START:explosions
EXPLOSION = "explosion_01"
-- END:explosions

-- START:powerUps
-- Power-up variables
POWERUP_SPEED = 4
POWERUPS = {
    HEALTH_POWERUP = "health_powerup",
    PLAYER_LIFE = "player_life"
}
-- END:powerUps
