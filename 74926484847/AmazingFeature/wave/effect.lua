local effect = {
    app = "InShot",
    type = "Wave",
    parameters = {
        amplitude = 25,
        frequency = 8,
        speed = 1.2,
        phase = 0,
        direction = "horizontal"
    }
}

local function applyWave(frame, t)
    local result = {}
    for y = 1, #frame do
        result[y] = {}
        for x = 1, #frame[y] do
            local offset = math.floor(effect.parameters.amplitude * math.sin(effect.parameters.frequency * (x / #frame[y]) + effect.parameters.speed * t + effect.parameters.phase))
            local newY = y + offset
            if newY < 1 then newY = 1 end
            if newY > #frame then newY = #frame end
            result[y][x] = frame[newY][x]
        end
    end
    return result
end

local function process(frames, duration, fps)
    local processed = {}
    for i = 1, #frames do
        local t = (i / fps)
        processed[i] = applyWave(frames[i], t)
    end
    return processed
end

return {
    tag = "after_effects",
    effect = effect,
    process = process
}
