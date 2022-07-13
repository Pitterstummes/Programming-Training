#Initializing
using Flux

#create Training Data
W_truth = [1 2 3 4 5; 5 4 3 2 1]
b_truth = [-1.0; -2.0]
ground_truth(x) = W_truth*x .+ b_truth

#genereate (also add noise)
x_train = [ 5 .* rand(5) for _ in 1:10_000 ]
y_train = [ ground_truth(x) + 0.2 .* randn(2) for x in x_train ]

#define model
model(x) = W*x .+ b_truth
#init parameters
W = rand(2,5)
b = rand(2)

#define loss function
function loss(x,y)
    yy = model(x)
    sum((y .- yy).^2)
end

#set optimizer here: classic gradient descent optimiser
#train by running an optimiser that finds the best parameters (W,b) that achieve the best score of the loss function
opt = Descent(0.01)

#train model
train_data = zip(x_train, y_train)
ps = Flux.params(W, b)

for (x,y) in train_data
    gs = Flux.gradient(ps) do 
        loss(x,y)
    end
    Flux.Optimise.update!(opt, ps, gs)        
end

#alternative for that loop is
Flux.train!(loss, Flux.params(W, b), train_data, opt)

#examine result
@show W
@show maximum(abs,W .- W_truth)