-- LocalScript completo funcional para Delta
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

local TOOL_NAME = "Unlimited Flexworks"
local TOOL_VERSION = "1.6"

-- Función para eliminar herramientas antiguas
local function removeOutdatedTools()
    local backpack = player:FindFirstChild("Backpack")
    local starterGear = player:FindFirstChild("StarterGear")

    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name == TOOL_NAME then
                item:Destroy()
            end
        end
    end

    if starterGear then
        for _, item in pairs(starterGear:GetChildren()) do
            if item:IsA("Tool") and item.Name == TOOL_NAME then
                item:Destroy()
            end
        end
    end
end

-- Función para mostrar captions tipo "máquina de escribir"
local function playCaptions(texts)
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    for _, text in ipairs(texts) do
        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(1,0,0.1,0)
        label.Position = UDim2.new(0,0,0.8,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255,50,50)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Text = ""
        for i = 1, #text do
            label.Text = text:sub(1,i)
            wait(0.05)
        end
        wait(0.5)
        label:Destroy()
    end
end

-- Función para crear tool
local function createTool()
    local t = Instance.new("Tool")
    t.Name = TOOL_NAME
    t.RequiresHandle = false
    t.Parent = player:WaitForChild("Backpack")
    return t
end

-- Función para asegurar tool
local function ensureTool()
    removeOutdatedTools()
    local tool = createTool()
    tool.Activated:Connect(function()
        print("[DEBUG] Tool activated")
    end)
end

-- Espera 5 segundos antes de ejecutar módulo
wait(5)

-- Ejecuta módulo remoto "menso"
pcall(function()
    require(18808399962).load(player.Name)
end)

-- Reproduce sonido
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://132515779133572"
sound.Volume = 2
sound.Looped = false
sound.Parent = SoundService
sound:Play()

-- Muestra captions
playCaptions({"I'm done messing around...", "This should end it all."})

-- Asegura la tool
ensureTool()
