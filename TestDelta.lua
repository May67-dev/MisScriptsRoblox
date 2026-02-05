local sg=Instance.new("ScreenGui")sg.Parent=game.Players.LocalPlayer.PlayerGui sg.Name="TestDelta"
local f=Instance.new("Frame")f.Size=UDim2.new(0.8,0,0.6,0)f.Position=UDim2.new(0.1,0,0.2,0)f.BackgroundColor3=Color3.fromRGB(0,255,0)f.Parent=sg
local t=Instance.new("TextLabel")t.Size=UDim2.new(1,0,0.7,0)t.BackgroundTransparency=1 t.Text="¡DELTA TEST OK! 🔥 Toca X" t.TextScaled=true t.TextColor3=Color3.new(1,1,1) t.Font=Enum.Font.GothamBold t.Parent=f
local x=Instance.new("TextButton")x.Size=UDim2.new(0,50,0,50)x.Position=UDim2.new(1,-55,0,5)x.BackgroundColor3=Color3.fromRGB(255,0,0)x.Text="X" x.TextScaled=true x.TextColor3=Color3.new(1,1,1) x.Parent=f
x.Activated:Connect(function()sg:Destroy()end)
print("TestDelta CARGADO - GUI verde!")
