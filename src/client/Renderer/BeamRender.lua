local BeamRender = {}

BeamRender.inteface = {}
BeamRender.schema = {}
BeamRender.metatable = { __index = BeamRender }

local Point = require(script.Parent.Parent.Physics.Point)
type Point = Point.Point
local Beam = require(script.Parent.Parent.Physics.Beam)
type Beam = Beam.Beam
local PointRender = require(script.Parent.PointRender)
type PointRender = PointRender.PointRender

local BridgeGui = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("BridgeGui")

function BeamRender.interface.new(P1: Vector2 | PointRender,  P2: Vector2 | PointRender, Thickness: number)
	local self = {}

	if typeof(P1) == Vector2 then
		self.Point1Render = PointRender.new(P1)
	else
		self.Point1Render = P1
	end
	if typeof(P2) == Vector2 then
		self.Point2Render = PointRender.new(P2)
	else
		self.Point2Render = P2
	end
    self.Point1 = self.Point1Render.Point
    self.Point2 = self.Point2Render.Point

	self.Beam = Beam.new(self.Point1, self.Point2)

	local Element = Instance.new("Frame")
	local Position = (self.Point2.Position - self.Point1.Position) / 2 + self.Point1.Position
	local Rotation = math.deg(math.atan2(self.Point2.Position.Y - Position.X, self.Point2.Position.X - Position.X))
	local Size = (self.Point2.Position - self.Point1.Position).Magnitude
	Element.Position = UDim2.fromOffset(Position.X, Position.Y)
	Element.Orientation = Rotation
	Element.Size = UDim2.fromOffset(Size, Thickness)

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim2.new(1, 0)
	UICorner.Parent = Element

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint = Element
	Element.Parent = BridgeGui

	self.Element = Element

	return setmetatable(self, BeamRender)
end
function BeamRender.schema:Update()
	self.Beam:Update()
	local Position = (self.Point2.Position - self.Point1.Position) / 2 + self.Point1.Position
	local Rotation = math.deg(math.atan2(self.Point2.Position.Y - Position.X, self.Point2.Position.X - Position.X))
	local Size = (self.Point2.Position - self.Point1.Position).Magnitude
	self.Element.Position = UDim2.fromOffset(Position.X, Position.Y)
	self.Element.Orientation = Rotation
	self.Element.Size = UDim2.fromOffset(Size, self.Element.Size.Y.Offset)
end
export type BeamRender = typeof(BeamRender.interface.new(table.unpack(...)))
return BeamRender.inteface
