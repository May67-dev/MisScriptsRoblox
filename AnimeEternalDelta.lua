-- AnimeEternalDelta.lua v4.0 - OP Hub for Delta Mobile (CARGA INSTANT)
local Plr=game.Players.LocalPlayer local WS=game.Workspace local RS=game.ReplicatedStorage local UIS=game:GetService("UserInputService") local VU=game:GetService("VirtualUser")
Plr.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)
local function GetRoot()return Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")end
print("AnimeEternalDelta CARGADO! 🔥")
local SG=Instance.new("ScreenGui")SG.Name="AEDelta"SG.Parent=Plr.PlayerGui SG.ResetOnSpawn=false SG.IgnoreGuiInset=true
local Frm=Instance.new("Frame")Frm.Size=UDim2.new(0.85,0,0.85,0)Frm.Position=UDim2.new(0.075,0,0.075,0)Frm.BackgroundColor3=Color3.fromRGB(20,20,25)Frm.BorderSizePixel=0 Frm.Active=true Frm.Draggable=true Frm.Parent=SG
local Tit=Instance.new("TextLabel")Tit.Size=UDim2.new(1,0,0,60)Tit.BackgroundColor3=Color3.fromRGB(255,100,0)Tit.Text="Anime Eternal Delta Hub 🚀"Tit.TextColor3=Color3.new(1,1,1)Tit.TextScaled=true Tit.Font=Enum.Font.GothamBold Tit.Parent=Frm
local Cls=Instance.new("TextButton")Cls.Size=UDim2.new(0,50,0,50)Cls.Position=UDim2.new(1,-55,0,5)Cls.BackgroundColor3=Color3.fromRGB(255,50,50)Cls.Text="X"Cls.TextColor3=Color3.new(1,1,1)Cls.Font=Enum.Font.GothamBold Cls.TextScaled=true Cls.Parent=Tit
-- TOGGLES FIJOS (sin Scroll - Delta fix)
local Togs={KillAura=false,AutoRoll=false,AutoQuest=false,Speed=false,Noclip=false}
local function Btn(ypos,text,cb) local B=Instance.new("TextButton")B.Size=UDim2.new(1,-20,0,55)B.Position=UDim2.new(0,10,ypos,70)B.BackgroundColor3=Color3.fromRGB(35,35,40)B.Text=text.." OFF" B.TextColor3=Color3.new(1,1,1)B.Font=Enum.Font.GothamBold B.TextScaled=true B.Parent=Frm
local tog=false B.Activated:Connect(function()tog=not tog B.BackgroundColor3=tog and Color3.fromRGB(0,255,100)or Color3.fromRGB(255,50,50)B.Text=text.." "..(tog and"ON"or"OFF") cb(tog) print(text..": "..tostring(tog))end)end
-- KILL AURA / AUTO FARM
Btn(0,"Kill Aura/Farm",function(t)Togs.KillAura=t spawn(function()while Togs.KillAura do pcall(function()local Root=GetRoot()if Root then for _,v in pairs(WS:GetDescendants())do if v:IsA("Humanoid")and v.Health>0 and v.Parent:FindFirstChild("HumanoidRootPart")and(Root.Position-v.Parent.HumanoidRootPart.Position).Magnitude<60 then local Prom=v.Parent:FindFirstChildOfClass("ProximityPrompt")if Prom then fireproximityprompt(Prom)else local Tool=Plr.Character:FindFirstChildOfClass("Tool")if Tool then Tool:Activate()end end end end end end)wait(0.1)end end)end)
-- AUTO ROLL
Btn(0.12,"Auto Roll",function(t)Togs.AutoRoll=t spawn(function()while Togs.AutoRoll do pcall(function()for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")and(r.Name:lower():find("roll")or r.Name:lower():find("spin")or r.Name:lower():find("gacha"))then r:FireServer(1)end end end)wait(0.3)end end)end)
-- AUTO QUEST
Btn(0.24,"Auto Quest",function(t)Togs.AutoQuest=t spawn(function()while Togs.AutoQuest do pcall(function()for _,v in pairs(WS:GetDescendants())do if(v:IsA("ClickDetector")or v:IsA("ProximityPrompt"))and v.Parent.Name:lower():find("npc")or v.Parent.Name:lower():find("quest")then fireclickdetector(v)fireproximityprompt(v)end end end)wait(1)end end)end)
-- SPEED
Btn(0.36,"Speed x50",function(t)Togs.Speed=t local Hum=Plr.Character and Plr.Character:FindFirstChild("Humanoid")if Hum then Hum.WalkSpeed=t and 100 or 16 end end)
-- NOCLIP
Btn(0.48,"Noclip",function(t)Togs.Noclip=t spawn(function()while Togs.Noclip do pcall(function()if Plr.Character then for _,p in pairs(Plr.Character:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end)wait()end end)end)
-- IY
local IY=Instance.new("TextButton")IY.Size=UDim2.new(1,-20,0,55)IY.Position=UDim2.new(0,10,0.62,70)IY.BackgroundColor3=Color3.fromRGB(255,100,0)IY.Text="Infinite Yield" IY.TextColor3=Color3.new(1,1,1)IY.Font=Enum.Font.GothamBold IY.TextScaled=true IY.Parent=Frm
IY.Activated:Connect(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source?v=1"))()end)
Cls.Activated:Connect(function()SG:Destroy()end)
print("¡Delta Hub LISTO! Toca toggles en Anime Eternal. 💎")
