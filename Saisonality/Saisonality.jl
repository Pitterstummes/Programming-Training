#programm to en- and decode a base10 number into binary in order do assign months a true or false for 12 binary digets
#binary to decimal and back to binary conversion. While loop fills zeros infront till length = 12
binarymonth = "111111111101"
decimalmonth = parse(Int,binarymonth,base=2)
binarymonthre = string(decimalmonth, base=2)
while length(binarymonthre) < 12
        binarymonthre = "0"*binarymonthre
end
println(binarymonthre)
#define name of the months
month = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
#count months in which the product is in season and create a String with corresponding positions
truemonths = 0
positionvar = "0"
for i in 1:12
        if binarymonth[i:i] == string(1)
                truemonths = truemonths+1
                actualmonth[i] = month[i]
                positionvar = positionvar*","*string(i)
        end
end
#
positionsplit = split(chop(positionvar,head=2,tail=0),",")
if truemonths == 1
        println("The product is only in season in ",month[parse(Int,positionsplit[1])],".")
elseif truemonths == 2
        println("The product is only in season in ",month[parse(Int,positionsplit[1])], " and ",month[parse(Int,positionsplit[2])],".")
elseif truemonths == 10
        for j in 1:12
                if !(string(j) in positionsplit)
                        
                end
        end
        println("The product is in season all year except ",month[j],".")
elseif truemonths == 11
        for j in 1:12
                if !(string(j) in positionsplit)
                        println("The product is in season all year except ",month[j],".")
                end
        end
elseif truemonths == 12
        println("The product is in season all year round.")
end
println(positionsplit)
