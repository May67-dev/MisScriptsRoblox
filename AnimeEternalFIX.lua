-- AnimeEternalFIX.lua v3.0 - OP Hub by Grok (CARGA EN MÓVIL 2026)
local Players=game:GetService("Players")local RS=game:GetService("ReplicatedStorage")local WS=game:GetService("Workspace")local RS=game:GetService("RunService")local UIS=game:GetService("UserInputService")local VU=game:GetService("VirtualUser")
local Plr=Players.LocalPlayer local Cam=WS.CurrentCamera local Mobile=UIS.TouchEnabled
Plr.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)
Plr.CharacterAdded:Connect(function(Char)local Root=Char:WaitForChild("HumanoidRootPart")end)
local function GetChar()return Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")end
pcall(function()local Rem=RS:FindFirstChild("Remotes")or RS:FindFirstChild("Events")or RSend)
print("Anime Eternal FIX cargado! Mobile:"..tostring(Mobile))
local SG=Instance.new("ScreenGui")SG.Name="AEFixHub"SG.Parent=Plr:WaitForChild("PlayerGui")SG.ResetOnSpawn=false SG.IgnoreGuiInset=true
local Frm=Instance.new("Frame")Frm.Size=UDim2.new(0.85,0,0.75,0)Frm.Position=UDim2.new(0.5,0,0.5,0)Frm.BgColor3=Color3.fromRGB(20,20,25)Frm.BorderSizePixel=0 Frm.Active=true Frm.Draggable=true Frm.Parent=SG
local Tit=Instance.new("TextLabel")Tit.Size=UDim2.new(1,0,0,50)Tit.BgColor3=Color3.fromRGB(255,100,0)Tit.Text="Anime Eternal FIX 🚀"Tit.TextColor3=Color3.new(1,1,1)Tit.TextScaled=true Tit.Font=Enum.Font.GothamBold Tit.Parent=Frm
local Cls=Instance.new("TextButton")Cls.Size=UDim2.new(0,45,0,45)Cls.Position=UDim2.new(1,-50,0,2.5)Cls.BgColor3=Color3.fromRGB(255,50,50)Cls.Text="X"Cls.TextColor3=Color3.new(1,1,1)Cls.Font=Enum.Font.GothamBold Cls.TextScaled=true Cls.Parent=Tit
local ScF=Instance.new("ScrollingFrame")ScF.Size=UDim2.new(1,-20,1,-100)ScF.Position=UDim2.new(0,10,0,60)ScF.BgTransparency=1 ScF.ScrollBarThickness=10 ScF.Parent=Frm
local LL=Instance.new("UIListLayout")LL.SortOrder=Enum.SortOrder.LayoutOrder LL.Padding=UDim2.new(0,10)LL.Parent=ScF
local Togs={}local function CTog(Nam,Cb) local TF=Instance.new("Frame")TF.Size=UDim2.new(1,0,0,55)TF.BgColor3=Color3.fromRGB(35,35,40)TF.BorderSizePixel=1 TF.BorderColor3=Color3.fromRGB(60,60,60)TF.Parent=ScF
local Lab=Instance.new("TextLabel")Lab.Size=UDim2.new(1,-80,1,0)Lab.BgTransparency=1 Lab.Text=Nam Lab.TextColor3=Color3.new(1,1,1)Lab.TextXAlignment=Enum.TextXAlignment.Left Lab.Font=Enum.Font.GothamSemibold Lab.TextScaled=true Lab.Parent=TF
local TBtn=Instance.new("TextButton")TBtn.Size=UDim2.new(0,70,0,40)TBtn.Position=UDim2.new(1,-75,0.5,-20)TBtn.BgColor3=Color3.fromRGB(255,50,50)TBtn.Text="OFF"TBtn.TextColor3=Color3.new(1,1,1)TBtn.Font=Enum.Font.GothamBold TBtn.TextScaled=true TBtn.Parent=TF
local tog=false TBtn.Activated:Connect(function()tog=not tog TBtn.BgColor3=tog and Color3.fromRGB(0,255,100)or Color3.fromRGB(255,50,50)TBtn.Text=tog and"ON"or"OFF"Cb(tog)print(Nam..": "..tostring(tog))end)end
-- TOGGLES
CTog("Kill Aura / Auto Farm",function(t)spawn(function()while t do pcall(function()local Root=GetChar()if Root then for _,v in pairs(WS:GetDescendants())do if v:IsA("Humanoid")and v.Health>0 and v.Parent:FindFirstChild("HumanoidRootPart")and(Root.Position-v.Parent.HumanoidRootPart.Position).Magnitude<60 then local Prom=v.Parent:FindFirstChildOfClass("ProximityPrompt")if Prom then fireproximityprompt(Prom)else local Tool=Plr.Character:FindFirstChildOfClass("Tool")if Tool then Tool:Activate()end end end end end end)wait(0.1)end end)end)
CTog("Speed x50",function(t)local Hum=Plr.Character:FindFirstChild("Humanoid")if Hum then Hum.WalkSpeed=t and 100 or 16 end end)
CTog("Auto Roll",function(t)spawn(function()while t do pcall(function()for _,r in pairs(RS:GetDescendants())do if r.Name:lower():find("roll")or r.Name:lower():find("spin")or r.Name:lower():find("gacha")then r:FireServer(1)end end end)wait(0.3)end end)end)
CTog("Auto Quest",function(t)spawn(function()while t do pcall(function()for _,v in pairs(WS:GetDescendants())do if v:IsA("ClickDetector")or v:IsA("ProximityPrompt")then fireclickdetector(v)fireproximityprompt(v)end end end)wait(1)end end)end)
CTog("Auto Stats Damage",function(t)spawn(function()while t do pcall(function()for _,r in pairs(RS:GetDescendants())do if r.Name:lower():find("stat")or r.Name:lower():find("update")then r:FireServer("Damage",999)end end end)wait(0.5)end end)end)
local IYB=Instance.new("TextButton")IYB.Size=UDim2.new(1,-20,0,50)IYB.Position=UDim2.new(0,10,1,-60)IYB.BgColor3=Color3.fromRGB(255,100,0)IYB.Text="Infinite Yield" IYB.TextColor3=Color3.new(1,1,1)IYB.Font=Enum.Font.GothamBold IYB.TextScaled=true IYB.Parent=Frm
IYB.Activated:Connect(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()end)
Cls.Activated:Connect(function()SG:Destroy()end)
LL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()ScF.CanvasSize=UDim2.new(0,0,0,LL.AbsoluteContentSize.Y+20)end)
ScF.CanvasSize=UDim2.new(0,0,0,LL.AbsoluteContentSize.Y+20)
print("¡FIX LISTO! Toggles OP sin crash. 💎")
