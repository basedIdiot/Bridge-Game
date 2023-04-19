local PhysicsSolver = {}
PhysicsSolver.SimulatedObjects = {}
PhysicsSolver.ExternalForce = {}
PhysicsSolver.Constraints = {}

local substeps = 5;

function PhysicsSolver.Update(dt:number)
    local dtSubsteps = dt/substeps
    for i = 1, substeps, 1 do
        for _,v in pairs(PhysicsSolver.SimulatedObjects) do
            local netExternalForce = Vector2.new(0,0);
            for _,vv in pairs(PhysicsSolver.ExternalForce[v]) do
                netExternalForce += vv
            end
            v:ResetConstraints(dtSubsteps,netExternalForce)
        end

        for _,v in pairs(PhysicsSolver.Constraints) do
            v:Constrain(dtSubsteps)
        end

        for _,v in pairs(PhysicsSolver.SimulatedObjects) do
            v:ApplyConstraints(dtSubsteps)
        end
    end
end

return PhysicsSolver