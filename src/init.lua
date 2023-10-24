--!strict

type TypeWriterSchema = {
    __index: TypeWriterSchema,
    ClassName: "TypeWriter",
    new: (content: string) -> TypeWriter,
    Write: (self: TypeWriter) -> (),
    Skip: (self: TypeWriter) -> (),
    Stop: (self: TypeWriter) -> ()
};

type TypeWriterObj = {
    _isWriting: boolean,
    Content: string?,
    TargetElement: TextLabel?,
    TypeInterval: number?
};

type TypeWriter = typeof(setmetatable({} :: TypeWriterObj,{} :: TypeWriterSchema));

local LogPrefix: string = "[TypeWriter]:";

local TypeWriter: TypeWriterSchema = {} :: TypeWriterSchema;
TypeWriter.__index = TypeWriter;
TypeWriter.ClassName = "TypeWriter";

function TypeWriter.new(content: string) : TypeWriter
    local self: TypeWriterObj = {
        _isWriting = false,
        
    };
    return setmetatable(self,TypeWriter);
end

function TypeWriter:Write()
    if not self.TargetElement then
        warn(`{LogPrefix} Could not Write() since no TargetElement has been set.`);
        return;
    end

    self.TargetElement.Text = "";

    coroutine.wrap(function()
        
    end)();
end

function TypeWriter:Skip()

end

function TypeWriter:Stop()
    
end

return TypeWriter;