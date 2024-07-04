---WAITS UNTIL CHARACTER AND GAME IS FULLY LOADED

repeat wait() until game:IsLoaded()


local time = os.clock()
COREGUI = game:GetService("CoreGui")
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 5712833750 then
    return
end

local breakit = false
while true do
    local success, error = pcall(function()
        print(game.Players.LocalPlayer:FindFirstChild("leaderstats"))
        task.wait()
        if game.Players.LocalPlayer:FindFirstChild("leaderstats") then
            breakit = true
        end
    end)

    if error then
        print(success, error)
    end

    if breakit then
        break
    end
end

Player = game.Players.LocalPlayer
Character = Player.Character or Player.CharacterAdded:Wait()


--[username] = 'webhook'
local Webhook = { -- For Grinding, tells you your leveling speed.
    ["XelXel"] = 'https://discord.com/api/webhooks/1253147668298076241/i8Dajs99L_s03B6dppfOMlYyUeZ0ol29Hv9asucpGgS3IWnZsUz4fyTNz1XNUeCMVRWQ', -- Example Webhook, doesn't work.
}

if Webhook[game.Players.LocalPlayer.Name] then
    getgenv().LocalWebhookId = Webhook[game.Players.LocalPlayer.Name]
end

Access = true
VIP = true



---SYSTEM TO SEE WHEN A PLAYER IS DEAD OR ALIVE [[START]]
function RemoveGUI()
    local success, error = pcall(function()
        if game.Players.LocalPlayer.PlayerGui:FindFirstChild("newRewardGui") then
            game.Players.LocalPlayer.PlayerGui.newRewardGui:Destroy()
            breakit = true
        end
    end)
end

function RemoveAddedCooldown()
    Character.ChildAdded:connect(function(child)
        if child.Name == "justFound" or child.Name == "Deb" or child.Name == "FireballDeb" then
            wait()
            child:Destroy()
        else
            print(child.Name, "Added")
        end
    end)
end


teleport = false
local CharacterAlive
if Character:FindFirstChild("Humanoid").Health > 0 then
    CharacterAlive = true
    teleport = true

    RemoveAddedCooldown()
    RemoveGUI()

    Character:WaitForChild("Humanoid").Died:Connect(function()
        CharacterAlive = false
    end)
else
    CharacterAlive = false
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Character:WaitForChild("Humanoid")
    CharacterAlive = true
    teleport = true

    RemoveAddedCooldown()
    RemoveGUI()

    Character:WaitForChild("Humanoid").Died:Connect(function()
        print("Character Dead")
        CharacterAlive = false
    end)
end)

---SYSTEM TO SEE WHEN A PLAYER IS DEAD OR ALIVE [[END]]

-- [[ Comma Function ]]
function commaValue(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end


-- [[ Webhook Setup ]]
local BotUserName = 'ONIxAPI'
local BotPhotoURL = 'https://media.discordapp.net/attachments/856034478408728576/1009394204193067058/oniii.jpg'
local Red = tonumber(tostring("0xFF0000"))
local Green = tonumber(tostring("0x32CD32"))
local Timestamp = os.date("%Y-%m-%dT%X.000Z")
local Request = http_request or request or HttpPost or syn.request




---- KEEP TRACK OF PLAYER'S PING
local fps = 0
local PlayerPing = 0
game:GetService("RunService").RenderStepped:Connect(function(ping)
    PlayerPing = (game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(math.round(2/ping))) -- your ping
    fps = math.round(1/ping)
end)



---- SEND PLAYER'S CURRENT LEVELING DAYA TO THE WEBHOOK

local fireballsTotal = 0

---FOR
local levelaverage = 0
local TotalExpPerMin = 0
local LostExpPerMin = 0
local xseconds = 0
local xmins = 0

if getgenv().LocalWebhookId ~= 'YOUR DISCORD WEBHOOK HERE' then
    local TrackingWebhookSeconds = 0
    local TrackingWebhookMinutes = 0
    local TrackedTime = 0
    local TrackedPlayerLevel = game.Players.LocalPlayer.leaderstats.Level.Value
    local LevelPerMin = 0
    local HoursTilOnLeaderboard = 0
    local leveldiff = 0

    local testSeconds = 0
    local testMins = 0
    local testHours = 0

    local function TotalExp(exp)
        return 500*(exp-1)^2+1500*(exp-1)+1000
    end


    local top100level = 135000
    for i,v in pairs(game:GetService("Workspace").LBFolder.GlobalLeaderboard.LeaderboardGUI.Holder.ScrollingFrame:GetChildren()) do
        if v.Name == "LeaderboardFrame" then
            local rank = tonumber(v.Rank.text)
            local player = v.Player.text
            local level = tonumber(v.Level.text)

            if rank == 100 then
                top100level = level
            end
        end
    end


    local top1level = 165000
    for i,v in pairs(game:GetService("Workspace").LBFolder.GlobalLeaderboard.LeaderboardGUI.Holder.ScrollingFrame:GetChildren()) do
        if v.Name == "LeaderboardFrame" then
            local rank = tonumber(v.Rank.text)
            local player = v.Player.text
            local level = tonumber(v.Level.text)

            if rank == 1 then
                top1level = level
            end
        end
    end

    task.spawn(function()
        while true do

            if testMins ~= 0 and game.Players.LocalPlayer.leaderstats.Level.Value-TrackedPlayerLevel ~= 0 then
                LevelPerMin = (game.Players.LocalPlayer.leaderstats.Level.Value-TrackedPlayerLevel)/testMins
            end

            local expdifftomax100 = TotalExp(top100level) - TotalExp(game.Players.LocalPlayer.leaderstats.Level.Value)
            local expdifftomax1 = TotalExp(top1level) - TotalExp(game.Players.LocalPlayer.leaderstats.Level.Value)
            local TotalExpPerHour = TotalExpPerMin*60

            HoursTilOnLeaderboard100 = expdifftomax100/TotalExpPerHour
            HoursTilOnLeaderboard1 = expdifftomax1/TotalExpPerHour

            if TrackingWebhookSeconds == 0 then
                local msg = {
                    ["username"] = BotUserName,
                    ["avatar_url"] = BotPhotoURL,
                    ["content"] = " ",
                    ["embeds"] = {
                        {
                            ["title"] = "__**Farming Update**__",
                            ["type"] = "rich",
                            ["description"] = Player.Name,
                            ["color"] = Green,
                            ["fields"] = {
                                {
                                    ["name"] = "Current Level",
                                    ["value"] = commaValue(game.Players.LocalPlayer.leaderstats.Level.Value),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Previous Level",
                                    ["value"] = commaValue(TrackedPlayerLevel),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "​",
                                    ["value"] = "Data:",
                                },
                                {
                                    ["name"] = "Levels Gained",
                                    ["value"] = commaValue(game.Players.LocalPlayer.leaderstats.Level.Value-TrackedPlayerLevel),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Levels Per Min",
                                    ["value"] = tostring(math.round(LevelPerMin*100)/100),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Levels Per Hour",
                                    ["value"] = tostring(math.round((LevelPerMin*60)*100)/100),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Exp Gained Per Min",
                                    ["value"] = commaValue(TotalExpPerMin),
                                    ["inline"] = false
                                },
                                {
                                    ["name"] = "Exp till #100",
                                    ["value"] = commaValue(expdifftomax100),
                                    ["inline"] = false
                                },
                                {
                                    ["name"] = "Hours till #100",
                                    ["value"] = tostring(math.round(HoursTilOnLeaderboard100*100)/100),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Exp till #1",
                                    ["value"] = commaValue(expdifftomax1),
                                    ["inline"] = false
                                },
                                {
                                    ["name"] = "Hours till #1",
                                    ["value"] = tostring(math.round(HoursTilOnLeaderboard1*100)/100),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Fireballs",
                                    ["value"] = fireballsTotal,
                                    ["inline"] = true
                                },
                            },
                            ['timestamp'] = Timestamp,
                            ["footer"] = {
                                ["text"]  = "Time Farming: ".. TrackedTime.. "\n" .. "FPS: "..fps.."\n" .. "Ping: ".. PlayerPing .. "\n" .."​"
                            }
                        },
                    }
                }
                pcall(function()
                    Request({Url = getgenv().LocalWebhookId, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})
                end)
                --print("Sending Request")


                xseconds = 0
                xmins = 0
                TotalExpPerMin = 0
                LostExpPerMin = 0
                levelaverage = 0
            end


            testSeconds += 1
            testMins = testSeconds / 60
            testHours = testMins / 60

            --print("SECONDS: ",TrackingWebhookSeconds)

            TrackingWebhookSeconds = TrackingWebhookSeconds + 1
            if TrackingWebhookSeconds >= 300 then
                TrackingWebhookMinutes = (TrackingWebhookSeconds + (TrackingWebhookMinutes * 60)) / 60
                TrackedTime = math.floor(TrackingWebhookMinutes) .. ' Minutes'

                if TrackingWebhookMinutes >= 60 then
                    TrackingWebhookHours = TrackingWebhookMinutes / 60
                    TrackingWebhookLeftoverMinutes = (TrackingWebhookHours%1) * 60
                    TrackingWebhookHours = math.floor(TrackingWebhookHours)
                    TrackedTime = TrackingWebhookHours .. ' Hours ' .. math.floor(TrackingWebhookLeftoverMinutes) .. ' Minutes'
                end
                TrackingWebhookSeconds = 0
            end
            wait(1)
        end
    end)
end

-- [[ Anti AFK ]]
if not game:IsLoaded() then game.Loaded:Wait(); end

local idledEvent = game:GetService("Players").LocalPlayer.Idled
local function disable()
    for _, cn in ipairs(getconnections(idledEvent)) do
        cn:Disable()
    end
end

oldConnect = hookfunction(idledEvent.Connect, function(self, ...)
    local cn = oldConnect(self, ...); disable()
    return cn
end)

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    if self == idledEvent and getnamecallmethod() == "Connect" then
        local cn = oldConnect(self, ...); disable()
        return cn
    end
    return namecall(self, ...)
end)

disable()







---- KEEPS TRACK OF ALL THE EXP GAINED FROM THE USE OF THE CHANGED SIGNAL. THIS IS USED TO PREDICT WHAT LEVEL YOU WILL BE BASED ON THE GIVEN EXP PER MIN


local tickstart = os.clock()
local expgained = 0
local lostexp = 0
local totalexp = 0
local level = 0
local exp = 0
local expreset = 0
local leveluptrack = 0
local FireballOrHittrack = 0


local currentexp
local previousexp
local previouslevel
function Exp()
    local ExperienceBar = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LevelBar"):WaitForChild("Experience")
    currentexp = tonumber(ExperienceBar.text:split("/")[1])
    previousexp = tonumber(ExperienceBar.text:split("/")[1])
    previouslevel = tonumber(ExperienceBar.text:split("/")[2]:sub(1, -4))
    warn(currentexp, previousexp, previouslevel)

    getgenv().ExpTracker = ExperienceBar:GetPropertyChangedSignal("Text"):Connect(function(text)
        a, b = pcall(function()
            if CharacterAlive == false then
                getgenv().ExpTracker:Disconnect()
                return
            end

            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then
                getgenv().ExpTracker:Disconnect()
                return
            end

            if text == "0/100" then
                return
            end

            exp = tonumber(ExperienceBar.text:split("/")[1])
            level = tonumber(ExperienceBar.text:split("/")[2]:sub(1, -4))



            if currentexp < previousexp then
                wait(.2)
                print("[Current exp] " .. currentexp .." is less than [Previous Exp] "..previousexp)
                print(level, previouslevel, CharacterAlive)
                if level < previouslevel then
                    print("Level Down: ".. level - previouslevel)
                    leveldown = true
                else
                    leveldown = false
                end

                if level > previouslevel then
                    levelup = true
                else
                    levelup = false
                end

                if level == previouslevel then
                    expsame = true
                else
                    expsame = false
                end

                if levelup then
                    leveluptrack += 1
                    print("Level up: " .. level - previouslevel)
                    previouslevel = level

                    currentexp = tonumber(ExperienceBar.text:split("/")[1])
                    previousexp = tonumber(ExperienceBar.text:split("/")[1])


                end

                if expsame and not levelup or leveldown then
                    print("Exp decreased")
                    expreset += 1
                    lostexp += previousexp - currentexp
                    currentexp = tonumber(ExperienceBar.text:split("/")[1])
                    previousexp = currentexp
                end
            end

            previousexp = currentexp
            currentexp = tonumber(ExperienceBar.text:split("/")[1])
            if currentexp > previousexp then
                totalexp += currentexp - previousexp
            end
        end)
        if b then
            print(a, b)
        end
    end)
end

task.spawn(function()
    getgenv().Player = game.Players.LocalPlayer.CharacterAdded:Connect(function(Character)
        Exp()
    end)
    Exp()
end)


task.spawn(function()
    while wait(1) do
        xseconds += 1
        xmins = xseconds/60
    end
end)


task.spawn(function()
    while wait(10) do
        TotalExpPerMin = totalexp/xmins
        LostExpPerMin = lostexp/xmins
        levelaverage = level/xmins

        --print"[-------"
        --warn("Level: " .. level .. " Current: ".. currentexp .." Previous: " .. previousexp .. " Total Exp: " .. totalexp)
        --warn("Gained: ".. currentexp - previousexp)
        --warn("Lost Exp: ", lostexp)
        --print"-------"
        --warn("Exp Per Min: ", TotalExpPerMin)
        --warn("Times exp was lowered: ", expreset)
        --warn("Level Ups: ", leveluptrack)
        --print"-------]"
        --print(xmins)
    end
end)






----END TRACKER
