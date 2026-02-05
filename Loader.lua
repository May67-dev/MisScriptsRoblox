-- Loader.lua MOBILE FIXED v2.0 - Script Hub OP by Grok (MÓVIL PERFECTO)
-- Sube a GitHub y carga: loadstring(game:HttpGet("TU_URL_LIMPIA"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled

-- Anti-AFK
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("GrokHub v2.0 cargando... Mobile: " .. tostring(IsMobile))

-- GUI Responsive para móvil
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrokHub"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.85, 0, 0.75, 0)  -- Más grande para móvil
Frame.Position = UDim2.new(0.5, -0, 0.5, -0)  -- Centro
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Title.Text = "Grok Hub Mobile 🚀"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)  -- Más grande
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = Title

-- ScrollFrame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -90)
ScrollFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 10
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)
ScrollFrame.Parent = Frame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim2.new(0, 8)
ListLayout.Parent = ScrollFrame

-- Variables
local FlyEnabled, SpeedEnabled, NoclipEnabled, ESPEnabled = false, false, false, false
local FlyConn, NoclipConn, ESPConns = nil, nil, {}

-- Función Toggle (con Activated + grande)
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)  -- Más alto
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleFrame.BorderSizePixel = 2
    ToggleFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    ToggleFrame.Parent = ScrollFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextScaled = true
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 35)  -- XXL para dedo
    ToggleBtn.Position = UDim2.new(1, -65, 0.5, -17.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextScaled = true
    ToggleBtn.Parent = ToggleFrame

    local toggled = false
    ToggleBtn.Activated:Connect(function()  -- ✅ MOBILE FIX
        toggled = not toggled
        ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        ToggleBtn.Text = toggled and "ON " or "OFF"
        callback(toggled)
        print(name .. ": " .. tostring(toggled))  -- Debug
    end)
end

-- Crea toggles en spawn() para móvil
spawn(function()
    print("Creando toggles...")
    
    -- Speed (siempre funciona)
    CreateToggle("Speed x16", function(toggled)
        SpeedEnabled = toggled
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = toggled and 100 or 16
    end)
    
    -- Noclip
    CreateToggle("Noclip", function(toggled)
        NoclipEnabled = toggled
        if toggled then
            NoclipConn = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                    end
                end
            end)
        else
            if NoclipConn then NoclipConn:Disconnect() end
            if Player.Character then
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end)
    
    -- ESP
    CreateToggle("Player ESP", function(toggled)
        ESPEnabled = toggled
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                local high = plr.Character:FindFirstChildOfClass("Highlight")
                if toggled and not high then
                    high = Instance.new("Highlight")
                    high.FillColor = Color3.fromRGB(255, 0, 0)
                    high.OutlineColor = Color3.fromRGB(255, 255, 255)
                    high.Parent = plr.Character
                elseif high then high:Destroy() end
            end
        end
    end)
    
    -- Fly (adaptado móvil)
    CreateToggle("Fly" .. (IsMobile and " (Jump=Up)" or " (WASD)"), function(toggled)
        FlyEnabled = toggled
        local char = Player.Character or Player.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        local hum = char:WaitForChild("Humanoid")
        
        if toggled then
            if IsMobile then
                -- Móvil: Jump = Up, Hold Jump = Fly up/down
                hum.JumpPower = 100
                hum.PlatformStand = true
                local bv = Instance.new("BodyVelocity", root)
                bv.MaxForce = Vector3.new(4000,4000,4000)
                bv.Velocity = Vector3.new(0,50,0)
                FlyConn = RunService.Heartbeat:Connect(function()
                    if FlyEnabled then
                        bv.Velocity = Camera.CFrame.LookVector * 50 + Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 50 or -20), 0)
                    end
                end)
            else
                -- PC keys
                local bv = Instance.new("BodyVelocity", root)
                bv.MaxForce = Vector3.new(4000,4000,4000)
                bv.Velocity = Vector3.new(0,0,0)
                local bg = Instance.new("BodyGyro", root)
                bg.MaxTorque = Vector3.new(4000,4000,4000)
                bg.CFrame = root.CFrame
                FlyConn = RunService.Heartbeat:Connect(function()
                    if FlyEnabled then
                        local move = Vector3.new(0,0,0)
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0,0,-1) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0,0,1) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1,0,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1,0,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
                        bv.Velocity = (Camera.CFrame.LookVector * 50 + move * 50)
                        bg.CFrame = Camera.CFrame
                    end
                end)
            end
        else
            hum.PlatformStand = false
            hum.JumpPower = 50
            if FlyConn then FlyConn:Disconnect() FlyConn = nil end
            local bv = root:FindFirstChildOfClass("BodyVelocity")
            local bg = root:FindFirstChildOfClass("BodyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
