#programmingtask - queen problem
#how many different possibilities are there to arrange 8 queens on a chess board without them standing in each others way?

#playing around (delete later)
board[1,1] = 1
board[3,2] = 1
board[5,3] = 1
board[2,4] = 1
board[4,5] = 1

#funcitons
function check(ver,hor) #check if the input field is blocked
    isit = false
    for i = 1:7
        if i == 1 #check vertical
            if 1 in board[ver,:]
                isit = true
                break
            end
        elseif i == 2 #check horizontal
            if 1 in board[:,hor]
                isit = true
                break
            end
        elseif i == 3 #check diag bottom right
            a = 1
            while ver+a < 9 && hor+a < 9
                if board[ver+a,hor+a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 4 #check diag bottom left
            a = 1
            while ver+a < 9 && hor-a > 0
                if board[ver+a,hor-a] == 1
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 5 #check diag top right
            a = 1
            while ver-a > 0 && hor+a < 9
                if board[ver-a,hor+a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 6 #check diag top left
            a = 1
            while ver-a > 0 && hor-a > 0
                if board[ver-a,hor-a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 7 #case where a spot gets skipped
            if board[ver,hor] == 2
                isit = true
            end
        end
    end
    return isit
end

function get_logicboard() #output a board of blocked (1) and unblocked (0) fields 
    logicboard = zeros(Bool,8,8)
    for i = 1:8
        for j = 1:8
            logicboard[i,j] = check(i,j)
        end
    end
    return logicboard
end

function restart_paramters() #restart index, counter and board
    global index = [CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),
    CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0)]
    global counter = 0
    global iter = 0
    global board = zeros(Int8,8,8)
    return nothing
end

#when a entry gets 1->2 due to no 0 in get_logicboard() all works fine 
#but when the previous entry is the new main entry (last non 00 entry), all following 2's should become 0's again.
#####problems with 2 still not fixed.

restart_paramters()
while counter < 1
    if 0 in get_logicboard()
        #write next possible queen position to next empty index [1-8]
        index[findfirst(==(CartesianIndex(0, 0)),index)] = findfirst(==(0),get_logicboard())
        #move queen : write 1 to the board at the last non 0 index position
        board[index[findlast(!=(CartesianIndex(0, 0)),index)][1],index[findlast(!=(CartesianIndex(0, 0)),index)][2]] = 1
    else
        #track of 2
        if 2 in board
            if findfirst(==(2),board) > index[findlast(!=(CartesianIndex(0, 0)),index)]
                board = replace(board, 2=>0)
                #println("yep")
            end
            global first2 = findfirst(==(2),board)
        end
        #remove queen : write 2 to the board at the last non 0 index position
        board[index[findlast(!=(CartesianIndex(0, 0)),index)][1],index[findlast(!=(CartesianIndex(0, 0)),index)][2]] = 2
        #delete last non zero index entry
        index[findlast(!=(CartesianIndex(0, 0)),index)] = CartesianIndex(0, 0)
    end

    #test endcondition
    if count(==(1),board) == 8
        counter += 1
    end
    iter += 1
    #sleep(1.5)
    println(iter)
    #display(board)
    # if iter == 7
    #     break
    # end
end


