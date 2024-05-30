local function createArgs(ability, eventType, targetPosition)
    return {
        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements.Gravity[ability],
        [2] = {
            ["Direction"] = (targetPosition - lp.Character.HumanoidRootPart.Position).unit,
            ["Position"] = targetPosition,
            ["Origin"] = lp.Character.HumanoidRootPart.Position
        },
        [3] = eventType
    }
end

local function getNPC()
    local dist, target = math.huge
    for _, mob in pairs(game.Workspace.Mobs:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
            local humanoid = mob.Humanoid
            if humanoid.Health > 0 then
                local mag = (lp.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                if mag < dist then
                    dist = mag
                    target = mob
                end
            end
        end
    end
    return target
end

local abilities = {
    {"Push", "Start"},
    {"Push", "End"},
    {"Pull", "Start"},
    {"Pull", "End"},
    {"Meteor", "Start"},
    {"Meteor", "End"},
    {"GravityZone", "Start"},
    {"MeteorBarrage", "Start"}
}

while true do
    wait(1)
    local npc = getNPC()
    if npc then
        for _, ability in ipairs(abilities) do
            local abilityArgs = createArgs(ability[1], ability[2], npc.HumanoidRootPart.Position)
            remoteEvent:FireServer(unpack(abilityArgs))
            wait(0.1)
        end
    end
end
