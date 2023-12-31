--!strict

local T_GoodSignal = require(script["@types"].GoodSignal);
export type GoodSignal = T_GoodSignal.GoodSignal;

export type Schema_TypeWriter = {
    __index: Schema_TypeWriter,
    _WriterStates: WriterStates,
    ClassName: "TypeWriter",

    GetDefaultSoundID: () -> string,
    SetSoundID: (id: string) -> (),
    SetPlaybackSpeed: (speed: number) -> (),
    new: (content: string) -> TypeWriter,
    SetContent: (self: TypeWriter,content: string) -> (),
    Write: (self: TypeWriter) -> (),
    Skip: (self: TypeWriter) -> (),
    SkipSync: (self: TypeWriter) -> (),
    Stop: (self: TypeWriter) -> (),
    StopSync: (self: TypeWriter) -> (),
    Destroy: (self: TypeWriter) -> ()
};

type WriterStates = {
    Finished: "Finished",
    Skipped: "Skipped",
    Stopped: "Stopped"
};

type WriterState = "Finished" | "Skipped" | "Stopped";

type TypeWriterObj = {
    _isWriting: boolean,
    _isSkipped: boolean?,
    _isDestroyed: boolean?,
    _thread: thread?,
    _state: WriterState,
    SFXEnabled: boolean,
    Content: string,
    TargetElement: TextLabel?,
    TypeInterval: number,
    MatchSFX: boolean?,
    Finished: GoodSignal,
    Skipped: GoodSignal,
    Stopped: GoodSignal
};

export type TypeWriter = typeof(setmetatable({} :: TypeWriterObj,{} :: Schema_TypeWriter));


local DEFAULT_TYPE_SFX: string = "rbxassetid://9120300060";
local LogPrefix: string = "[TypeWriter]:";

local TypeSound: Sound = script.TypeSound;
TypeSound.SoundId = DEFAULT_TYPE_SFX;

local GoodSignal = require(script.Parent.GoodSignal) :: T_GoodSignal.Schema_GoodSignal;

--[=[
    @class TypeWriter

    A module that allows simulating a Type Writer effect on a given TextLabel Instance.
]=]
local TypeWriter: Schema_TypeWriter = {} :: Schema_TypeWriter;
TypeWriter.__index = TypeWriter;

--[=[
    @interface IWriterStates
    @within TypeWriter
    @private
    .Finished "Finished" -- The TypeWriter was finished
    .Skipped "Skipped" -- The TypeWriter was skipped
    .Stopped "Stopped" -- The TypeWriter was stopped externally
]=]

--[=[
    The possible last running states of the TypeWriter.

    @type WriterState "Finished" | "Skipped | "Stopped"
    @within TypeWriter
    @private
]=]

local WriterStates: WriterStates = {
    Finished = "Finished",
    Skipped = "Skipped",
    Stopped = "Stopped"
};
--[=[
    This is an enum-like table containing the TypeWriter's last running state.

    @prop WriterStates IWriterStates
    @within TypeWriter
    @tag enum-like
    @private
]=]
TypeWriter._WriterStates = WriterStates;

--[=[
    The ClassName of this class.

    @prop ClassName "TypeWriter"
    @within TypeWriter
]=]
TypeWriter.ClassName = "TypeWriter";

--[=[
    Gets the default TypeWriter type sound effect.
]=]
function TypeWriter.GetDefaultSoundID(): string
    return DEFAULT_TYPE_SFX;
end

--[=[
    Sets the [Sound.SoundId] of the 'TypeSound' Sound Instance to the given id.
]=]
function TypeWriter.SetSoundID(id: string)
    TypeWriter.SetPlaybackSpeed(1);
    TypeSound.SoundId = id;
end

--[=[
    Allows changing the playback speed of the 'TypeSound' Sound Instance.
    This helps control [TypeWriter.MatchSFX].
]=]
function TypeWriter.SetPlaybackSpeed(speed: number)
    TypeSound.PlaybackSpeed = math.clamp(speed,0,20);
end

--[=[
    Creates a new TypeWriter object.

    @param content string -- The string content that the TypeWriter will process.
    @return TypeWriter
]=]
function TypeWriter.new(content: string) : TypeWriter
    -- #region OBJ_DOC

        --[=[
            An internal property that contains the writing state of the TypeWriter.

            @prop _isWriting boolean
            @within TypeWriter
            @private
        ]=]

        --[=[
            An internal property that tracks when the TypeWriter should be skipped.

            @prop _isSkipped boolean?
            @within TypeWriter
            @private
        ]=]

        --[=[
            An internal property that tracks when the TypeWriter has been destroyed.

            @prop _isDestroyed boolean?
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
            An internal property that stores the last running state of the TypeWriter.

            @prop _state WriterState
            @within TypeWriter
            @private
        ]=]

        --[=[
            Whether the TypeWriter type SFX is enabled or not. Defaults to true.

            @prop SFXEnabled boolean
            @within TypeWriter
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
            Whether the TypeWriter TypeInterval should instead be based off the 'TypeSound' aligning the type with the sound. Defaults to false.
            :::caution
            I haven't managed to get this to function properly but it is something I will try to improve so for now
            it is better to just do manual timing with playback speed modifiers.
            :::

            @prop MatchSFX boolean?
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
        _state = WriterStates.Stopped,
        SFXEnabled = true,
        Content = content or "",
        TypeInterval = 0.1,
        Finished = GoodSignal.new(),
        Skipped = GoodSignal.new(),
        Stopped = GoodSignal.new(),
    };

    self._thread = coroutine.create(function()

        local writer: TypeWriter = self::TypeWriter;

        while not writer._isDestroyed do
            writer._isWriting = true;

            local target: TextLabel = writer.TargetElement;
            local _content: string = writer.Content;
            local contLen: number = #_content;

            for i = 1,contLen do

                -- If the object is destroyed stop the writer now
                if writer._isDestroyed then break; end

                if not writer._isWriting then
                    writer._state = WriterStates.Stopped;
                    writer.Stopped:Fire();
                    break;
                end

                if writer._isSkipped then
                    writer._isSkipped = false;

                    if target then
                        target.Text = writer.Content;
                    end

                    writer._state = WriterStates.Skipped;
                    writer.Skipped:Fire();
                    break;
                elseif target then
                    if writer.SFXEnabled then
                        -- Play type sound for client
                        if not TypeSound.IsLoaded then
                            TypeSound.Loaded:Wait();
                        end
                        TypeSound:Play();

                        if writer.MatchSFX and TypeSound.Playing then
                            TypeSound.Ended:Wait();
                        end
                        target.Text = target.Text.._content:sub(i,i);
                    else
                        target.Text = target.Text.._content:sub(i,i);
                    end
                end

                if i == contLen then
                    writer._state = WriterStates.Finished;
                    writer.Finished:Fire();
                else
                    task.wait(writer.MatchSFX and 0 or writer.TypeInterval);
                end
            end

            writer._isWriting = false;
            coroutine.yield();
        end
    end);

    return setmetatable(self,TypeWriter);
end

--[=[
    Sets the content of the TypeWriter safely preventing old content from overlapping with new content.
    :::info
    This method does yield because of an internal [TypeWriter:StopSync]\() call.
    :::
    @param content string -- The new content to update to the TypeWriter.
    @yields
]=]
function TypeWriter:SetContent(content: string)
    self:StopSync();
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

    if not self.Content or #self.Content == 0 then
        warn(`{LogPrefix} Cannot Write() since Content Length is invalid or empty.`);
        return;
    end

    if self._thread and coroutine.status(self._thread) == "suspended" then
        self.TargetElement.Text = "";
        assert(coroutine.resume(self._thread));
    end
end

--[=[
    Skips the [TypeWriter] content processing displaying all content immediately.

    :::caution
    When using this async function, you must be aware that if you are to skip
    the [TypeWriter] processing you must make sure you don't call [TypeWriter:Write]\()
    until the [TypeWriter.Skipped] event is called or that duration between the next write
    is greater than the [TypeWriter.TypeInterval].
    :::
]=]
function TypeWriter:Skip()
    if self._isWriting then
        self._isSkipped = true;
    end
end

--[=[
    Skips the [TypeWriter] content processing displaying all content immediately.

    :::note
    This method yields until the TypeWriter's thread has yielded.
    :::
    @yields
]=]
function TypeWriter:SkipSync()
    if self._isWriting then
        self._isSkipped = true;
        repeat task.wait() until not self._isWriting and coroutine.status(self._thread) == "suspended";
    end
end

--[=[
    Stops the [TypeWriter] haulting it's thread.

    :::info
    This method will shortly yield until the thread is haulted
    :::
    :::caution
    When using this async function, you must be aware that if you are to stop
    the [TypeWriter] processing you must make sure you don't call [TypeWriter:Write]\()
    until the [TypeWriter.Stopped] event is called or that duration between the next write
    is greater than the [TypeWriter.TypeInterval].
    :::
]=]
function TypeWriter:Stop()
    self._isWriting = false;
end

--[=[
    Stops the [TypeWriter] haulting it's thread.

    :::info
    This method will shortly yield until the thread is haulted
    :::
    :::tip
    If you want to stop the TypeWriter permanently without yielding you can use [TypeWriter:Destroy]\()
    :::
    @yields
]=]
function TypeWriter:StopSync()
    if self._isWriting then
        self._isWriting = false;
        repeat task.wait() until not self._isWriting and coroutine.status(self._thread) == "suspended";
    end
end

--[=[
    Destroys the [TypeWriter] cleaning up resources.
    :::caution
    When you are finished with the [TypeWriter],
    remember to call [TypeWriter:Destroy]\().
    :::
]=]
function TypeWriter:Destroy()
    self._isDestroyed = true;
    self._isWriting = false;

    if self._thread then
        task.defer(function(writer: TypeWriter)
            -- Yield until the thread is suspended
            repeat task.wait();
            until (not writer._thread or coroutine.status(writer._thread) == "suspended");

            if writer._thread then
                coroutine.close(writer._thread);
                writer._thread = nil;
            end

            -- I need to clean up the events here since they are fired within the writer thread
            if writer.Finished then
                writer.Finished:DisconnectAll();
                writer.Finished = nil::any;
            end
            if writer.Skipped then
                writer.Skipped:DisconnectAll();
                writer.Skipped = nil::any;
            end
            if writer.Stopped then
                writer.Stopped:DisconnectAll();
                writer.Stopped = nil::any;
            end

            writer.TargetElement = nil;
        end,self);
    end
end

-- Set to this speed to work better with default 'TypeSound'.
TypeWriter.SetPlaybackSpeed(1.7);

return TypeWriter::Schema_TypeWriter;