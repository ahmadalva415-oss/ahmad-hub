-- ahmad Hub | Ultimate Deluxe v3 | Multi Script | Parallax & Glow

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Remove old GUI
pcall(function()
    if player.PlayerGui:FindFirstChild("ahmadHub") then
        player.PlayerGui.ahmadHub:Destroy()
    end
end)

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ahmadHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 520, 0, 420)
main.Position = UDim2.new(0.25,0,0.22,0)
main.BackgroundTransparency = 1
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Animated Parallax Background
local backgrounds = {
    "https://i.imgur.com/7btEMvI.jpg",
    "https://i.imgur.com/2rTjFqh.jpg",
    "https://i.imgur.com/xU8qKkT.jpg",
}
local currentBG = 1

local bg = Instance.new("ImageLabel", main)
bg.Size = UDim2.new(1.2,0,1.2,0)
bg.Position = UDim2.new(-0.1,0,-0.1,0)
bg.BackgroundTransparency = 0
bg.Image = backgrounds[currentBG]
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 0

-- Overlay
local overlay = Instance.new("Frame", main)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency = 0.25
overlay.ZIndex = 1

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "✨ ahmad Hub | Ultimate Deluxe v3"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.ZIndex = 2

-- Title Glow
task.spawn(function()
    while gui.Parent do
        for i = 0,1,0.02 do
            title.TextColor3 = Color3.fromHSV(i,1,1)
            task.wait(0.02)
        end
    end
end)

-- Status
local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.new(0,10,0.9,0)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.ZIndex = 2

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(150,40,40)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.BorderSizePixel = 0
close.ZIndex = 2

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Button creator
local function createScriptButton(text, posY, url, color, custom)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0, 320, 0, 50)
    btn.Position = UDim2.new(0.1,0,posY,0)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 22
    btn.BorderSizePixel = 0
    btn.ZIndex = 2

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromHSV(math.random(),0.8,1)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color
    end)

    btn.MouseButton1Click:Connect(function()
        status.Text = "Loading " .. text .. "..."
        task.wait(0.3)
        pcall(function()
            if custom then
                custom()
            else
                loadstring(game:HttpGet(url))()
            end
        end)
        status.Text = text .. " Loaded ✅"
    end)
end

-- Scripts
createScriptButton(
    "🚀 Redz Hub",
    0.22,
    "https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua",
    Color3.fromRGB(255,0,0)
)

createScriptButton(
    "🌌 Gravity Hub",
    0.36,
    "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua",
    Color3.fromRGB(0,255,0)
)

createScriptButton(
    "💎 Blue Hub",
    0.50,
    "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua",
    Color3.fromRGB(0,120,255)
)

-- Aim Bot (Hermanos Hub - PVP)
createScriptButton(
    "🎯 Aim Bot",
    0.64,
    nil,
    Color3.fromRGB(255,180,0),
    function()
        getgenv().script_mode = "PVP"
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/Loader.lua"
        ))()
    end
)

-- Background switch
task.spawn(function()
    while gui.Parent do
        task.wait(5)
        currentBG += 1
        if currentBG > #backgrounds then
            currentBG = 1
        end
        bg.Image = backgrounds[currentBG]
    end
end)

-- Parallax effect
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local cam = workspace.CurrentCamera.ViewportSize
        local x = (input.Position.X / cam.X - 0.5) * 20
        local y = (input.Position.Y / cam.Y - 0.5) * 20
        bg.Position = UDim2.new(-0.1, x, -0.1, y)
    end
end)
