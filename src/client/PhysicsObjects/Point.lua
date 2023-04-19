local Point = {}

Point.interface = {}
Point.schema = {}
Point.metatable = { __index = Point }

function Point.interface.new(Mass: number, Position: Vector2, Velocity: Vector2)
	local self = {}

    self.Position = Position
    self.Velocity = Velocity
    self.Mass = Mass

    self.LastPosition;
    self.ConstrainPosition;

	return setmetatable(self, Point)
end

function Point.schema:ResetConstraints(dt: number, ExternalForce: Vector2?, ExternalImpulse: Vector2?)
    self.LastPosition = self.Position;
    self.Velocity = self.Velocity + ExternalImpulse + ExternalForce*dt
    self.Position = self.Position + self.Velocity*dt
    self.ConstrainPosition = self.Position
end

function Point.schema:ApplyConstraints(dt: number)
    self.Position = self.ConstrainPosition
    self.Velocity = (self.Position - self.LastPosition)/dt
end

return Point