#functions
function initialize(board_size)
    global board = ones(Int8,3*board_size-2)
    board[:] .= -5*board_size
    for i = 1:board_size
        board[board_size-1+i] = board_size+1-i
    end
    board[board_size] = board_size-1 #because i start with adding a 1
    return nothing
end
function no_collision(board_size)
    isit = true
    if length(unique(board[board_size:2*board_size-1])) < board_size
        isit = false
    end
    #check for the diagonal
    for i = 1:board_size
        for j = 1:board_size-1 #rang #-size+1:size-1 wthout 0
            if board[i+board_size-1] == board[i+board_size-1+j]+j
                isit = false
                break
            elseif board[i+board_size-1] == board[i+board_size-1-j]+j
                isit = false
                break
            elseif board[i+board_size-1] == board[i+board_size-1+j]-j
                isit = false
                break
            elseif board[i+board_size-1] == board[i+board_size-1-j]-j
                isit = false
                break
            end
        end
    end 
    return isit
end
function dostep(board_size)
    board[board_size] += 1
    for i = 1:board_size-1
        if board[i+board_size-1] == board_size+1
            board[i+board_size-1] = 1
            board[i+board_size] += 1
        end
    end
    return nothing
end
function dowork(board_size::Int)
    #Limiting input range
    board_size < 1 && error("Board size has to be at least 1.")
    board_size > 9 && error("Choose smaller board size, calculation takes too long.")
    #Initializing parameters
    initialize(board_size)
    counter = 0
    global iter = 0
    #Loop while last board is not reached yet
    while true
        iter += 1
        # if mod(iter,1) == 0
        #     print(iter)
        #     print(" ")
        #     println(board[board_size:2board_size-1])
        # end
        dostep(board_size)
        if board[2*board_size-1] >= board_size+1
            println("there are ",counter," possible solutions to place ",board_size," queens on a ",board_size,"x",board_size," chessboard.")
            break
        end
        #display(board[8:15])
        if no_collision(board_size)
            counter += 1
            #display(board[board_size:2*board_size-1])
            #println(counter)
        end
    end    
    return nothing
end

#workarea
@time dowork(6) #20 seconds for 7 - way more for bigger numbers