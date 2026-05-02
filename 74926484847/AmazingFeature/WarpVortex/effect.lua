local Effect = {}
Effect.__index = Effect

function Effect.new()
    local self = setmetatable({}, Effect)
    self.tag = "after_effects"
    self.name = "WarpVortex"
    self.platform = "InShot"
    self.parameters = {
        intensity = 0.85,
        radius = 1.25,
        twist = 2.75,
        speed = 1.10,
        centerX = 0.5,
        centerY = 0.5,
        falloff = 0.65,
        time = 0
    }
    return self
end

function Effect:update(dt)
    self.parameters.time = self.parameters.time + dt * self.parameters.speed
    self.parameters.twist = self.parameters.twist + math.sin(self.parameters.time) * 0.02
end

function Effect:apply(x, y)
    local dx = x - self.parameters.centerX
    local dy = y - self.parameters.centerY
    local dist = math.sqrt(dx * dx + dy * dy)
    local angle = math.atan2(dy, dx)
    local influence = (1 - math.min(dist / self.parameters.radius, 1)) ^ self.parameters.falloff
    local rotation = self.parameters.twist * influence * self.parameters.intensity

    local nx = self.parameters.centerX + math.cos(angle + rotation) * dist
    local ny = self.parameters.centerY + math.sin(angle + rotation) * dist

    return nx, ny
end

local WarpVortex = Effect.new()

return WarpVortex
