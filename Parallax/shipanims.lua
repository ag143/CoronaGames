-- START:shipAnims
local spriteSequences = {}

spriteSequences.shipsSequence = {
    { 
        name = PLAYER_CENTRE,
        start = spritedata:getFrameIndex( PLAYER_CENTRE ),
        count = 1
    },
-- END:shipAnims
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
-- START:shipAnims
}

return spriteSequences
-- END:shipAnims
