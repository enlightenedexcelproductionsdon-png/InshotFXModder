local effect = {}
effect.name = "LumiCornerPin"

effect.params = {
    topLeft = {x = 0.0, y = 0.0},
    topRight = {x = 1.0, y = 0.0},
    bottomLeft = {x = 0.0, y = 1.0},
    bottomRight = {x = 1.0, y = 1.0},
    luminance = 1.0,
    feather = 0.02
}

function effect.apply(frame, width, height)
    local output = {}
    for y = 0, height - 1 do
        output[y] = {}
        for x = 0, width - 1 do
            local u = x / width
            local v = y / height

            local tl = effect.params.topLeft
            local tr = effect.params.topRight
            local bl = effect.params.bottomLeft
            local br = effect.params.bottomRight

            local topX = tl.x + (tr.x - tl.x) * u
            local topY = tl.y + (tr.y - tl.y) * u
            local bottomX = bl.x + (br.x - bl.x) * u
            local bottomY = bl.y + (br.y - bl.y) * u

            local mapX = topX + (bottomX - topX) * v
            local mapY = topY + (bottomY - topY) * v

            local srcX = math.min(width - 1, math.max(0, math.floor(mapX * width)))
            local srcY = math.min(height - 1, math.max(0, math.floor(mapY * height)))

            local pixel = frame[srcY][srcX]

            local lum = (pixel.r + pixel.g + pixel.b) / 3
            local boost = 1 + (lum - 0.5) * effect.params.luminance

            local r = math.min(1, pixel.r * boost)
            local g = math.min(1, pixel.g * boost)
            local b = math.min(1, pixel.b * boost)

            local edgeU = math.min(u, 1 - u)
            local edgeV = math.min(v, 1 - v)
            local edge = math.min(edgeU, edgeV)

            local alpha = math.min(1, edge / effect.params.feather)

            output[y][x] = {
                r = r * alpha,
                g = g * alpha,
                b = b * alpha,
                a = pixel.a
            }
        end
    end
    return output
end

return effect
