local PlaceID
local TeleportService = game:GetService("TeleportService")

if Sea == "1st" then
    PlaceID = 4520749081
elseif Sea == "2nd" then
    PlaceID = 6381829480
elseif Sea == "3rd" then
    PlaceID = 15759515082
end

if not PlaceID then
    error("PlaceID is not set correctly.")
end

if not JobID or JobID == "" then
    error("JobID is not valid.")
end

if game.PlaceId ~= PlaceID then
    return
end

local function JoinServer()
    while getgenv().Enabled do
        task.wait(1)
        if game.JobId ~= JobID then
            print("Attempting to teleport to:", PlaceID, "with JobID:", JobID)
            TeleportService:TeleportToPlaceInstance(PlaceID, JobID)
        end
    end
end

JoinServer()
