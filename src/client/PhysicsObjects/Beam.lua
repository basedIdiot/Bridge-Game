local Beam = {}

Beam.interface = {}
Beam.schema = {}
Beam.metatable = { __index = Beam }

function Beam.interface.new(P1, P2, DesiredLength, Stiffness, Dampening)
	local self = {}

	self.P1 = P1
	self.P2 = P2
	self.DesiredLength = DesiredLength
	self.Stiffness = Stiffness
	self.Dampening = Dampening

	return setmetatable(self, Beam)
end

function Beam.schema:Constrain(dt: number)
	local nabla_C1 = (P2.Position-P1.Position).Unit

	local gamma = self.Dampening/(dt*self.Stiffness)
	local lambda = (-((P2.Position-P1.Position).Magnitude-self.DesiredLength)-gamma*(self.Position-self.LastPosition))/((1 + gamma)*(1/self.P1.Mass+1/self.P2.Mass) + 1/(self.Stiffness*dt))

	self.P1.Position += lambda*nabla_C1/self.P1.Mass
	self.P2.Position -= lambda*nabla_C1/self.P2.Mass
end

return Beam