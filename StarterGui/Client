-- Rank Selection Client

local CAS = game:GetService("ContextActionService")
local Storage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TS = game:GetService("TweenService")

local Modules = Storage:WaitForChild("Modules")
local rank = require(Modules.rank)

local UI = script.Parent
local Holder = UI:WaitForChild("Holder")
local Main = Holder.Main

local Title = Main.Title
local Body = Main.Body

local Open = false

local PrevOpen = os.clock()
local PrevChange = os.clock()

local Interval = 0.5
local ChangeInterval = 1

local function clear()
	Body.Info.RankName.Text = "RankName"
	Body.Info.Title.Text = "Equipped Rank"
	
	for _,v in pairs(Body.Ranks.List:GetChildren()) do
		if not v:IsA("UIGridLayout") then
			v:Destroy()
		end
	end
end

local function update()
	clear()
	
	local data = rank.getTags(Players.LocalPlayer)
	if data ~= "None" then
				
		Body.Info.RankName.Text = data.Equipped
		
		for name,value in pairs(data.Inventory) do
			local clone = script.Template:Clone()
			clone.Name = name
			clone.Button.Text = name
			
			clone.Parent = Body.Ranks.List
			
			clone.Button.MouseEnter:Connect(function()
				TS:Create(clone, TweenInfo.new(0.2), {
					BackgroundColor3 = Color3.fromRGB(12, 105, 162)
				}):Play()
			end)
			
			clone.Button.MouseLeave:Connect(function()
				TS:Create(clone, TweenInfo.new(0.2), {
					BackgroundColor3 = Color3.fromRGB(12, 85, 134)
				}):Play()
			end)
			
			clone.Button.MouseButton1Click:Connect(function()
				print'test'
				if (os.clock() - PrevChange) >= ChangeInterval then
					local result = rank.setTag(Players.LocalPlayer, clone.Name)
					if result == "Success" then
						update()
						PrevChange = os.clock()
					else
						print(result)
					end
					
				else
					print("??? ".. os.clock() - PrevChange)
				end
			end)
		end
		
	else
		warn("[RANK EDITOR] Could not get rank tags for ".. Players.LocalPlayer.Name..".")
		return;
	end
end

local function toggle()
	if Open == false then
		-- close
		Main:TweenPosition(UDim2.new(0,0,-1,0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.5, true)
		clear()
	end
	if Open == true then
		-- open
		Main:TweenPosition(UDim2.new(0,0,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.5, true)
		update()
	end
end

CAS:BindAction("ToggleEditor", function(name, state, obj)
	if state == Enum.UserInputState.Begin then
		if (os.clock() - PrevOpen) >= Interval then
			PrevOpen = os.clock()
			Open = not Open
			toggle()
		end
	end
end, false, Enum.KeyCode.M)
