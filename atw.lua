local lp = game.Players.LocalPlayer

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

local TweenService = game:GetService("TweenService")
local noclipE = nil
local antifall = nil

local function noclip()
    for _, part in pairs(lp.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
            lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

local function moveto(obj, speed, distance)
    local destination = obj.Position - (obj.Position - lp.Character.HumanoidRootPart.Position).unit * distance
    local info = TweenInfo.new(((lp.Character.HumanoidRootPart.Position - destination).Magnitude) / speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(lp.Character.HumanoidRootPart, info, { CFrame = CFrame.new(destination) })

    if not lp.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        antifall = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        antifall.Velocity = Vector3.new(0, 0, 0)
        noclipE = game:GetService("RunService").Stepped:Connect(noclip)
        tween:Play()
    end

    tween.Completed:Connect(function()
        antifall:Destroy()
        noclipE:Disconnect()
    end)
end

local function rotateTowards(target)
    local playerPosition = lp.Character.HumanoidRootPart.Position
    local direction = (target.Position - playerPosition).unit
    local lookVector = Vector3.new(direction.X, 0, direction.Z)
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(playerPosition, playerPosition + lookVector)
end

getgenv().bandit = true
while bandit do
    task.wait()
    pcall(function()
        local npc = getNPC()
        if npc then
            rotateTowards(npc.HumanoidRootPart)
            moveto(npc.HumanoidRootPart, 38, 5) -- Adjust the distance as needed
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
        end
    end)
end
