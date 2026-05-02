local EffectConfig = {
AfterEffectsTag = "After Effects",
InShotEffect = {
Name = "WarpMagnify",
Parameters = {
WarpMagnify = 1.25
}
}
}

local function ApplyWarpMagnify(frame)
local intensity = EffectConfig.InShotEffect.Parameters.WarpMagnify
frame.scale = frame.scale * intensity
return frame
end

local function ProcessSequence(sequence)
local result = {}
for i = 1, #sequence do
result[i] = ApplyWarpMagnify(sequence[i])
end
return result
end

local function RunPipeline(inputSequence)
local outputSequence = ProcessSequence(inputSequence)
return outputSequence
end

return {
Config = EffectConfig,
Run = RunPipeline
}
