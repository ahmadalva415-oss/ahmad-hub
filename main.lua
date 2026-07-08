-- ══════════════════════════════════════
--   LRT CAR PATROL - Neon UI Edition
--   Game: 96796259580891
--   Compatible: Delta Mobile / PC
-- ══════════════════════════════════════

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ══════════════════════════════════════
--   GAME CHECK - يشتغل على هذا الماب فقط
-- ══════════════════════════════════════

local ALLOWED_GAME_ID = 96796259580891
local CURRENT_GAME_ID = game.PlaceId

if CURRENT_GAME_ID ~= ALLOWED_GAME_ID then
	local errorGui = Instance.new("ScreenGui")
	errorGui.Name = "LRT_Error"
	errorGui.Parent = CoreGui
	
	local errorFrame = Instance.new("Frame")
	errorFrame.Size = UDim2.new(0, 300, 0, 100)
	errorFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
	errorFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
	errorFrame.BorderSizePixel = 0
	errorFrame.Parent = errorGui
	
	Instance.new("UICorner", errorFrame).CornerRadius = UDim.new(0, 12)
	
	local errorStroke = Instance.new("UIStroke", errorFrame)
	errorStroke.Color = Color3.fromRGB(255, 50, 50)
	errorStroke.Thickness = 2
	
	local errorText = Instance.new("TextLabel")
	errorText.Size = UDim2.new(1, -20, 1, -20)
	errorText.Position = UDim2.new(0, 10, 0, 10)
	errorText.BackgroundTransparency = 1
	errorText.Text = "هذا السكربت لا يعمل على هذا الماب\nThis script doesn't work on this game"
	errorText.TextColor3 = Color3.fromRGB(255, 100, 100)
	errorText.TextSize = 16
	errorText.Font = Enum.Font.GothamBold
	errorText.TextWrapped = true
	errorText.Parent = errorFrame
	
	task.delay(3, function()
		errorGui:Destroy()
	end)
	
	return
end

-- ══════════════════════════════════════
--   LANGUAGE SETTINGS
-- ══════════════════════════════════════

local Lang = "AR" -- "AR" for Arabic, "EN" for English

local Texts = {
	AR = {
		welcome = "منور يا ",
		discord = "نورنا في سيرفر ديسكورد",
		server = "LRT",
		skip = "اضغط للمتابعة",
		title = "LRT PATROL",
		patrolOff = "PATROL: OFF",
		patrolOn = "PATROL: ON",
		maxSpeed = "Max Speed: ",
		accel = "Acceleration: ",
		height = "Height: ",
		distance = "Distance: ",
		stop = "STOP",
		slow = "Slow",
		normal = "Normal",
		fast = "Fast",
		getInCar = "اركب سيارة اولاً!",
		started = "Patrol STARTED",
		stopped = "Patrol STOPPED!"
	},
	EN = {
		welcome = "Welcome ",
		discord = "Join our Discord Server",
		server = "LRT",
		skip = "Click to Continue",
		title = "LRT PATROL",
		patrolOff = "PATROL: OFF",
		patrolOn = "PATROL: ON",
		maxSpeed = "Max Speed: ",
		accel = "Acceleration: ",
		height = "Height: ",
		distance = "Distance: ",
		stop = "STOP",
		slow = "Slow",
		normal = "Normal",
		fast = "Fast",
		getInCar = "Get in a car first!",
		started = "Patrol STARTED",
		stopped = "Patrol STOPPED!"
	}
}

local T = Texts[Lang]

-- ══════════════════════════════════════
--   WELCOME SCREEN
-- ══════════════════════════════════════

local function createWelcomeScreen()
	local welcomeGui = Instance.new("ScreenGui")
	welcomeGui.Name = "LRT_Welcome"
	welcomeGui.ResetOnSpawn = false
	welcomeGui.DisplayOrder = 999999
	welcomeGui.Parent = CoreGui

	local bg = Instance.new("Frame")
	bg.Name = "Background"
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
	bg.BorderSizePixel = 0
	bg.Parent = welcomeGui

	local particlesFrame = Instance.new("Frame")
	particlesFrame.Name = "Particles"
	particlesFrame.Size = UDim2.new(1, 0, 1, 0)
	particlesFrame.BackgroundTransparency = 1
	particlesFrame.Parent = bg

	for i = 1, 50 do
		local particle = Instance.new("Frame")
		particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
		particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
		particle.BackgroundColor3 = Color3.fromRGB(
			math.random(100, 255),
			math.random(100, 255),
			math.random(150, 255)
		)
		particle.BackgroundTransparency = math.random(3, 8) / 10
		particle.BorderSizePixel = 0
		particle.Parent = particlesFrame
		
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = particle

		task.spawn(function()
			while particle and particle.Parent do
				local tween = TweenService:Create(particle, TweenInfo.new(
					math.random(3, 8),
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				), {
					Position = UDim2.new(math.random(), 0, math.random(), 0),
					BackgroundTransparency = math.random(3, 8) / 10
				})
				tween:Play()
				tween.Completed:Wait()
			end
		end)
	end

	local topLine = Instance.new("Frame")
	topLine.Name = "TopLine"
	topLine.Size = UDim2.new(0, 0, 0, 2)
	topLine.Position = UDim2.new(0.5, 0, 0.3, -50)
	topLine.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
	topLine.BorderSizePixel = 0
	topLine.Parent = bg

	local bottomLine = Instance.new("Frame")
	bottomLine.Name = "BottomLine"
	bottomLine.Size = UDim2.new(0, 0, 0, 2)
	bottomLine.Position = UDim2.new(0.5, 0, 0.3, 50)
	bottomLine.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
	bottomLine.BorderSizePixel = 0
	bottomLine.Parent = bg

	local welcomeText = Instance.new("TextLabel")
	welcomeText.Name = "WelcomeText"
	welcomeText.Size = UDim2.new(1, 0, 0, 80)
	welcomeText.Position = UDim2.new(0, 0, 0.3, -40)
	welcomeText.BackgroundTransparency = 1
	welcomeText.Text = T.welcome .. LocalPlayer.DisplayName
	welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
	welcomeText.TextSize = 52
	welcomeText.Font = Enum.Font.GothamBlack
	welcomeText.TextStrokeTransparency = 0.8
	welcomeText.TextStrokeColor3 = Color3.fromRGB(0, 200, 255)
	welcomeText.Parent = bg

	local discordText = Instance.new("TextLabel")
	discordText.Name = "DiscordText"
	discordText.Size = UDim2.new(1, 0, 0, 50)
	discordText.Position = UDim2.new(0, 0, 0.5, -25)
	discordText.BackgroundTransparency = 1
	discordText.Text = T.discord
	discordText.TextColor3 = Color3.fromRGB(200, 200, 255)
	discordText.TextSize = 28
	discordText.Font = Enum.Font.GothamBold
	discordText.Parent = bg

	local serverText = Instance.new("TextLabel")
	serverText.Name = "ServerText"
	serverText.Size = UDim2.new(1, 0, 0, 60)
	serverText.Position = UDim2.new(0, 0, 0.5, 20)
	serverText.BackgroundTransparency = 1
	serverText.Text = T.server
	serverText.TextColor3 = Color3.fromRGB(0, 200, 255)
	serverText.TextSize = 64
	serverText.Font = Enum.Font.GothamBlack
	serverText.TextStrokeTransparency = 0.6
	serverText.TextStrokeColor3 = Color3.fromRGB(255, 50, 150)
	serverText.Parent = bg

	local glowFrame = Instance.new("Frame")
	glowFrame.Name = "Glow"
	glowFrame.Size = UDim2.new(0, 200, 0, 80)
	glowFrame.Position = UDim2.new(0.5, -100, 0.5, 10)
	glowFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
	glowFrame.BackgroundTransparency = 0.9
	glowFrame.BorderSizePixel = 0
	glowFrame.Parent = bg
	
	local glowCorner = Instance.new("UICorner")
	glowCorner.CornerRadius = UDim.new(0, 20)
	glowCorner.Parent = glowFrame

	local skipBtn = Instance.new("TextButton")
	skipBtn.Name = "SkipButton"
	skipBtn.Size = UDim2.new(0, 180, 0, 45)
	skipBtn.Position = UDim2.new(0.5, -90, 0.7, 0)
	skipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	skipBtn.Text = T.skip
	skipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	skipBtn.TextSize = 16
	skipBtn.Font = Enum.Font.GothamBold
	skipBtn.BorderSizePixel = 0
	skipBtn.Parent = bg

	local skipCorner = Instance.new("UICorner")
	skipCorner.CornerRadius = UDim.new(0, 10)
	skipCorner.Parent = skipBtn

	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(0, 200, 255)
	btnStroke.Thickness = 2
	btnStroke.Parent = skipBtn

	TweenService:Create(topLine, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.6, 0, 0, 2),
		Position = UDim2.new(0.2, 0, 0.3, -50)
	}):Play()

	TweenService:Create(bottomLine, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.6, 0, 0, 2),
		Position = UDim2.new(0.2, 0, 0.3, 50)
	}):Play()

	welcomeText.TextTransparency = 1
	discordText.TextTransparency = 1
	serverText.TextTransparency = 1
	skipBtn.BackgroundTransparency = 1
	skipBtn.TextTransparency = 1
	btnStroke.Transparency = 1

	TweenService:Create(welcomeText, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()

	task.delay(0.4, function()
		TweenService:Create(discordText, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0
		}):Play()
	end)

	task.delay(0.8, function()
		TweenService:Create(serverText, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			TextTransparency = 0
		}):Play()
	end)

	task.delay(1.5, function()
		TweenService:Create(skipBtn, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0,
			TextTransparency = 0
		}):Play()
		TweenService:Create(btnStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
	end)

	task.spawn(function()
		while serverText and serverText.Parent do
			local pulse = TweenService:Create(serverText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				TextSize = 68
			})
			pulse:Play()
			pulse.Completed:Wait()
			
			local pulseBack = TweenService:Create(serverText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				TextSize = 64
			})
			pulseBack:Play()
			pulseBack.Completed:Wait()
		end
	end)

	task.spawn(function()
		while glowFrame and glowFrame.Parent do
			local glowIn = TweenService:Create(glowFrame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				BackgroundTransparency = 0.7,
				Size = UDim2.new(0, 220, 0, 90)
			})
			glowIn:Play()
			glowIn.Completed:Wait()
			
			local glowOut = TweenService:Create(glowFrame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				BackgroundTransparency = 0.95,
				Size = UDim2.new(0, 200, 0, 80)
			})
			glowOut:Play()
			glowOut.Completed:Wait()
		end
	end)

	local function hideWelcome()
		local fadeOut = TweenService:Create(bg, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		})
		fadeOut:Play()
		
		for _, child in ipairs(bg:GetDescendants()) do
			if child:IsA("TextLabel") or child:IsA("TextButton") then
				TweenService:Create(child, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
			elseif child:IsA("Frame") and child.Name ~= "Background" then
				TweenService:Create(child, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
			end
		end
		
		fadeOut.Completed:Wait()
		welcomeGui:Destroy()
	end

	skipBtn.MouseButton1Click:Connect(hideWelcome)

	task.delay(6, function()
		if welcomeGui and welcomeGui.Parent then
			hideWelcome()
		end
	end)
end

pcall(createWelcomeScreen)

-- ══════════════════════════════════════
--   MAIN GUI - Dark Theme
-- ══════════════════════════════════════

local SG = Instance.new("ScreenGui")
SG.Name = "LRT_CarAccel"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = CoreGui

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -27)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ToggleBtn.Text = "LRT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 170, 0)
ToggleBtn.TextSize = 16
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.Parent = SG

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 14)

local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Color = Color3.fromRGB(255, 170, 0)
TStroke.Thickness = 2

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 260, 0, 340)
Panel.Position = UDim2.new(0, 72, 0.5, -170)
Panel.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
Panel.BorderSizePixel = 0
Panel.Visible = false
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SG

Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 12)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Panel

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleFix = Instance.new("Frame", TitleBar)
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "  " .. T.title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = TitleBar

-- Minimize Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -36, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
CloseBtn.Text = "-"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -16, 1, -48)
Content.Position = UDim2.new(0, 8, 0, 44)
Content.BackgroundTransparency = 1
Content.Parent = Panel

-- Main Toggle Button (Full Width - Red)
local PatrolBtn = Instance.new("TextButton")
PatrolBtn.Size = UDim2.new(1, 0, 0, 42)
PatrolBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
PatrolBtn.Text = T.patrolOff
PatrolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PatrolBtn.TextSize = 14
PatrolBtn.Font = Enum.Font.GothamBold
PatrolBtn.Parent = Content
Instance.new("UICorner", PatrolBtn).CornerRadius = UDim.new(0, 8)

-- Info Row
local InfoRow = Instance.new("Frame")
InfoRow.Size = UDim2.new(1, 0, 0, 28)
InfoRow.Position = UDim2.new(0, 0, 0, 50)
InfoRow.BackgroundTransparency = 1
InfoRow.Parent = Content

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = T.maxSpeed .. "160"
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = InfoRow

local SpeedValue = Instance.new("TextButton")
SpeedValue.Size = UDim2.new(0, 60, 1, 0)
SpeedValue.Position = UDim2.new(1, -60, 0, 0)
SpeedValue.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SpeedValue.Text = "160"
SpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedValue.TextSize = 14
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.Parent = InfoRow
Instance.new("UICorner", SpeedValue).CornerRadius = UDim.new(0, 6)

-- Row Maker
function MakeRow(parent, yPos)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 34)
	row.Position = UDim2.new(0, 0, 0, yPos)
	row.BackgroundTransparency = 1
	row.Parent = parent
	
	local layout = Instance.new("UIListLayout", row)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.Padding = UDim.new(0, 6)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	
	return row
end

function MakeSmallBtn(parent, text, color, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.3, 0, 1, 0)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.TextSize = 12
	b.Font = Enum.Font.GothamBold
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	
	b.MouseButton1Click:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.08), {Size = UDim2.new(0.28, 0, 0.9, 0)}):Play()
		wait(0.08)
		TweenService:Create(b, TweenInfo.new(0.08), {Size = UDim2.new(0.3, 0, 1, 0)}):Play()
		callback()
	end)
	return b
end

-- Speed Row
local Row1 = MakeRow(Content, 86)
MakeSmallBtn(Row1, "100", Color3.fromRGB(50, 50, 70), function()
	MaxSpeed = 100
	SpeedLabel.Text = T.maxSpeed .. "100"
	SpeedValue.Text = "100"
	print("Max: 100")
end)
MakeSmallBtn(Row1, "160", Color3.fromRGB(50, 50, 70), function()
	MaxSpeed = 160
	SpeedLabel.Text = T.maxSpeed .. "160"
	SpeedValue.Text = "160"
	print("Max: 160")
end)
MakeSmallBtn(Row1, "200", Color3.fromRGB(50, 50, 70), function()
	MaxSpeed = 200
	SpeedLabel.Text = T.maxSpeed .. "200"
	SpeedValue.Text = "200"
	print("Max: 200")
end)

-- Accel Label
local AccelLabel = Instance.new("TextLabel")
AccelLabel.Size = UDim2.new(1, 0, 0, 20)
AccelLabel.Position = UDim2.new(0, 0, 0, 126)
AccelLabel.BackgroundTransparency = 1
AccelLabel.Text = T.accel .. T.normal
AccelLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
AccelLabel.TextSize = 13
AccelLabel.Font = Enum.Font.Gotham
AccelLabel.TextXAlignment = Enum.TextXAlignment.Left
AccelLabel.Parent = Content

-- Accel Row
local Row2 = MakeRow(Content, 148)
MakeSmallBtn(Row2, T.slow, Color3.fromRGB(50, 50, 70), function()
	Acceleration = 1
	AccelLabel.Text = T.accel .. T.slow
	print("Accel: 1")
end)
MakeSmallBtn(Row2, T.normal, Color3.fromRGB(50, 50, 70), function()
	Acceleration = 2
	AccelLabel.Text = T.accel .. T.normal
	print("Accel: 2")
end)
MakeSmallBtn(Row2, T.fast, Color3.fromRGB(50, 50, 70), function()
	Acceleration = 5
	AccelLabel.Text = T.accel .. T.fast
	print("Accel: 5")
end)

-- Height Label
local HeightLabel = Instance.new("TextLabel")
HeightLabel.Size = UDim2.new(1, 0, 0, 20)
HeightLabel.Position = UDim2.new(0, 0, 0, 188)
HeightLabel.BackgroundTransparency = 1
HeightLabel.Text = T.height .. "15"
HeightLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
HeightLabel.TextSize = 13
HeightLabel.Font = Enum.Font.Gotham
HeightLabel.TextXAlignment = Enum.TextXAlignment.Left
HeightLabel.Parent = Content

-- Height Row (2 buttons only)
local Row3 = Instance.new("Frame")
Row3.Size = UDim2.new(1, 0, 0, 34)
Row3.Position = UDim2.new(0, 0, 0, 210)
Row3.BackgroundTransparency = 1
Row3.Parent = Content

local Row3Layout = Instance.new("UIListLayout", Row3)
Row3Layout.FillDirection = Enum.FillDirection.Horizontal
Row3Layout.Padding = UDim.new(0, 6)
Row3Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Row3Layout.VerticalAlignment = Enum.VerticalAlignment.Center

function MakeHalfBtn(parent, text, color, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.47, 0, 1, 0)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.TextSize = 12
	b.Font = Enum.Font.GothamBold
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	
	b.MouseButton1Click:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.08), {Size = UDim2.new(0.45, 0, 0.9, 0)}):Play()
		wait(0.08)
		TweenService:Create(b, TweenInfo.new(0.08), {Size = UDim2.new(0.47, 0, 1, 0)}):Play()
		callback()
	end)
	return b
end

MakeHalfBtn(Row3, "H: 10", Color3.fromRGB(50, 50, 70), function()
	TargetHeight = 10
	HeightLabel.Text = T.height .. "10"
	print("Height: 10")
end)
MakeHalfBtn(Row3, "H: 20", Color3.fromRGB(50, 50, 70), function()
	TargetHeight = 20
	HeightLabel.Text = T.height .. "20"
	print("Height: 20")
end)

-- Distance Input Row (Editable)
local DistRow = Instance.new("Frame")
DistRow.Size = UDim2.new(1, 0, 0, 34)
DistRow.Position = UDim2.new(0, 0, 0, 252)
DistRow.BackgroundTransparency = 1
DistRow.Parent = Content

local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(0.45, 0, 1, 0)
DistLabel.BackgroundTransparency = 1
DistLabel.Text = T.distance
DistLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
DistLabel.TextSize = 14
DistLabel.Font = Enum.Font.Gotham
DistLabel.TextXAlignment = Enum.TextXAlignment.Left
DistLabel.Parent = DistRow

local DistInput = Instance.new("TextBox")
DistInput.Size = UDim2.new(0.5, 0, 1, 0)
DistInput.Position = UDim2.new(0.5, 0, 0, 0)
DistInput.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
DistInput.Text = "1000"
DistInpu
