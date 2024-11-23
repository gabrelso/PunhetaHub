-- SUPPOSED TO ASSIST PEOPLE WITH RAIDS 
-- Made by lv7gab, don't sue my ass.

local lp = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local _wait = task.wait
local shiftLockApplied = false

local args = { [1] = "Hard" }
game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))

while getgenv().Enabled do
    task.wait(1)
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end

local function waitForCharacter()
    repeat _wait() until lp.Character and lp.Character:FindFirstChild("Humanoid")
end

local function applyShiftLock()
    if not shiftLockApplied and getgenv().AutoShiftlock then
        pressShift()
        shiftLockApplied = true
    end
end

local function handleCharacterSpawn()
    shiftLockApplied = false
    waitForCharacter()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftShift", false, game)
if lp.Character then
    handleCharacterSpawn()
end

lp.CharacterAdded:Connect(function()
    handleCharacterSpawn()
end)
