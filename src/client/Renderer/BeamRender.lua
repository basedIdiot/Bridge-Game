local BeamRender = {}

BeamRender.inteface = {}
BeamRender.schema = {}
BeamRender.metatable = {__index = BeamRender}

local Point = require(script.Parent.Parent.Physics.Point)
type Point = Point.Point
local Beam = require(script.Parent.Parent.Physics.Beam)
type Beam = Beam.Beam

local BridgeGui = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("BridgeGui")

function BeamRender.interface.new(Point1 : Point, Point2: Point, Thickness: number)
    local self = {}

    self.Point1 = Point1
    self.Point2 = Point2

    self.Beam = Beam.new(Point1, Point2)

    local Element = Instance.new("Frame")
    local Position = (Point2.Position - Point1.Position) / 2 + Point1.Position
    local Rotation = math.deg(math.atan2(Point2.Position.Y - Position.X, Point2.Position.X - Position.X))
    local Size = (Point2.Position - Point1.Position).Magnitude
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
type BeamRender = typeof(BeamRender.interface.new(table.unpack(...)))
return BeamRender