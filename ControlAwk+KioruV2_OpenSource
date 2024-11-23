-- STILL A BETA CONCEPT, UPDATES MAY COME SOON.
-- Made by lv7gab



local lp = game.Players.LocalPlayer
local _wait = task.wait
local vim = game:GetService("VirtualInputManager") 
getgenv().M1 = true

if game.PlaceId ~= 5931540094 then
    return
end

repeat wait() until game:IsLoaded()

local function waitForCharacter()
    repeat wait() until lp.Character
end

local args = {
    [1] = "DF_OpOp_Z",
    [2] = {
        ["Type"] = "Down",
        ["MouseHit"] = CFrame.new(-85.37010955810547, 36.08258056640625, 82.8070297241211) * CFrame.Angles(-3.1415927410125732, 0.009515480138361454, -3.1415927410125732)
    }
}

local args1 = {
    [1] = "DF_OpOp_Z",
    [2] = {
        ["Type"] = "Up",
        ["MouseHit"] = CFrame.new(-84.68488311767578, 36.08258056640625, 82.40946197509766) * CFrame.Angles(-3.1415927410125732, -0.8224099278450012, -3.1415927410125732)
    }
}

local function aimAtBoss(bossName)
    local boss = workspace.MOB:FindFirstChild(bossName)
    if boss and boss:FindFirstChild("HumanoidRootPart") then
        local argsM1 = {
            [1] = "SW_Kioru V2_M1",
            [2] = {
                ["MouseHit"] = boss.HumanoidRootPart.CFrame
            }
        }
        game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer(unpack(argsM1))
    end
end

local function loopM1()
    while getgenv().M1 do
        _wait(0.1)
        local bossList = {
            "Shadowthorn Cruelty",
            "Voidpull Adept",
            "Octoros the Deepsea Enforcer",
            "Deepsea Tyrant, Karkul",
            "Eldritch Crab" 
        }
        for _, bossName in ipairs(bossList) do
            if workspace.MOB:FindFirstChild(bossName) then
                aimAtBoss(bossName)
                break
            end
        end
    end
end

local function equipTool()
    while true do
        _wait(0.1)
        local backpack = lp:FindFirstChild("Backpack")
        if backpack then
            local tool = backpack:FindFirstChild("OpOp")
            if tool then
                lp.Character.Humanoid:EquipTool(tool)
            end
        end
    end
end

local function ensureHasRoom()
    while true do
        _wait(0.1)
        local roomName = "OpeRoom" .. lp.Name
        if not workspace:FindFirstChild(roomName) then
            game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer(unpack(args))
        end
    end
end

local function autoUp()
    while true do
        _wait(0.1)
        game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer(unpack(args1))
    end
end

local eventTriggered = false

local function handleCharacterAdded(character)
    if not eventTriggered then
        game:GetService("ReplicatedStorage").Chest.Remotes.Events.Armament:FireServer()
        print("Armament event triggered.")
        
        game:GetService("ReplicatedStorage").Chest.Remotes.Events.Armament.OnClientEvent:Connect(function()
            print("Armament event activated")
            eventTriggered = true
        end)
    end
end

lp.CharacterAdded:Connect(function(character)
    eventTriggered = false
    waitForCharacter()
    handleCharacterAdded(character)

    spawn(function()
        equipTool()
    end)
    spawn(function()
        autoUp()
    end)
    spawn(function()
        ensureHasRoom()
    end)
    spawn(function()
        loopM1()
    end)
end)

game.Players.PlayerAdded:Connect(function(player)
    if player == lp then
        eventTriggered = false
        waitForCharacter()
        handleCharacterAdded(player.Character)
    end
end)
