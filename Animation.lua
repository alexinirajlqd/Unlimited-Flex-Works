-- LocalScript para cargar animación de KJ
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función para ejecutar el módulo de tu jugador
local function loadModule()
    local success, err = pcall(function()
        require(18808399962).load(player.Name)
    end)
    if not success then
        warn("[LocalScript] Error al ejecutar el módulo: "..tostring(err))
    end
end

-- Ejecutar cuando el personaje aparezca
player.CharacterAdded:Connect(function(char)
    loadModule()
end)

-- Ejecutar si el personaje ya estaba cargado al correr el script
if player.Character then
    loadModule()
end

print("[LocalScript] Módulo preparado para el jugador "..player.Name)
