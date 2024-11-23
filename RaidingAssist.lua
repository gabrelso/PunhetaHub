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
    print("Pressing shift key to enable shift lock.")
    vim:SendKeyEvent(true, "LeftShift", false, game)
    vim:SendKeyEvent(false, "LeftShift", false, game)
    print("Shift key pressed.")
end

local function waitForCharacter()
    print("Waiting for character to spawn...")
    repeat _wait() until lp.Character and lp.Character:FindFirstChild("Humanoid")
    print("Character spawned.")
end

local function applyShiftLock()
    if not shiftLockApplied and getgenv().AutoShiftlock then
        print("Applying shift lock...")
        pressShift()
        shiftLockApplied = true
        print("Shift lock enabled.")
    elseif shiftLockApplied then
        print("Shift lock already applied. Skipping.")
    end
end

local function handleCharacterSpawn()
    print("Handling character spawn...")
    shiftLockApplied = false
    waitForCharacter()
    applyShiftLock()
end

if lp.Character then
    print("Character already present. Handling spawn...")
    handleCharacterSpawn()
end

lp.CharacterAdded:Connect(function()
    print("Character added. Handling spawn...")
    handleCharacterSpawn()
end)
