-- MyLoader.lua
-- Original keyless Roblox loader UI starter for your own Roblox experience.
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("MyLoaderGui")
if existing then
    existing:Destroy()
end

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function addLabel(parent, name, text, size, position, fontSize, color, font)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Font = font or Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(235, 238, 248)
    label.TextSize = fontSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local gui = Instance.new("ScreenGui")
gui.Name = "MyLoaderGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Parent = playerGui

-- Main dimmer and loader window
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(7, 9, 15)
background.BackgroundTransparency = 0.22
background.BorderSizePixel = 0
background.Parent = gui

local panel = Instance.new("Frame")
panel.Name = "LoaderPanel"
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.54)
panel.Size = UDim2.fromOffset(360, 250)
panel.BackgroundColor3 = Color3.fromRGB(24, 27, 37)
panel.BorderSizePixel = 0
panel.Parent = background
addCorner(panel, 14)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(75, 92, 130)
panelStroke.Transparency = 0.35
panelStroke.Thickness = 1
panelStroke.Parent = panel

addLabel(panel, "Title", "MY LOADER", UDim2.new(1, -40, 0, 34),
    UDim2.fromOffset(20, 18), 24, Color3.fromRGB(245, 247, 255), Enum.Font.GothamBold)
addLabel(panel, "Subtitle", "Welcome", UDim2.new(1, -40, 0, 24),
    UDim2.fromOffset(20, 56), 13, Color3.fromRGB(165, 173, 195))

local status = addLabel(panel, "Status", "Ready to launch", UDim2.new(1, -40, 0, 24),
    UDim2.fromOffset(20, 88), 14, Color3.fromRGB(130, 220, 170), Enum.Font.GothamMedium)

local progressBack = Instance.new("Frame")
progressBack.Name = "ProgressBack"
progressBack.Position = UDim2.fromOffset(20, 120)
progressBack.Size = UDim2.new(1, -40, 0, 7)
progressBack.BackgroundColor3 = Color3.fromRGB(43, 48, 64)
progressBack.BorderSizePixel = 0
progressBack.Parent = panel
addCorner(progressBack, 6)

local progress = Instance.new("Frame")
progress.Name = "Progress"
progress.Size = UDim2.fromScale(0, 1)
progress.BackgroundColor3 = Color3.fromRGB(110, 150, 255)
progress.BorderSizePixel = 0
progress.Parent = progressBack
addCorner(progress, 6)

local function makeButton(parent, name, text, position, size, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = position
    button.Size = size
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Parent = parent
    addCorner(button, 8)
    return button
end

local launchButton = makeButton(panel, "LaunchButton", "Launch",
    UDim2.fromOffset(20, 148), UDim2.new(1, -40, 0, 38), Color3.fromRGB(76, 105, 190))
local closeButton = makeButton(panel, "CloseButton", "Close",
    UDim2.fromOffset(20, 194), UDim2.new(1, -40, 0, 34), Color3.fromRGB(49, 54, 69))

-- Main menu appears after Launch.
local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.AnchorPoint = Vector2.new(0.5, 0.5)
menu.Position = UDim2.fromScale(0.5, 0.5)
menu.Size = UDim2.fromOffset(390, 310)
menu.BackgroundColor3 = Color3.fromRGB(24, 27, 37)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Parent = background
addCorner(menu, 14)

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(75, 92, 130)
menuStroke.Transparency = 0.35
menuStroke.Thickness = 1
menuStroke.Parent = menu

addLabel(menu, "MenuTitle", "MY LOADER  /  MENU", UDim2.new(1, -70, 0, 32),
    UDim2.fromOffset(18, 16), 19, Color3.fromRGB(245, 247, 255), Enum.Font.GothamBold)

local menuClose = makeButton(menu, "MenuClose", "X",
    UDim2.new(1, -48, 0, 14), UDim2.fromOffset(30, 30), Color3.fromRGB(75, 48, 58))
local menuStatus = addLabel(menu, "MenuStatus", "Loader started successfully.",
    UDim2.new(1, -36, 0, 24), UDim2.fromOffset(18, 55), 13, Color3.fromRGB(165, 173, 195))

local divider = Instance.new("Frame")
divider.Position = UDim2.fromOffset(18, 86)
divider.Size = UDim2.new(1, -36, 0, 1)
divider.BackgroundColor3 = Color3.fromRGB(60, 66, 84)
divider.BorderSizePixel = 0
divider.Parent = menu

addLabel(menu, "FeaturesHeading", "FEATURES", UDim2.new(1, -36, 0, 22),
    UDim2.fromOffset(18, 101), 12, Color3.fromRGB(150, 170, 220), Enum.Font.GothamBold)

local featureToggle = makeButton(menu, "FeatureToggle", "Example option: OFF",
    UDim2.fromOffset(18, 132), UDim2.new(1, -36, 0, 40), Color3.fromRGB(43, 49, 66))
local settingsButton = makeButton(menu, "SettingsButton", "Settings",
    UDim2.fromOffset(18, 182), UDim2.new(1, -36, 0, 38), Color3.fromRGB(55, 67, 100))
local hideButton = makeButton(menu, "HideButton", "Hide menu",
    UDim2.fromOffset(18, 230), UDim2.new(1, -36, 0, 34), Color3.fromRGB(49, 54, 69))

local featureEnabled = false
featureToggle.Activated:Connect(function()
    featureEnabled = not featureEnabled
    featureToggle.Text = "Example option: " .. (featureEnabled and "ON" or "OFF")
    featureToggle.BackgroundColor3 = featureEnabled
        and Color3.fromRGB(45, 112, 82)
        or Color3.fromRGB(43, 49, 66)
    -- Replace this example toggle with a feature from your own game.
end)

settingsButton.Activated:Connect(function()
    menuStatus.Text = "Settings menu is a placeholder. Add your own settings here."
end)

hideButton.Activated:Connect(function()
    menu.Visible = false
end)

menuClose.Activated:Connect(function()
    menu.Visible = false
end)

local busy = false
launchButton.Activated:Connect(function()
    if busy then
        return
    end
    busy = true
    launchButton.Active = false
    status.TextColor3 = Color3.fromRGB(165, 190, 255)
    status.Text = "Starting..."
    progress.Size = UDim2.fromScale(0, 1)

    local tween = TweenService:Create(
        progress,
        TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = UDim2.fromScale(1, 1) }
    )
    tween:Play()
    tween.Completed:Wait()

    panel.Visible = false
    menu.Visible = true
    busy = false
end)

closeButton.Activated:Connect(function()
    gui:Destroy()
end)

TweenService:Create(
    panel,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Position = UDim2.fromScale(0.5, 0.5) }
):Play()
