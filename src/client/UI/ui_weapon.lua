local module = {}
local RunService = game:GetService("RunService")
local uiTmp = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("ui_weapon")
local ui:ScreenGui
local c_data_bag = require(script.Parent.Parent.c_data_bag)
module.isShow = false
module.asset = nil

function module.Show(flag:boolean, ...)
    module.isShow = flag
    local arg = {...}
    if flag then
        ui = uiTmp:Clone()
        ui.Parent = uiTmp.Parent
        ui.Enabled = true
        local Btn_buy_ring = ui:WaitForChild("ImageBack"):WaitForChild("ImageLabel"):WaitForChild("TextButton") :: TextButton
        local itemId = arg[1]
        local itemCount = c_data_bag.GetItemCount(itemId)
        if itemCount>0 then
            Btn_buy_ring.Text = "EQUIP"
            else
                Btn_buy_ring.Text = "Buy"
        end
        Btn_buy_ring.MouseButton1Click:Connect(function()
            print("btn click", arg[1])
            if itemCount>0 then

            else
                local MarketplaceService = game:GetService("MarketplaceService")
                local Players = game:GetService("Players")
                local Player = Players.LocalPlayer
                MarketplaceService:PromptProductPurchase(Player,itemId)
            end
            module.Show(false)
        end)
    else
        if ui then ui:Destroy() end
    end
end

RunService.Stepped:Connect(function(time, deltaTime)
    if not module.isShow then return end
    
end)

return module