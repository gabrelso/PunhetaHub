local Library = {}

function Library:MakePrototypeLibrary(Title)
    local GUI = {}
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Title or "CustomLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
    MainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
    MainFrame.Parent = ScreenGui

    GUI.MainFrame = MainFrame

    function GUI:MakeTab(Name, DefaultOpen)
        local Tab = {}

        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = Name .. "Button"
        TabButton.Text = Name
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(85, 0, 127)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Parent = MainFrame

        -- Tab Content
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = Name .. "Frame"
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
        TabFrame.Visible = DefaultOpen or false
        TabFrame.Parent = MainFrame

        function Tab:Info(Text)
            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Text = Text
            InfoLabel.Size = UDim2.new(1, 0, 0, 30)
            InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.Parent = TabFrame
        end

        function Tab:Button(Text, Callback)
            local Button = Instance.new("TextButton")
            Button.Text = Text
            Button.Size = UDim2.new(1, 0, 0, 50)
            Button.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.GothamBold
            Button.Parent = TabFrame

            Button.MouseButton1Click:Connect(Callback)
        end

        function Tab:Toggle(Text, Callback)
            local Toggle = Instance.new("TextButton")
            Toggle.Text = Text
            Toggle.Size = UDim2.new(1, 0, 0, 50)
            Toggle.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.Font = Enum.Font.GothamBold
            Toggle.Parent = TabFrame

            local toggled = false
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                Callback(toggled)
            end)
        end

        return Tab
    end

    return GUI
end

return Library
