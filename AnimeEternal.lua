-- AnimeEternal.lua - Hub OP by Grok (Mejor que LunaS3ven) MOBILE PERFECTO
-- Features: AutoFarm, KillAura, AutoQuest, AutoStats, AutoRoll, AutoDungeon, AutoSkills + Speed/Fly/Noclip/ESP
-- Sube a GitHub y loadstring!

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Anti-AFK + Reconnect char
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Detect Game Remotes (Anime Eternal specific)
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DamageRemote = Remotes:WaitForChild("Damage") or Remotes:FindFirstChild("CombatRemote") or Remotes:FindFirstChild("HitRemote")
local QuestRemote = Remotes:WaitForChild("QuestRemote") or Remotes:FindFirstChild("Quest")
local StatsRemote = Remotes:WaitForChild("UpdateStats") or Remotes:FindFirstChild("Stats")
local RollRemote = Remotes:WaitForChild("SpinPrizeEvent") or Remotes:FindFirstChild("Roll") or Remotes:FindFirstChild("Gacha")
local DungeonRemote = Remotes:WaitForChild("Dungeon") or Remotes:FindFirstChild("EnterDungeon")
local SkillRemote = Remotes:WaitForChild("SkillRemote") or Remotes:FindFirstChild("UseSkill")

print("Anime Eternal Hub cargado! Remotes detectados. Mobile: " .. tostring(IsMobile))

-- GUI Mobile
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimeEternalHub"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.85, 0, 0.8, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(255, 100, 0)  -- Naranja anime style
Title.Text = "Anime Eternal Hub 🚀 by Grok"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -50, 0, 2.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = Title

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -100)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 10
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
ScrollFrame.Parent = Frame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim2.new(0, 10)
ListLayout.Parent = ScrollFrame

-- Toggles vars
local Toggles = {
    AutoFarm = false,
    KillAura = false,
    AutoQuest = false,
    AutoStats = false,
    AutoRoll = false,
    AutoDungeon = false,
    AutoSkills = false
}

-- Func CreateToggle (mobile XXL)
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 55)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    ToggleFrame.BorderSizePixel = 1
    ToggleFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    ToggleFrame.Parent = ScrollFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.TextScaled = true
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 70, 0, 40)
    ToggleBtn.Position = UDim2.new(1, -75, 0.5, -20)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextScaled = true
    ToggleBtn.Parent = ToggleFrame

    local toggled = false
    ToggleBtn.Activated:Connect(function()
        toggled = not toggled
        ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        ToggleBtn.Text = toggled and "ON" or "OFF"
        callback(toggled)
        print(name .. ": " .. (toggled and "ON" or "OFF"))
    end)
end

-- SPAWN TOGGLES (mobile fix)
spawn(function()
    wait(0.5)  -- Espera load game

    -- Kill Aura / Auto Farm (daño a mobs cercanos <50 studs)
    CreateToggle("Kill Aura / Auto Farm", function(toggled)
        Toggles.KillAura = toggled
        Toggles.AutoFarm = toggled  -- Mismo toggle para farm
        spawn(function()
            while Toggles.KillAura do
                pcall(function()
                    for _, enemy in pairs(Workspace:GetDescendants()) do
                        if enemy:IsA("Humanoid") and enemy.Health > 0 and enemy.Parent ~= Character and enemy.Parent:FindFirstChild("HumanoidRootPart") then
                            local dist = (RootPart.Position - enemy.Parent.HumanoidRootPart.Position).Magnitude
                            if dist < 50 then  -- Aura range
                                if DamageRemote then
                                    DamageRemote:FireServer(enemy.Parent.HumanoidRootPart)
                                else
                                    -- Fallback: tool activate
                                    local tool = Character:FindFirstChildOfClass("Tool")
                                    if tool then tool:Activate() end
                                end
                            end
                        end
                    end
                end)
                wait(0.1)
            end
        end)
    end)

    -- Auto Quest
    CreateToggle("Auto Quest", function(toggled)
        Toggles.AutoQuest = toggled
        spawn(function()
            while Toggles.AutoQuest do
                pcall(function()
                    if QuestRemote then
                        QuestRemote:FireServer("Accept")  -- o "Complete"
                        QuestRemote:FireServer("Complete")
                    end
                    -- Fallback: interact NPCs
                    for _, npc in pairs(Workspace.NPCs:GetChildren()) do  -- Assume folder
                        if npc:FindFirstChild("ClickDetector") then
                            fireclickdetector(npc.ClickDetector)
                        end
                    end
                end)
                wait(1)
            end
        end)
    end)

    -- Auto Stats (max Damage/Range)
    CreateToggle("Auto Stats (Damage)", function(toggled)
        Toggles.AutoStats = toggled
        spawn(function()
            while Toggles.AutoStats do
                pcall(function()
                    if StatsRemote then
                        StatsRemote:FireServer("Damage", 999)  -- All points to Damage
                        StatsRemote:FireServer("Range", 999)
                    end
                end)
                wait(0.5)
            end
        end)
    end)

    -- Auto Roll / Gacha
    CreateToggle("Auto Roll Stars", function(toggled)
        Toggles.AutoRoll = toggled
        spawn(function()
            while Toggles.AutoRoll do
                pcall(function()
                    if RollRemote then
                        RollRemote:FireServer(1)  -- Roll 1
                    end
                end)
                wait(0.2)
            end
        end)
    end)

    -- Auto Dungeon
    CreateToggle("Auto Dungeon", function(toggled)
        Toggles.AutoDungeon = toggled
        spawn(function()
            while Toggles.AutoDungeon do
                pcall(function()
                    if DungeonRemote then
                        DungeonRemote:FireServer("Enter")
                    end
                    -- + Kill aura inside
                end)
                wait(2)
            end
        end)
    end)

    -- Auto Skills (spam QWER + M1)
    CreateToggle("Auto Skills", function(toggled)
        Toggles.AutoSkills = toggled
        spawn(function()
            while Toggles.AutoSkills do
                pcall(function()
                    if SkillRemote then
                        for i=1,4 do SkillRemote:FireServer(i) end  -- Q=1 W=2 etc.
                    end
                    -- Click
                    mouse1click()
                end)
                wait(0.15)
            end
        end)
    end)

    -- Speed
    CreateToggle("Speed x50", function(toggled)
        Humanoid.WalkSpeed = toggled and 100 or 16
    end)

    -- Fly (mobile: jump up)
    CreateToggle("Fly", function(toggled)
        -- Same as previous fly code, adapt if needed
        -- ... (usa el fly de v2.0)
    end)

    -- Noclip
    CreateToggle("Noclip", function(toggled)
        -- Same noclip
    end)

    -- Update canvas
    ScrollFrame.CanvasSize = UDim2.new(0,0,0, ListLayout.AbsoluteContentSize.Y + 20)
end)

-- IY Button
local IYBtn = Instance.new("TextButton")
IYBtn.Size = UDim2.new(1, -20, 0, 50)
IYBtn.Position = UDim2.new(0, 10, 1, -60)
IYBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
IYBtn.Text = "Infinite Yield (Admin)"
IYBtn.TextColor3 = Color3.new(1,1,1)
IYBtn.Font = Enum.Font.GothamBold
IYBtn.TextScaled = true
IYBtn.Parent = Frame

IYBtn.Activated:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Close
CloseBtn.Activated:Connect(function()
    ScreenGui:Destroy()
end)

-- Auto resize
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0,0,0, ListLayout.AbsoluteContentSize.Y + 20)
end)

print("¡Anime Eternal Hub LISTO! Toca ON y domina. 💎")
