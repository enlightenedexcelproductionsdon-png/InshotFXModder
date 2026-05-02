local effect = {}

effect.name = "OpticsCompensation"
effect.version = "1.0"

function effect.apply(frame, params)
    local width = frame.width
    local height = frame.height
    local cx = width / 2
    local cy = height / 2

    local strength = params.strength or 0.5
    local zoom = params.zoom or 1.0

    local newFrame = frame:createEmpty()

    for y = 0, height - 1 do
        for x = 0, width - 1 do
            local nx = (x - cx) / cx
            local ny = (y - cy) / cy

            local r = math.sqrt(nx * nx + ny * ny)
            local factor = 1 + strength * (r * r)

            local srcX = cx + nx * factor * cx / zoom
            local srcY = cy + ny * factor * cy / zoom

            local pixel = frame:getPixel(srcX, srcY)
            newFrame:setPixel(x, y, pixel)
        end
    end

    return newFrame
end

return effect
