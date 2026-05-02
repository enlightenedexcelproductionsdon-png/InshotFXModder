local effect = {
    name = "LumiSShake",
    intensity = 0.85,
    speed = 1.2,
    amplitude = 15,
    frequency = 0.25,
    decay = 0.98,
    duration = 3.5
}

local time = 0
local function applyShake(dt)
    time = time + dt * effect.speed
    local shakeX = math.sin(time * (1 / effect.frequency)) * effect.amplitude * effect.intensity
    local shakeY = math.cos(time * (1 / effect.frequency)) * effect.amplitude * effect.intensity
    effect.amplitude = effect.amplitude * effect.decay
    return shakeX, shakeY
end

local function runEffect()
    local dt = 0.016
    local elapsed = 0
    while elapsed < effect.duration do
        local x, y = applyShake(dt)
        elapsed = elapsed + dt
    end
end

runEffect()
