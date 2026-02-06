-- AnimeEternalDelta.lua v7.0 - +4 FUNCS OP + MINIMIZAR (Delta Mobile PERFECTO)
local Plr=game.Players.LocalPlayer local WS=game.Workspace local RS=game.ReplicatedStorage local UIS=game:GetService("UserInputService") local VU=game:GetService("VirtualUser") local Mouse=Plr:GetMouse() local RS=game:GetService("RunService")
Plr.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)
local function GetRoot()return Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart")end local function GetHum()return Plr.Character and Plr.Character:FindFirstChild("Humanoid")end
print("AnimeEternalDelta v7 CARGADO! +4 funcs + Min. 🔥")
local SG=Instance.new("ScreenGui")SG.Name="AEDelta"SG.Parent=Plr.PlayerGui SG.ResetOnSpawn=false SG.IgnoreGuiInset=true
local Frm=Instance.new("Frame")Frm.Size=UDim2.new(0.85,0,0.88,0)Frm.Position=UDim2.new(0.075,0,0.06,0)Frm.BackgroundColor3=Color3.fromRGB(20,20,25)Frm.BorderSizePixel=0 Frm.Active=true Frm.Draggable=true Frm.Parent=SG
local Tit=Instance.new("TextLabel")Tit.Size=UDim2.new(1,0,0,55)Tit.BackgroundColor3=Color3.fromRGB(255,100,0)Tit.Text="Anime Eternal Delta Hub v7 🚀"Tit.TextColor3=Color3.new(1,1,1)Tit.TextScaled=true Tit.Font=Enum.Font.GothamBold Tit.Parent=Frm
local Min=Instance.new("TextButton")Min.Size=UDim2.new(0,45,0,45)Min.Position=UDim2.new(1,-105,0,5)Min.BackgroundColor3=Color3.fromRGB(255,200,0)Min.Text="-"Min.TextColor3=Color3.new(1,1,1)Min.Font=Enum.Font.GothamBold Min.TextScaled=true Min.Parent=Tit
local Cls=Instance.new("TextButton")Cls.Size=UDim2.new(0,45,0,45)Cls.Position=UDim2.new(1,-55,0,5)Cls.BackgroundColor3=Color3.fromRGB(255,50,50)Cls.Text="X"Cls.TextColor3=Color3.new(1,1,1)Cls.Font=Enum.Font.GothamBold Cls.TextScaled=true Cls.Parent=Tit
local minimized=false Min.Activated:Connect(function()minimized=not minimized Frm.Size=UDim2.new(0.85,0,minimized and 0.065 or 0.88,0)Frm.Position=UDim2.new(0.075,0,minimized and 0.935 or 0.06,0)Min.Text=minimized and"+"or"-"end)
local Togs={KillAura=false,AutoRoll=false,AutoQuest=false,Speed=false,Noclip=false,AutoStats=false,AutoSkills=false,Fly=false,Godmode=false}
local function Btn(ypos,text,cb) local B=Instance.new("TextButton")B.Size=UDim2.new(1,-20,0,42)B.Position=UDim2.new(0,10,ypos,65)B.BackgroundColor3=Color3.fromRGB(35,35,40)B.Text=text.." OFF" B.TextColor3=Color3.new(1,1,1)B.Font=Enum.Font.GothamBold B.TextScaled=true B.Parent=Frm
local tog=false B.Activated:Connect(function()tog=not tog B.BackgroundColor3=tog and Color3.fromRGB(0,255,100)or Color3.fromRGB(255,50,50)B.Text=text.." "..(tog and"ON"or"OFF") cb(tog) print(text..": "..tostring(tog))end)end
-- Kill Aura OP v5 (mismo)
Btn(0,"Kill Aura/Farm",function(t)Togs.KillAura=t spawn(function()while Togs.KillAura do pcall(function()local Root=GetRoot()if Root then local closest=nil local minD=60 for _,obj in pairs(WS:GetDescendants())do if obj:IsA("Humanoid")and obj.Health>0 and obj.Parent~=Plr.Character and obj.Parent:FindFirstChild("HumanoidRootPart")then local dist=(Root.Position-obj.Parent.HumanoidRootPart.Position).Magnitude if dist<minD then minD=dist closest=obj.Parent.HumanoidRootPart end end end if closest then if minD>30 then Root.CFrame=closest.CFrame*CFrame.new(0,5,0) end for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")and(r.Name:lower():find("damage")or r.Name:lower():find("hit")or r.Name:lower():find("combat")or r.Name:lower():find("attack"))then pcall(function()r:FireServer(closest)end)end end Mouse:Click()local Tool=Plr.Character:FindFirstChildOfClass("Tool")if Tool then Tool:Activate()end else wait(0.5)end else wait(1)end end)wait(0.05)end end)end)
-- Auto Roll TURBO v6 (mismo)
Btn(0.078,"Auto Roll",function(t)Togs.AutoRoll=t spawn(function()while Togs.AutoRoll do pcall(function()local keywords={"roll","spin","gacha","prize","star","banner","reroll"}local args={1,"Single",true,false,10,"1"}for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")then local name=r.Name:lower() for _,kw in pairs(keywords)do if name:find(kw)then for _,arg in pairs(args)do pcall(function()r:FireServer(arg)print("ROLL: "..r.Name.." "..tostring(arg))end)end end end end end for _,v in pairs(WS:GetDescendants())do if v:IsA("ProximityPrompt")and v.Parent.Name:lower():find("gacha")or v.Parent.Name:lower():find("roll")then fireproximityprompt(v)end end end)wait(0.1)end end)end)
-- Auto Quest (mismo)
Btn(0.156,"Auto Quest",function(t)Togs.AutoQuest=t spawn(function()while Togs.AutoQuest do pcall(function()for _,v in pairs(WS:GetDescendants())do if(v:IsA("ClickDetector")or v:IsA("ProximityPrompt"))and(v.Parent.Name:lower():find("npc")or v.Parent.Name:lower():find("quest"))then fireclickdetector(v)fireproximityprompt(v)end end end)wait(1)end end)end)
-- Speed (mismo)
Btn(0.234,"Speed x50",function(t)Togs.Speed=t local Hum=GetHum()if Hum then Hum.WalkSpeed=t and 100 or 16 end end)
-- Noclip (mismo)
Btn(0.312,"Noclip",function(t)Togs.Noclip=t spawn(function()while Togs.Noclip do pcall(function()if Plr.Character then for _,p in pairs(Plr.Character:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end end)wait()end end)end)
-- AUTO STATS NEW (Damage/Energy max)
Btn(0.39,"Auto Stats",function(t)Togs.AutoStats=t spawn(function()while Togs.AutoStats do pcall(function()local stats={"Damage","Energy","Coins","StarLuck"}for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")and r.Name:lower():find("stat")or r.Name:lower():find("update")then for _,s in pairs(stats)do r:FireServer(s,999)end end end end)wait(0.3)end end)end)
-- AUTO SKILLS/CLICK NEW
Btn(0.468,"Auto Skills",function(t)Togs.AutoSkills=t spawn(function()while Togs.AutoSkills do pcall(function()Mouse:Click()for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")and(r.Name:lower():find("skill")or r.Name:lower():find("ability"))then for i=1,4 do r:FireServer(i)end end end local Tool=Plr.Character:FindFirstChildOfClass("Tool")if Tool then Tool:Activate()end end)wait(0.15)end end)end)
-- FLY NEW (mobile jump up)
Btn(0.546,"Fly",function(t)Togs.Fly=t local Root=GetRoot()local Hum=GetHum()if t then Hum.PlatformStand=true local bv=Instance.new("BodyVelocity")bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.new(0,50,0)bv.Parent=Root RS.Heartbeat:Connect(function()if Togs.Fly and Root then bv.Velocity=Root.CFrame.LookVector*50+Vector3.new(0,UIS:IsKeyDown(Enum.KeyCode.Space)and 50 or 0,0)end end)else Hum.PlatformStand=false if Root:FindFirstChild("BodyVelocity")then Root:FindFirstChild("BodyVelocity"):Destroy()end end end)
-- GODMODE NEW (inf HP)
Btn(0.624,"Godmode",function(t)Togs.Godmode=t spawn(function()while Togs.Godmode do pcall(function()local Hum=GetHum()if Hum then Hum.Health=Hum.MaxHealth end for _,r in pairs(RS:GetDescendants())do if r:IsA("RemoteEvent")and r.Name:lower():find("health")or r.Name:lower():find("heal")then r:FireServer("Max")end end end)wait(0.2)end end)end)
-- IY abajo
local IY=Instance.new("TextButton")IY.Size=UDim2.new(1,-20,0,45)IY.Position=UDim2.new(0,10,0.71,65)IY.BackgroundColor3=Color3.fromRGB(255,100,0)IY.Text="Infinite Yield" IY.TextColor3=Color3.new(1,1,1)IY.Font=Enum.Font.GothamBold IY.TextScaled=true IY.Parent=Frm
IY.Activated:Connect(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source?v=1"))()end)
Cls.Activated:Connect(function()SG:Destroy()end)
print("¡v7 +4 FUNCS + MINIMIZAR! Todo OP. 💎")
