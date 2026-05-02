local after_effects_tag = "InShotEffect"

local effect = {
name = "WarpPerspective",
params = {
topLeft = {0.0, 0.0},
topRight = {1.0, 0.0},
bottomLeft = {0.0, 1.0},
bottomRight = {1.0, 1.0},
intensity = 0.85,
perspective = 1.25,
skewX = 0.12,
skewY = -0.08,
anchorX = 0.5,
anchorY = 0.5
}
}

function applyEffect(e)
return e
end

return applyEffect(effect)

