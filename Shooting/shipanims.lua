spriteSequences = {}

spriteSequences.shipsSequence = {
    { 
        name = PLAYER_CENTRE,
        start = spritedata:getFrameIndex( PLAYER_CENTRE ),
        count = 1
    },
    { 
        name = PLAYER_LEFT,
        start = spritedata:getFrameIndex( PLAYER_LEFT ),
        count = 1
    },
    { 
        name = PLAYER_RIGHT,
        start = spritedata:getFrameIndex( PLAYER_RIGHT ),
        count = 1
    },
    { 
        name = ENEMY_1,
        start = spritedata:getFrameIndex( ENEMY_1 ),
        count = 1
    },
    { 
        name = ENEMY_2,
        start = spritedata:getFrameIndex( ENEMY_2 ),
        count = 1
    },
    { 
        name = ENEMY_3,
        start = spritedata:getFrameIndex( ENEMY_3 ),
        count = 1
    }
}

-- START:bulletSequence
spriteSequences.bulletSequence = {
    { 
        name = PLAYER_BULLET,
        start = spritedata:getFrameIndex( PLAYER_BULLET ),
        count = 1
    },
    { 
        name = ENEMY_BULLET,
        start = spritedata:getFrameIndex( ENEMY_BULLET ),
        count = 1
    },
}
-- END:bulletSequence

-- START:explosionSequence
spriteSequences.explosionSequence = {
    name = EXPLOSION,
    start = 1,
    count = 16,
    loopCount = 1
}
-- START:explosionSequence

-- START:powerupSequence
spriteSequences.powerupSequence = {
    {
        name = POWERUPS.HEALTH_POWERUP,
        start = spritedata:getFrameIndex( POWERUPS.HEALTH_POWERUP ),
        count = 1
    },
    {
        name = POWERUPS.PLAYER_LIFE,
        start = spritedata:getFrameIndex( POWERUPS.PLAYER_LIFE ),
        count = 1
    }
}
-- START:powerupSequence

return spriteSequences