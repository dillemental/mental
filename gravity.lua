local function createArgs(ability, eventType)
    return {
        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements.Gravity[ability],
        [2] = {
            ["Direction"] = Vector3.new(0.5, -0.45, 0.73),
            ["Position"] = Vector3.new(-655, 62, -1638),
            ["Origin"] = Vector3.new(-667, 73, -1657)
        },
        [3] = eventType
    }
end

local args = {
    {"Push", "Start"},
    {"Push", "End"},
    {"Pull", "Start"},
    {"Pull", "End"},
    {"Meteor", "Start"},
    {"Meteor", "End"},
    {"GravityZone", "Start"},
    {"GravityZone", "End"},
    {"MeteorBarrage", "Start"},
    {"MeteorBarrage", "End"}
}

local remoteEvent = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent ")

while true do
    for _, arg in ipairs(args) do
        remoteEvent:FireServer(unpack(createArgs(arg[1], arg[2])))
        wait(0.2)
    end
wait(3)
end
