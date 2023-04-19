local PointRender = {}

PointRender.interface = {}
PointRender.schema = {}
PointRender.metatable = { __index = PointRender }

local Point = require(script.Parent.Parent.Physics.Point)
type Point = Point.Point

local BridgeGui = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("BridgeGui")

local PointRenderArray = {}
function PointRender.interface.new(Position: Vector2, Size: number)
	local self = {}

	self.Point = Point.new(Position)

	local Element = Instance.new("Frame")
	Element.Position = UDim2.fromOffset(Vector2.X, Vector2.Y)
	Element.Size = UDim2.fromOffset(Size, Size)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim2.new(1, 0)
	UICorner.Parent = Element

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint = Element
	Element.Parent = BridgeGui

	self.Element = Element
    PointRenderArray[Element] = self

	return setmetatable(self, PointRender)
end
function PointRender.interface.getFromElement(Element)
    return PointRenderArray[Element]
end
function PointRender.schema:Update()
	self.Point:Update()
	self:SetPosition(self.Point.Position)
end
function PointRender.schema:SetSize(Size: number)
	self.Element.Size = UDim2.fromOffset(Size, Size)
end
function PointRender.schema:SetPosition(Position: Vector2)
	self.Element.Position = UDim2.fromOffset(Vector2.X, Vector2.Y)
end
type PointRender = typeof(PointRender.interface.new(table.unpack(...)))
return PointRender.interface
