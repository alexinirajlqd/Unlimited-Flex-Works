local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Ejecuta cuando tu personaje aparezca
player.CharacterAdded:Connect(function(char)
    -- Esto llama al módulo externo para tu personaje
    require(18808399962).load(player.Name)
end)

-- Si el personaje ya está cargado al ejecutar el script
if player.Character then
    require(18808399962).load(player.Name)
end
