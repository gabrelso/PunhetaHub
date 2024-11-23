-- SUPPOSED TO ASSIST PEOPLE WITH RAIDS 
-- Made by lv7gab, don't sue my ass.

local vim = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

local shiftLockApplied = false

local function pressShift()
    vim:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
end

local function setupShiftLock()
    if not shiftLockApplied then
        task.wait(5)
        if getgenv().AutoShiftlock then
            pressShift()
            shiftLockApplied = true
        end
    end
end

if LocalPlayer.Character then
    setupShiftLock()
end

LocalPlayer.CharacterAdded:Connect(setupShiftLock)
