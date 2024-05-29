local player = game.Players.LocalPlayer
local checkInterval = 30
local maxDistance = 2
local function checkPlayerMovement()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local currentPosition = character.PrimaryPart.Position
            wait(checkInterval)
            local newPosition = character.PrimaryPart.Position
            local distance = (newPosition - currentPosition).magnitude
            if distance < maxDistance then
                humanoid.Health = 0
            end
        end
    end
end

while true do
    checkPlayerMovement()
end
