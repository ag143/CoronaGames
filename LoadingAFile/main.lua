-- START:openAFile
-- Get the path to the file in the documents folder
local fullPath = system.pathForFile( "files/levels.txt", system.ResourceDirectory )

-- Open the file in read mode
local fileHandle = io.open( fullPath, "r" )
-- END:openAFile

-- START:readAndPrintFile
-- If we've opened it, read it
if ( fileHandle ) then
    -- Read it and print it on the console
    print( fileHandle:read("*a") )
    print( "Successfully read the file!" )
end

-- Close the file
io.close( fileHandle )
-- END:readAndPrintFile


