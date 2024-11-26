if game.PlaceId ~= 5931540094 then
    return
end

local lp = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local _wait = task.wait

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

repeat wait() until game:IsLoaded()

local function pressShift()
    vim:SendKeyEvent(true, "LeftShift", false, game)
    vim:SendKeyEvent(false, "LeftShit", false, game)
end

