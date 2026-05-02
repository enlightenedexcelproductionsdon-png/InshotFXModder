local function gaussKernel(size, sigma)
local kernel = {}
local sum = 0
local r = math.floor(size / 2)
for y = -r, r do
kernel[y + r + 1] = {}
for x = -r, r do
local v = math.exp(-(x * x + y * y) / (2 * sigma * sigma))
kernel[y + r + 1][x + r + 1] = v
sum = sum + v
end
end
for y = 1, size do
for x = 1, size do
kernel[y][x] = kernel[y][x] / sum
end
end
return kernel
end

local function clamp(v, min, max)
if v < min then return min end
if v > max then return max end
return v
end

local function applyGaussianBlur(image, width, height, size, sigma)
local kernel = gaussKernel(size, sigma)
local r = math.floor(size / 2)
local output = {}
for y = 1, height do
output[y] = {}
for x = 1, width do
local sumR, sumG, sumB = 0, 0, 0
for ky = -r, r do
for kx = -r, r do
local px = clamp(x + kx, 1, width)
local py = clamp(y + ky, 1, height)
local pixel = image[py][px]
local w = kernel[ky + r + 1][kx + r + 1]
sumR = sumR + pixel[1] * w
sumG = sumG + pixel[2] * w
sumB = sumB + pixel[3] * w
end
end
output[y][x] = {sumR, sumG, sumB}
end
end
return output
end

local image = {}
for y = 1, 10 do
image[y] = {}
for x = 1, 10 do
image[y][x] = {math.random(0,255), math.random(0,255), math.random(0,255)}
end
end

local result = applyGaussianBlur(image, 10, 10, 5, 1.5)

return result
