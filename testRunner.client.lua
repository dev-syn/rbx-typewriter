for i = 4,1,-1 do
    warn(`Tests will begin in {i} seconds.`)
    task.wait(1);
end

--[[
local TestEZ = require(script.Parent.Packages.TestEZ);
TestEZ.TestBootstrap:run({ script.Parent.Packages.TypeWriter });
--]]

local TypeWriter = require(script.Parent.Packages.TypeWriter);

local sgui: ScreenGui = Instance.new("ScreenGui");
sgui.Name = "TEST_TypeWriter";
sgui.ResetOnSpawn = false;

local textLabel: TextLabel = Instance.new("TextLabel");
textLabel.AnchorPoint = Vector2.new(0.5,0.5);
textLabel.TextSize = 20;
textLabel.Size = UDim2.new(0.4,0,0.3,0);
textLabel.Position = UDim2.new(0.5,0,0.5,0);
textLabel.Parent = sgui;

sgui.Parent = game.Players.LocalPlayer.PlayerGui;

warn("Create TypeWriter: ");
local writer: TypeWriter.TypeWriter = TypeWriter.new("Some test content to be typed out.");
writer.TargetElement = textLabel;
writer.TypeInterval = 0.2;

warn("Skip TypeWriter: ");
print("    Writing...");
writer:Write();
print("    Skipping...");
writer:SkipSync();
print("All Content Displayed: ",writer.TargetElement.Text == writer.Content)
print(coroutine.status(writer._thread));
task.wait(3);

warn("Stop TypeWriter: ");
print("    Writing...");
writer:Write();
print("    Stopping...");
writer:StopSync();
print(coroutine.status(writer._thread));

warn("Start TypeWriter: ");
print("    Writing...");
writer:Write();
writer.Finished:Wait();
print("    Finished...");
print(coroutine.status(writer._thread));

warn("Destroy TypeWriter: ");
writer:Destroy();
writer = nil::any;