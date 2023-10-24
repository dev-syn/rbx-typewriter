for i = 4,1 do
    warn(`Tests will begin in {i} seconds.`)
    task.wait(1);
end
local TestEZ = require(script.Parent.Packages.TestEZ);
TestEZ.TestBootstrap:run({ script.Parent.Packages.TypeWriter });