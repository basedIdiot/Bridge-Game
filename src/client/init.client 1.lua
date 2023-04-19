--[[
local BeamRender = require(script.Parent.Renderer.BeamRender)

local UserInputService = game:GetService("UserInputService")

local IsPlacing = false
local OriginPointPosition = nil
local OriginPoint = nil

local function OnClick(event)
    if (not IsPlacing) then return end
    if OriginPoint then

    end
end
UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
	if GameProcessedEvent then
		return
	end
	if Input.KeyCode == Enum.KeyCode.B then
		IsPlacing = not IsPlacing
	elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
		if OriginPoint then
			local Beam = BeamRender.new(OriginPoint, Input.Position)
            Beam.Point1Render.Element.MouseButton1:Connect(function(Input)
                if (not IsPlacing) then return end
                if OriginPoint then
                    local Beam = BeamRender.new()
                end
            end)
			OriginPointPosition = nil
		else
			OriginPointPosition = Input.Position
		end
	end
end)
]]