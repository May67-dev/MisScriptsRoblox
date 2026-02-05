-- Loader.lua - Script Hub OP by Grok (para tu juego o cualquier Roblox)
-- Pega esto en GitHub raw y carga con loadstring(game:HttpGet("TU_RAW_URL"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Crea GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrokHub"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Title.Text = "Grok Script Hub 🚀"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Title

-- ScrollFrame para toggles
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -50)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.Parent = Frame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim2.new(0, 5)
ListLayout.Parent = ScrollFrame

-- Variables de cheats
local FlyEnabled = false
local SpeedEnabled = false
local NoclipEnabled = false
local ESPEnabled = false

-- Funciones de cheats
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ScrollFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextScaled = true
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame

    local toggled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        ToggleBtn.Text = toggled and "ON" or "OFF"
        callback(toggled)
    end)
end

-- Fly
local BodyVelocity, BodyGyro
CreateToggle("Fly", function(toggled)
    FlyEnabled = toggled
    if toggled then
        local char = Player.Character or Player.CharacterAdded:Wait()
        local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.Parent = humanoidRootPart
        BodyGyro = Instance.new("BodyGyro")
        BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        BodyGyro.CFrame = humanoidRootPart.CFrame
        BodyGyro.Parent = humanoidRootPart
        RunService.Heartbeat:Connect(function()
            if FlyEnabled and BodyVelocity and BodyGyro then
                local move = humanoidRootPart.CFrame:VectorToWorldSpace(Vector3.new(0,0,0))
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0,0,-1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0,0,1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1,0,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1,0,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
                BodyVelocity.Velocity = (Camera.CFrame.LookVector * 50 + move * 50)
                BodyGyro.CFrame = Camera.CFrame
            end
        end)
    else
        if BodyVelocity then BodyVelocity:Destroy() end
        if BodyGyro then BodyGyro:Destroy() end
    end
end)

-- Speed
CreateToggle("Speed x16", function(toggled)
    SpeedEnabled = toggled
    local char = Player.Character or Player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = toggled and 100 or 16
end)

-- Noclip
local NoclipConnection
CreateToggle("Noclip", function(toggled)
    NoclipEnabled = toggled
    if toggled then
        NoclipConnection = RunService.Stepped:Connect(function()
            local char = Player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
        local char = Player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- ESP (para players)
CreateToggle("Player ESP", function(toggled)
    ESPEnabled = toggled
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            if toggled then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = plr.Character
            else
                local highlight = plr.Character:FindFirstChildOfClass("Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            if ESPEnabled then
                wait(1)
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = plr.Character
            end
        end)
    end)
end)

-- Botón Infinite Yield (admin OP)
local IYBtn = Instance.new("TextButton")
IYBtn.Size = UDim2.new(1, -10, 0, 35)
IYBtn.Position = UDim2.new(0, 5, 1, -40)
IYBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
IYBtn.Text = "Infinite Yield (Admin)"
IYBtn.TextColor3 = Color3.new(1,1,1)
IYBtn.Font = Enum.Font.GothamBold
IYBtn.TextScaled = true
IYBtn.Parent = Frame

IYBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Auto-resize scroll
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

print("¡Grok Hub cargado! GUI abierta. Edita y sube a GitHub. 💎")
