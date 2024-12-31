local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LPCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = LPCharacter:FindFirstChild("HumanoidRootPart")
local vim = game:GetService("VirtualInputManager")
local firePP = fireproximityprompt
local ValueGun = "AK-47"
local ValueItem = "C4"

-- // TOGGLE GUI BUTTON
local g = game:GetService("CoreGui") local b = Instance.new("ImageButton", Instance.new("ScreenGui", g)) b.Size, b.Position, b.Image, b.BackgroundTransparency, b.Draggable = UDim2.new(0, 40, 0, 40), UDim2.new(0, 10, 0, 10), "rbxassetid://119583487171484", 1, true b.MouseButton1Click:Connect(function() local v = game:GetService("VirtualInputManager") v:SendKeyEvent(true, "LeftControl", false, game) v:SendKeyEvent(false, "LeftControl", false, game) end)

local function buyGun(ValueGun)
    if ValueGun then
        local currentPos = LPCharacter.HumanoidRootPart.CFrame
        RootPart.CFrame = CFrame.new(-145.54664611816406, 32.023048400878906, 504.881103515625)
        local args = { [1] = "GunShop", [2] = "Buy", [3] = ValueGun }
        game:GetService("ReplicatedStorage").Assets.Remotes.ClientPurchases:FireServer(unpack(args))
        task.wait(1)
        local args1 = { [1] = "GunShop", [2] = "Equip", [3] = ValueGun }
        game:GetService("ReplicatedStorage").Assets.Remotes.ClientPurchases:FireServer(unpack(args1))
        task.wait(2)
        RootPart.CFrame = currentPos
    end
end

local function buyItem(ValueItem)
    if ValueItem == "Cartão de Acesso" then
        ValueItem = "Cart\195\163o de Acesso"
        if ValueItem then
            local currentPos = LPCharacter.HumanoidRootPart.CFrame
            RootPart.CFrame = CFrame.new(-920.1470336914062, 49.0120964050293, 584.1889038085938)
            task.wait(0.5)
            local args = { [1] = "IlegalShop", [2] = "Buy", [3] = ValueItem }
            game:GetService("ReplicatedStorage").Assets.Remotes.ClientPurchases:FireServer(unpack(args))
            task.wait(3)
            RootPart.CFrame = currentPos
        end
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Pipizinho Hub " .. Fluent.Version,
    SubTitle = "E.B(osta) do Tevez",
    TabWidth = 160,
    Size = UDim2.fromOffset(560, 360),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "crown" }),
    Roubo = Window:AddTab({ Title = "Roubo", Icon = "landmark" }),
    Extra = Window:AddTab({ Title = "Extra", Icon = "plus" }),
    Configuracoes = Window:AddTab({ Title = "Configurações", Icon = "settings" })
}

local Dropdown = Tabs.Main:AddDropdown("DropdownGun", {
    Title = "Selecione a arma",
    Values = { "AK-47", "AS VAL", "GLOCK 18", "GLOCK 41", "G36C", "FG42", "FAL", "M4A1", "MP-40", "MPT-76", "HK", "Shotgun" },
    Multi = false,
    Default = 1,
})

Dropdown:OnChanged(function(valueGun)
    ValueGun = valueGun
end)

Tabs.Main:AddButton({
    Title = "Comprar arma",
    Description = "Selecione uma arma antes, AK-47 por padrão",
    Callback = function()
        buyGun(ValueGun)
    end
})

local Dropdown1 = Tabs.Main:AddDropdown("DropdownItem", {
    Title = "Selecione o item",
    Values = { "Cartão de Acesso", "C4" },
    Multi = false,
    Default = 2,
})

Dropdown1:OnChanged(function(valueItem)
    ValueItem = valueItem
end)

Tabs.Main:AddButton({
    Title = "Comprar item",
    Description = "Selecione um item antes, C4 por padrão",
    Callback = function()
        buyItem(ValueItem)
    end
})

Tabs.Roubo:AddButton({
    Title = "Abrir cofre do Banco",
    Description = "Precisa ter 1800 de dinheiro",
    Callback = function()
        if workspace.Map.Robberies.Bank.StatusDisplay.SurfaceGui.TextLabel.Text == "ABERTO" then
            print("O banco está aberto")
            local hasC4 = LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("C4")
            if not hasC4 then
                print("O jogador não possui a C4")
                RootPart.CFrame = CFrame.new(-920.1470336914062, 49.0120964050293, 584.1889038085938)
                task.wait(1)
                local args = { [1] = "IlegalShop", [2] = "Buy", [3] = "C4" }
                game:GetService("ReplicatedStorage").Assets.Remotes.ClientPurchases:FireServer(unpack(args))
                print("C4 possivelmente comprada")
                task.wait(2.5)
                hasC4 = LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("C4")
            end
            if hasC4 then
                print("O jogador possui a C4, abrindo o cofre...")
                RootPart.CFrame = CFrame.new(65.00437927246094, 15.69315242767334, 40.79336166381836)
                task.wait(0.5)
                LocalPlayer.Backpack.C4.Parent = LPCharacter
                task.wait(0.5)
                firePP(workspace.Map.Robberies.Bank.VaultDoor.C4.Handle.ProximityPrompt)
            end
        else
            Fluent:Notify({ Title = "Notificação", Content = "O banco está fechado", Duration = 3 })
        end
    end
})

Tabs.Roubo:AddButton({
    Title = "Coletar dinheiro",
    Description = "Coleta dinheiro do banco",
    Callback = function()
        if workspace.Map.Robberies.Bank.StatusDisplay.SurfaceGui.TextLabel.Text ~= "ABERTO" then
            Fluent:Notify({ Title = "Notificação", Content = "O banco está fechado", Duration = 3 })
        else
            for i = 1, 21 do
                RootPart.CFrame = CFrame.new(49.04157257080078, 16.36208724975586, 38.68148422241211)
                task.wait(0.1)
                RootPart.CFrame = CFrame.new(52.017982482910156, 16.36208724975586, 38.7944221496582)
                task.wait(0.1)
            end
        end
    end
})

Tabs.Roubo:AddButton({
    Title = "Vender dinheiro sujo",
    Description = "Vende seu dinheiro para o NPC",
    Callback = function()
        local currentPos = RootPart.CFrame
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(14, 1, 14)
        platform.Position = Vector3.new(-591.3465576171875, 19.09320068359375, 347.91058349609375)
        platform.Anchored = true
        platform.BrickColor = BrickColor.new("Medium stone grey")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Parent = workspace
        RootPart.CFrame = CFrame.new(-591.3465576171875, 22.09320068359375, 347.91058349609375)
        task.wait(0.5)
        local args = { [1] = "CollectCash" }
        game:GetService("ReplicatedStorage").Assets.Remotes.Robbery:FireServer(unpack(args))
        task.wait(2.5)
        RootPart.CFrame = currentPos
    end
})

local AutoRunToggle = Tabs.Extra:AddToggle("AutoRunToggle", {
    Title = "Manter corrida",
    Description = "Mantém o boneco correndo",
    Default = false
})

AutoRunToggle:OnChanged(function(value)
    while value do
        task.wait(0.3)
        local humanoid = LPCharacter:FindFirstChild("Humanoid")
        if humanoid and humanoid.WalkSpeed == 16 then
            humanoid.WalkSpeed = 24
        end
    end
end)

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("EBScriptHub")
SaveManager:SetFolder("EBScriptHub/EBdoTevez")
InterfaceManager:BuildInterfaceSection(Tabs.Configuracoes)
SaveManager:BuildConfigSection(Tabs.Configuracoes)
SaveManager:LoadAutoloadConfig()
