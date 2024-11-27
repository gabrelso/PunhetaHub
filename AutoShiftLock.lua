while true do
    if workspace.MOB and workspace.MOB:FindFirstChild("Shadowthorn Cruelty") then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftShift", false, game)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftShift", false, game)
        break
    end
    task.wait(1)
end
