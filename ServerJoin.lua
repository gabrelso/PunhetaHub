local TeleportService = game:GetService("TeleportService")

local Sea = getgenv().Sea
local JobID = getgenv().JobID

local PlaceID

if Sea == "1st" then
    PlaceID = 4520749081
elseif Sea == "2nd" then
    PlaceID = 6381829480
elseif Sea == "3rd" then
    PlaceID = 15759515082
else
    print("Invalid Sea selection.")
    return
end

if game.PlaceId ~= PlaceID then
    return
end

local function JoinServer()
    while getgenv().Enabled do
        task.wait(1)
        
        if game.JobId ~= JobID then
            print("Attempting to teleport to JobID:", JobID)
            TeleportService:TeleportToPlaceInstance(PlaceID, JobID)
        else
            print("Already in the correct server.")
        end
    end
end

JoinServer()
