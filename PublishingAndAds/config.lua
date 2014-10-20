-- START:multires
-- START:multires3
application = {
    content = {
        -- END:multires
        -- END:multires3
        width = 320,
        height = 480, 
        scale = "letterBox",
        fps = 30,
        
        -- START:multires
        imageSuffix = {
            ["-med"] = 1.8,
        }
        -- END:multires
        
        -- START:multires3
        imageSuffix = {
            ["-m"] = 1.5,
            ["-l"] = 2,
        }
        -- START:multires
    },
}
-- END:multires3
-- END:multires
