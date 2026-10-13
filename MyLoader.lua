-- MyLoader.lua
-- Original, keyless Roblox loader UI starter.
-- Intended for your own Roblox experience in Roblox Studio.
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent duplicate interfaces if the LocalScript runs more than once.
local existing = playerGui:FindFirstChild("MyLoaderGui")
if existing then
    existing:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MyLoaderGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
background.BackgroundTransparency = 0.15
background.BorderSizePixel = 0
background.Parent = gui

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.5)
panel.Size = UDim2.fromOffset(360, 250)
panel.BackgroundColor3 = Color3.fromRGB(24, 27, 37)
panel.BorderSizePixel = 0
panel.Parent = background

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 14)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(75, 92, 130)
panelStroke.Transparency = 0.35
panelStroke.Thickness = 1
panelStroke.Parent = panel

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 18)
padding.PaddingBottom = UDim.new(0, 18)
padding.PaddingLeft = UDim.new(0, 20)
padding.PaddingRight = UDim.new(0, 20)
padding.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 34)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "MY LOADER"
title.TextColor3 = Color3.fromRGB(245, 247, 255)
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Position = UDim2.fromOffset(0, 38)
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Welcome. No key required."
subtitle.TextColor3 = Color3.fromRGB(165, 173, 195)
subtitle.TextSize = 13
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = panel

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Position = UDim2.fromOffset(0, 76)
status.Size = UDim2.new(1, 0, 0, 24)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(130, 220, 170)
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = panel

local progressBack = Instance.new("Frame")
progressBack.Name = "ProgressBack"
progressBack.Position = UDim2.fromOffset(0, 110)
progressBack.Size = UDim2.new(1, 0, 0, 7)
progressBack.BackgroundColor3 = Color3.fromRGB(43, 48, 64)
progressBack.BorderSizePixel = 0
progressBack.Parent = panel

local progressBackCorner = Instance.new("UICorner")
progressBackCorner.CornerRadius = UDim.new(1, 0)
progressBackCorner.Parent = progressBack

local progress = Instance.new("Frame")
progress.Name = "Progress"
progress.Size = UDim2.fromScale(0, 1)
progress.BackgroundColor3 = Color3.fromRGB(110, 150, 255)
progress.BorderSizePixel = 0
progress.Parent = progressBack

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(1, 0)
progressCorner.Parent = progress

local function makeButton(name, text, y, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = UDim2.fromOffset(0, y)
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Parent = panel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    return button
end

local launchButton = makeButton(
    "LaunchButton",
    "Launch",
    132,
    Color3.fromRGB(76, 105, 190)
)

local closeButton = makeButton(
    "CloseButton",
    "Close",
    178,
    Color3.fromRGB(49, 54, 69)
)

local busy = false

launchButton.Activated:Connect(function()
    if busy then
        return
    end
    busy = true
    launchButton.Active = false
    status.TextColor3 = Color3.fromRGB(165, 190, 255)
    status.Text = "Initializing..."
    progress.Size = UDim2.fromScale(0, 1)

    local tween = TweenService:Create(
        progress,
        TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = UDim2.fromScale(1, 1) }
    )
    tween:Play()
    tween.Completed:Wait()

    status.TextColor3 = Color3.fromRGB(130, 220, 170)
    status.Text = "Ready — add your own modules here."
    launchButton.Text = "Launched"
    launchButton.Active = true

    -- Add calls to modules you own below, for example:
    -- require(path.to.YourModule).Init()
end)

closeButton.Activated:Connect(function()
    gui:Destroy()
end)

-- Small entrance animation.
panel.Position = UDim2.fromScale(0.5, 0.54)
panel.BackgroundTransparency = 1
TweenService:Create(
    panel,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 0
    }
):Play()
