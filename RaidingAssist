local enabled = true -- Enabling the script, false = disabled.
local autoSkip = true -- Enable auto skip, false = disabled.
local raidMode = "Hard" -- Choose raid to select (Hard, Normal, and Easy)

while enabled do task.wait(0.5)
    local gyatt = {
        [1] = raidMode
    }
    game:GetService("ReplicatedStorage").ChooseMapRemote:FireServer(unpack(gyatt))
    game:GetService("ReplicatedStorage").GoldenArenaEvents.StartEvent:FireServer()
    
    if autoSkip then
        game:GetService("ReplicatedStorage").GoldenArenaEvents.SkipFunc:InvokeServer()
    end
end
