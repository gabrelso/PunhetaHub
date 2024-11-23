-- SUPPOSED TO ASSIST PEOPLE WITH RAIDS 
-- Made by lv7gab, don't sue my ass.

local lp = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local _wait = task.wait
local shiftLockApplied = false

local function pressShift()
    vim:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
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
    applyShiftLock()
end

if lp.Character then
    handleCharacterSpawn()
end

lp.CharacterAdded:Connect(function()
    handleCharacterSpawn()
end)
