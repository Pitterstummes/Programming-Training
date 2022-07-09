#programmingtask - queen problem
#how many different possibilities are there to arrange 8 queens on a chess board without them standing in each others way?

#initializing the board
board = zeros(Int8,8,8)
board[1,1] = 1
board[3,2] = 1
board[5,3] = 1
board[2,4] = 1
board[4,5] = 1

#funcitons
function check(ver,hor)
    isit = false
    for i = 1:7
        if i == 1
            if 1 in board[ver,:]
                isit = true
                break
            end
        elseif i == 2
            if 1 in board[:,hor]
                isit = true
                break
            end
        elseif i == 3
            a = 1
            while ver+a < 9 && hor+a < 9
                if board[ver+a,hor+a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 4
            a = 1
            while ver+a < 9 && hor-a > 0
                if board[ver+a,hor-a] == 1
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 5
            a = 1
            while ver-a > 0 && hor+a < 9
                if board[ver-a,hor+a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        elseif i == 6
            a = 1
            while ver-a > 0 && hor-a > 0
                if board[ver-a,hor-a] == 1 
                    isit = true
                    break
                end
                a += 1
            end
        end
    end
    return isit
end

function get_logicboard()
    logicboard = zeros(Bool,8,8)
    for i = 1:8
        for j = 1:8
            logicboard[i,j] = check(i,j)
        end
    end
    return logicboard
end

get_logicboard()
findfirst(==(0),get_logicboard())
findnext(==(0),get_logicboard(),CartesianIndex(1,3))

board

counter = 0
index = [CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0),CartesianIndex(0,0)]
while counter < 1
    if 0 in get_logicboard()

