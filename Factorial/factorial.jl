#output initial text and ask for input
function asknumber()
    println("This program calculates the factorial of a number. \nPlease enter a number: ")
    parse(Int64, readline())
end
#save input to variable
num = asknumber()
factorial = 1
#check for different cases and calculate the factorial
if num < 0
    println("Sorry, factorial does not exist for negative numbers")
elseif num == 0
    println("The factorial of 0 is 1")
else
    for i in 1:num
        global factorial = factorial*i
    end
    println("The factorial of ", num, " is " ,factorial)
end
#add readline() for the window to not close directly
readline()
