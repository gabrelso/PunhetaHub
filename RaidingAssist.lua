local lp = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local _wait = task.wait

local shiftLockApplied = false

local args = { [1] = "Hard" }

game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))

while getgenv().Enabled do
    _wait(1)
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(args))
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()

    if getgenv().AutoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end

local function pressShift()
    vim:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    _wait(0.1)
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
