
local Library = {}

function Library:MakePrototypeLibrary(Title)
    local GUI = {}
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 19, 24)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Title Label
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Text = Title or "Library UI"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextColor3 = Color3.fromRGB(175, 161, 253)
    TitleLabel.TextSize = 24
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 20, 0, 10)
    TitleLabel.Size = UDim2.new(0, 200, 0, 30)
    TitleLabel.Parent = MainFrame

    -- Tabs Holder
    local TabsHolder = Instance.new("Frame")
    TabsHolder.Name = "TabsHolder"
    TabsHolder.BackgroundTransparency = 1
    TabsHolder.Position = UDim2.new(0, 20, 0, 50)
    TabsHolder.Size = UDim2.new(0, 150, 1, -60)
    TabsHolder.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabsHolder

    local TabContent = Instance.new("Frame")
    TabContent.Name = "TabContent"
    TabContent.BackgroundTransparency = 1
    TabContent.Position = UDim2.new(0, 180, 0, 50)
    TabContent.Size = UDim2.new(1, -190, 1, -60)
    TabContent.Parent = MainFrame

    function GUI:MakeTab(Name, OpenByDefault)
        local Tab = {}
        
        -- Create Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = Name .. "TabButton"
        TabButton.Text = Name
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 18
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Parent = TabsHolder

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = TabButton

        local TabFrame = Instance.new("Frame")
        TabFrame.Name = Name .. "Content"
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.Visible = OpenByDefault or false
        TabFrame.Parent = TabContent

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Padding = UDim.new(0, 10)
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Parent = TabFrame

        TabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(TabContent:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            TabFrame.Visible = true
        end)

        function Tab:Info(Text)
            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Text = Text
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            InfoLabel.TextSize = 18
            InfoLabel.BackgroundTransparency = 1
            InfoLabel.Size = UDim2.new(1, 0, 0, 30)
            InfoLabel.Parent = TabFrame
        end

        function Tab:Button(Text, Callback)
            local Button = Instance.new("TextButton")
            Button.Text = Text
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 18
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.Parent = TabFrame

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                Callback()
            end)
        end

        function Tab:Toggle(Text, Callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Parent = TabFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Text = Text
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 18
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
            ToggleLabel.Parent = ToggleFrame

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Text = "Off"
            ToggleButton.Font = Enum.Font.Gotham
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 18
            ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            ToggleButton.Size = UDim2.new(0.2, 0, 1, 0)
            ToggleButton.Position = UDim2.new(0.8, 0, 0, 0)
            ToggleButton.Parent = ToggleFrame

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = ToggleButton

            local Toggled = false
            ToggleButton.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                ToggleButton.Text = Toggled and "On" or "Off"
                Callback(Toggled)
            end)
        end

        return Tab
    end

    return GUI
end

return Library
