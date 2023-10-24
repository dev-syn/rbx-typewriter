--!strict

local T_GoodSignal = require(script["@types"].GoodSignal);
type GoodSignal = T_GoodSignal.GoodSignal;

local GoodSignal = require(script.Parent.GoodSignal) :: T_GoodSignal.Schema_GoodSignal;

--[=[
    @class TypeWriter

    A module that allows simulating a Type Writer effect on a given TextLabel Instance.
]=]

export type Schema_TypeWriter = {
    __index: Schema_TypeWriter,
    ClassName: "TypeWriter",

    new: (content: string) -> TypeWriter,
    SetContent: (self: TypeWriter,content: string) -> (),
    Write: (self: TypeWriter) -> (),
    Skip: (self: TypeWriter) -> (),
    Stop: (self: TypeWriter) -> (),
    Destroy: (self: TypeWriter) -> ()
};

type TypeWriterObj = {
    _isWriting: boolean,
    _thread: thread?,
    Content: string?,
    TargetElement: TextLabel?,
    TypeInterval: number,
    Finished: GoodSignal,
    Skipped: GoodSignal,
    Stopped: GoodSignal
};

export type TypeWriter = typeof(setmetatable({} :: TypeWriterObj,{} :: Schema_TypeWriter));

local LogPrefix: string = "[TypeWriter]:";

local TypeWriter: Schema_TypeWriter = {} :: Schema_TypeWriter;
TypeWriter.__index = TypeWriter;

--[=[
    The ClassName of this class.

    @prop ClassName "TypeWriter"
    @within TypeWriter
]=]
TypeWriter.ClassName = "TypeWriter";

--[=[
    Creates a new TypeWriter object.

    @param content string -- The string content that the TypeWriter will process.
    @return TypeWriter
]=]
function TypeWriter.new(content: string) : TypeWriter
    -- #region OBJ_DOCS
        --[=[
            An internal property that contains the writing state of the TypeWriter.

            @prop _isWriting boolean
            @within TypeWriter
            @private
        ]=]

        --[=[
            An internal property that contains the TypeWriter's working Thread.

            @prop _thread thread?
            @within TypeWriter
            @private
        ]=]

        --[=[
            The content that will be typed through the TypeWriter.
            :::warning
            This is intended to be read-only if you wish to change the content use [TypeWriter:SetContent].
            :::

            @prop Content string
            @within TypeWriter
            @readonly
        ]=]

        --[=[
            The TextLabel Instance that the TypeWriter will feed letters to.

            @prop TargetElement TextLabel?
            @within TypeWriter
        ]=]

        --[=[
            The interval at which letters are typed. Defaults to (0.1, 1/10 of a second).

            @prop TypeInterval number
            @within TypeWriter
        ]=]

        --[=[
            This event is fired when the TypeWriter has finished processing the content.

            @prop Finished GoodSignal
            @within TypeWriter
            @tag event
        ]=]

        --[=[
            This event is fired when the TypeWriter processing effect is skipped.

            @prop Skipped GoodSignal
            @within TypeWriter
            @tag event
        ]=]

        --[=[
            This event is fired when the TypeWriter has stopped because of abnormal reasons.

            @prop Stopped GoodSignal
            @within TypeWriter
            @tag event
        ]=]

    -- #endregion

    local self: TypeWriterObj = {
        _isWriting = false,
        Content = content or "",
        TypeInterval = 0.2,
        Finished = GoodSignal.new(),
        Skipped = GoodSignal.new(),
        Stopped = GoodSignal.new()
    };
    return setmetatable(self,TypeWriter);
end

--[=[
    Sets the content of the TypeWriter safely preventing old content from overlapping with new content.

    @param content string -- The new content to update to the TypeWriter.
]=]
function TypeWriter:SetContent(content: string)
    self:Stop();
    self.Content = content;
end

--[=[
    Starts the TypeWriter which will start processing the content.
]=]
function TypeWriter:Write()
    if self._isWriting then
        warn(`{LogPrefix} Could not Write() since the TypeWriter is already writing.`);
        return;
    end

    if not self.TargetElement then
        warn(`{LogPrefix} Could not Write() since no TargetElement has been set.`);
        return;
    end

    if self.TypeInterval <= 0 then
        warn(`{LogPrefix} Could not Write() since the TypeInterval must be greater than zero.`);
        return;
    end

    self.TargetElement.Text = "";

    if self._thread then
        coroutine.close(self._thread);
    end

    self._thread = coroutine.create(function()
        for i = 1, #self.Content do
            local char: string = self.Content:sub(i,i);
            self.TargetElement.Text = self.TargetElement.Text..char;
            task.wait(self.TypeInterval);
        end
        self.Finished:Fire();
    end);

    coroutine.resume(self._thread);
end

--[=[
    Skips the TypeWriter content processing displaying all content immediately.
]=]
function TypeWriter:Skip()
    if self._thread then
        coroutine.close(self._thread);
        self._thread = nil;
    end
    self._isWriting = false;
    self.TargetElement.Text = self.Content;
    self.Skipped:Fire();
end

--[=[
    Stops the TypeWriter closing it's thread and haulting the content stream.
]=]
function TypeWriter:Stop()
    if self._thread then
        coroutine.close(self._thread);
        self._thread = nil;
    end
    if self._isWriting then
        self.Stopped:Fire();
        self._isWriting = false;
    end
end

--[=[
    Destroys the TypeWriter cleaning up resources.
    :::note
    Remember to call `TypeWriter:Destroy()` when you are finished with the TypeWriter.
    :::
]=]
function TypeWriter:Destroy()
    -- Set _isWriting to false to avoid Stopped event from firing
    self._isWriting = false;
    self:Stop();

    if self.Finished then
        self.Finished:DisconnectAll();
        self.Finished = nil::any;
    end
    if self.Skipped then
        self.Skipped:DisconnectAll();
        self.Skipped = nil::any;
    end
    if self.Stopped then
        self.Stopped:DisconnectAll();
        self.Stopped = nil::any;
    end

    self.TargetElement = nil;
end

return TypeWriter::Schema_TypeWriter;