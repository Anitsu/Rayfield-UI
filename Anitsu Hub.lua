--Disable AC Logging Methods:
for i,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
end 

--Whitelist: 
local Rayfield = loadstring(httpRequest({Url = "https://raw.githubusercontent.com/Anitsu/Rayfield-UI/main/Anitsu%20Hub.lua"}).Body)()
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
Title = "Anitsu Hub";
Text = "LOADING...";
Duration = 3;
})
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

--Anti Afk:
for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do 
    v:Disable()
end 
--Services:
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Players = game:GetService("Players") 
local Teams = game:GetService("Teams")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager") 

local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

local HttpService = game:GetService("HttpService")
--Variables: 
local camera = game.Workspace.Camera 
local player = Players.LocalPlayer 
local mouse = player:GetMouse() 

--UI Library Functions: 
local Window = Rayfield:CreateWindow({
Name = "Anitsu Hub | Arcane Odyssey",
LoadingTitle = "Anitsu Hub",
LoadingSubtitle = "by Anitsu",
ConfigurationSaving = {
      Enabled = true,
      FolderName = "Anitsu Hub Configs", 
      FileName = "Anitsu Config"
   },
})

local Tab = Window:CreateTab("Main") 
local LightingSection = Tab:CreateSection("Lighting")

--Lighting Section: 
local NoFogToggle = Tab:CreateToggle({
Name = "No Fog",
CurrentValue = false,
Flag = "No Fog", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not noFog then 
        noFog = true 
        if Lighting:FindFirstChild("Atmosphere") then 
            Lighting.Atmosphere.Density = 0
            noFogConnection = Lighting.Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
                Lighting.Atmosphere.Density = 0 
            end)
        end
    else 
        noFog = false 
        if noFogConnection then 
            noFogConnection:Disconnect()
        end 
    end
end,
})
--Boss Farm Choice: 
local NoShadows = Tab:CreateToggle({
Name = "No Shadows",
CurrentValue = false,
Flag = "No Shadows", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if Lighting.GlobalShadows then 
        Lighting.GlobalShadows = false 
    else 
        Lighting.GlobalShadows = true 
    end
end,
})

local FullBright = Tab:CreateToggle({
Name = "Full Bright",
CurrentValue = false,
Flag = "Full Bright", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not fullBright then 
        fullBright = true 
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        fullBrightConnection = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        end)
    else 
        fullBright = false 
        fullBrightConnection:Disconnect()
        Lighting.Ambient = Lighting.OutdoorAmbient
    end 
end,
})
local AlwaysDay = Tab:CreateToggle({
Name = "Always Day",
CurrentValue = false,
Flag = "Always Day", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not alwaysDay then 
        alwaysDay = true 
        Lighting.ClockTime = 10 
        Lighting.TimeOfDay = "10:00:00" 
        alwaysDayConnection = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            Lighting.ClockTime = 10 
            Lighting.TimeOfDay = "10:00:00" 
        end)
    else 
        alwaysDay = false 
        alwaysDayConnection:Disconnect()
    end 
end,
})
local NoUnderwaterEffect = Tab:CreateToggle({
Name = "No Underwater Effect",
CurrentValue = false,
Flag = "No Underwater Effect", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if Lighting.ColorCorrection.Enabled then 
        Lighting.ColorCorrection.Enabled = false 
    else 
        Lighting.ColorCorrection.Enabled = true 
    end
end,
})

--Main Section: 
local MainSection = Tab:CreateSection("Main")
local WalkOnWater = Tab:CreateToggle({
Name = "Jesus (Walk On Water)",
CurrentValue = false,
Flag = "Jesus (Walk On Water)", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not jesus then 
        jesus = true 
        local jesusPart
        jesusConnection = RunService.RenderStepped:Connect(function()
            if camera:FindFirstChild("Sea") then 
                local sea = camera.Sea 
                if sea:FindFirstChild("Sea") and sea.Sea:FindFirstChild("Ocean1") then 
                    ocean = sea.Sea.Ocean1
                end 
            end 
            if not workspace:FindFirstChild("Jesus") then 
                jesusPart = Instance.new("Part", workspace)
                jesusPart.Name = "Jesus"
                jesusPart.Anchored = true 
                jesusPart.Size = Vector3.new(2048, 1, 2048) 
                jesusPart.Transparency = 1
            end 
            if player.Character then 
                local char = player.Character 
                if char:FindFirstChild("HumanoidRootPart") then 
                    local root = char.HumanoidRootPart
                    if ocean then 
                        jesusPart.Position = Vector3.new(root.Position.X,ocean.Position.Y,root.Position.Z)
                    end
                end 
            end
        end)
    else 
        jesus = false 
        jesusConnection:Disconnect()
        workspace.Jesus:Destroy()
    end 
end,
})
local InfStamina = Tab:CreateToggle({
Name = "Infinite Stamina",
CurrentValue = false,
Flag = "Infinite Stamina", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not infStam then 
        infStam = true 
        infStamLoop = player.CharacterAdded:Connect(function()
            stamina.Value = math.huge
        end)
    else 
        infStam = false 
        infStamLoop:Disconnect()
    end
end,
})
  

local RejoinServer = Tab:CreateButton({
Name = "Rejoin Server",
Callback = function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,player,nil,TeleportService:GetLocalPlayerTeleportData())
end,
})
local ServerHop = Tab:CreateButton({
Name = "Server Hop",
Callback = function()
    local response = httpRequest({Url = "https://games.roblox.com/v1/games/".. game.PlaceId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100"})
    local parsed = HttpService:JSONDecode(response.Body)
    local listOfServers = {}
    for i, v in pairs(parsed.data) do 
        local serverJobId = v.id 
        if serverJobId ~= game.JobId then 
            table.insert(listOfServers,serverJobId) 
        end 
    end 
    if #listOfServers == 0 then 
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR";
            Text = "Couldn't find different servers";
            Duration = 3;
        })    
    else 
        local randomServer = math.random(1, #listOfServers) 
        TeleportService:TeleportToPlaceInstance(game.PlaceId,listOfServers[randomServer],player,nil,TeleportService:GetLocalPlayerTeleportData())        
    end 
end,
})
local IY = Tab:CreateButton({
Name = "Infinite Yield",
Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end,
})

local PlayerESP = Tab:CreateToggle({
Name = "Player ESP",
CurrentValue = false,
Flag = "Player ESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Callback = function()
    if not plrESP then 
        plrESP = true 
        local function createTextESP(enemyPlayer)
            local drawnESP = Drawing.new("Text")
            drawnESP.Visible = false 
            drawnESP.Center = true 
            drawnESP.Color = Color3.fromRGB(255)
            drawnESP.Outline = true 
            drawnESP.Font = 2
            drawnESP.Size = 13.5
            plrESPLoop = RunService.RenderStepped:Connect(function()    
                if not plrESP then 
                    pcall(function()
                        drawnESP:Remove()
                        plrESPLoop:Disconnect()
                    end)
                end
                if enemyPlayer.Character then 
                    local enemyCharacter = enemyPlayer.Character 
                    if enemyCharacter:FindFirstChild("Head") and enemyCharacter:FindFirstChild("Humanoid") then 
                        local enemyHead = enemyCharacter.Head 
                        local enemyHumanoid = enemyCharacter.Humanoid 
                        local enemyHeadPos, onScreen = camera:WorldToViewportPoint(enemyHead.Position)

                        --ESP For Non-FFA
                        if onScreen and enemyPlayer.Team ~= player.Team and #Teams:GetChildren() > 0  then 
                            drawnESP.Visible = true 
                            drawnESP.Position = Vector2.new(enemyHeadPos.X, enemyHeadPos.Y - 35)
                            drawnESP.Text = "[" .. tostring(enemyPlayer) .. "]" .. "[" .. math.floor(player:DistanceFromCharacter(enemyHead.Position)) .. "]\n[" .. math.floor(enemyHumanoid.Health) .. "/" .. math.floor(enemyHumanoid.MaxHealth) .. "]"
                            
                        elseif not onScreen or enemyPlayer.Team == player.Team then 
                            drawnESP.Visible = false 
                        end

                        --ESP For FFA
                        if onScreen and #Teams:GetChildren() == 0 then 
                            drawnESP.Visible = true 
                            drawnESP.Position = Vector2.new(enemyHeadPos.X, enemyHeadPos.Y)
                            drawnESP.Text = "[" .. tostring(enemyPlayer) .. "]" .. "[" .. math.floor(player:DistanceFromCharacter(enemyHead.Position)) .. "]\n[" .. math.floor(enemyHumanoid.Health) .. "/" .. math.floor(enemyHumanoid.MaxHealth) .. "]"
                            
                        elseif not onScreen then 
                            drawnESP.Visible = false 
                        end  
                    else 
                        drawnESP.Visible = false                          
                    end
                else 
                    drawnESP.Visible = false 
                end
            end)
        end --function end 
        for i, v in pairs(Players:GetPlayers()) do 
            if v ~= player then 
                createTextESP(v)
            end
        end
        plrAddedConnection = Players.PlayerAdded:Connect(function(enemyPlayer)
            createTextESP(enemyPlayer)
        end)
    else 
        plrESP = false 
        plrAddedConnection:Disconnect()
    end 
end,
})
local ChatLogs = Window:CreateTab("Chat Logs") 
for i,v in pairs(game.Players:GetPlayers()) do 
    v.Chatted:Connect(function(msg)
        local Chat = ChatLogs:CreateParagraph({Title = v.Name, Content = "Message: " .. msg})
    end)
end
game.Players.PlayerAdded:Connect(function(plr)
    plr.Chatted:Connect(function(msg)
        local Chat = ChatLogs:CreateParagraph({Title = plr.Name, Content = "Message: " .. msg})
    end)
end)

queueonteleport([[
loadstring(request({Url = "https://raw.githubusercontent.com/Anitsu/Rayfield-UI/main/Anitsu%20Hub.lua"}).Body)()
]])

