-- Require the Class files
-- START:requireClass
require("class")
-- END:requireClass

-- START:newMathsNumberClass
-- Create a new class and initialize a list of numbers
MathsNumber = Class( )
listOfNumbers = { }
-- END:newMathsNumberClass

-- START:mathsNumberConstructor
-- Create the MathsNumber constructor
function MathsNumber:new( number )
    -- Store the value as one of the instance's properties (use self to do so)
    self.value = number
    -- Print the number, its square, its square root, and its cosine
    print( "Number: "..number )
    print( "Square: "..(number * number) )
    print( "Square Root: ".. (math.sqrt(number)) )
    print( "Cosine: ".. (math.cos(number)) )
end
-- END:mathsNumberConstructor

-- START:calculateAverage
-- Calculates the average of the list of numbers
function calculateAverage( )
    -- Initialize a variable to 0
    local total = 0
    -- Add each number from the list to the total
    for i = 1, #listOfNumbers do
        total = total + listOfNumbers[ i ].value
    end
    -- Divide the total by the number of numbers
    print( )
    print( "The sum is: " .. total )
    average = total / #listOfNumbers
    print( "The average is: "..average )
end
-- END:calculateAverage

-- START:checkMathsWork
-- Create five instances of the class and add them to the list of numbers
listOfNumbers [ #listOfNumbers + 1 ] = MathsNumber(1)
listOfNumbers [ #listOfNumbers + 1 ] = MathsNumber(3)
listOfNumbers [ #listOfNumbers + 1 ] = MathsNumber(5)
listOfNumbers [ #listOfNumbers + 1 ] = MathsNumber(7)
listOfNumbers [ #listOfNumbers + 1 ] = MathsNumber(9)
-- Calculate the average
calculateAverage( )
-- END:checkMathsWork

