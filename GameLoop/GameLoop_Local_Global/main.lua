-- START:globalVariable
-- Define a global variable called hidingVariable, 
--    and set its value to "global"
print( "Setting the global hidingVariable to \"global\"" )
hidingVariable = "global"
print ( "the global hidingVariable = " .. hidingVariable )
-- END:globalVariable

-- START:functionVariable
-- Create a function that uses a function-level hidingVariable
--    and set its value to "function"
-- Store a local variable 
function checkHidingVariable( )
    print( "Setting the function's local hidingVariable to \"function\"" )
    local hidingVariable = "function"
    print( "In the function, hidingVariable = " .. hidingVariable )
end
-- END:functionVariable

-- START:functionVariableValue
-- Run the function and print the variable's value
checkHidingVariable( )
print( "After the function ends, the global "..
    "hidingVariable is still = " .. hidingVariable )

-- Include the external file and print the value again
require( "hidingvariable" )
print( "After including the external file, the global "..
    "hidingVariable is still = " .. hidingVariable )
-- END:functionVariableValue
