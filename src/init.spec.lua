type Context = {
    sgui: ScreenGui;
    textLabel: TextLabel;
};

return function()
    local TypeWriter = require(script.Parent);

    beforeAll(function(context: Context)
        context.sgui = Instance.new("ScreenGui");
        context.sgui.Name = "TEST_TypeWriter";
        context.sgui.ResetOnSpawn = false;

        context.textLabel = Instance.new("TextLabel");
        context.textLabel.AnchorPoint = Vector2.new(0.5,0.5);
        context.textLabel.TextSize = 20;
        context.textLabel.Size = UDim2.new(0.4,0,0.3,0);
        context.textLabel.Position = UDim2.new(0.5,0,0.5,0);
        context.textLabel.Parent = context.sgui;

        context.sgui.Parent = game.Players.LocalPlayer.PlayerGui;
    end);

    local writer: TypeWriter.TypeWriter;

    it("should create a TypeWriter object",function(context: Context)
        writer = TypeWriter.new("Some test content to be typed out.");
        writer.TargetElement = context.textLabel;
        writer.TypeInterval = 0.2;
        expect(writer).to.be.ok();
    end);

    it("should be able to skip the TypeWriter",function()
        writer:Write();
        writer:SkipSync();
        expect(writer.TargetElement.Text).to.be.equal(writer.Content);
    end);

    it("should be able to stop the TypeWriter",function()
        writer:Write();
        writer:StopSync();
        expect(writer._isWriting).to.be.equal(false);
    end);

    it ("should be able to start writing with the TypeWriter",function()
        writer:Write();
        writer.Finished:Wait();
        expect(writer._isWriting).to.be.equal(false);
    end);

    it("should be able to clean up the TypeWriter",function()
        writer:Destroy();
        writer = nil::any;
    end);
end