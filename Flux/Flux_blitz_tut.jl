#blitz tutorial

#init
using CUDA #make use of the GPU with using cu() infront of an command
using Flux: gradient
using Flux: params
using Flux

#work
x = cu(rand(5,3))

f(x) = 3x^2+2x+1
f(5)
df(x) = gradient(f,x)[1]
df(5)
ddf(x) = gradient(df,x)[1]
ddf(5)

mysin(x) = sum((-1)^k*x^(1+2k)/factorial(1+2k) for k in 0:5)
x = 0.5
mysin(x), gradient(mysin, x)
sin(x), cos(x)


myloss(W, b, x) = sum(W * x .+ b)
W = randn(3, 5)
b = zeros(3)
x = rand(5)
gradient(myloss, W, b, x)

y(x) = sum(W * x .+ b)
grads = gradient(()->y(x), params([W,b]))
grads[W]
grads[b]

m = Dense(10,5)
x = rand(Float32,10)

params(m)

x = rand(Float32, 10)
m = Chain(Dense(10, 5, relu), Dense(5, 2), softmax)
l(x) = sum(Flux.crossentropy(m(x), [0.5, 0.5]))
grads = gradient(params(m)) do
    l(x)
end
for p in params(m)
    println(grads[p])
end

using Flux.Optimise: update!, Descent
η = 0.1
for p in params(m)
  update!(p, -η * grads[p])
end

opt = Descent(0.01)

data, labels = rand(10, 100), fill(0.5, 2, 100)
loss(x, y) = sum(Flux.crossentropy(m(x), y))
Flux.train!(loss, params(m), [(data,labels)], opt)