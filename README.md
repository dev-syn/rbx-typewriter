# TypeWriter

A Roblox module designed to simulate a Type Writer effect on a TextLabel Instance.

- Set your own interval at which the characters are typed
- Play a custom sound for each individual TypeWriter object


## Creating a TypeWriter

```lua
local TypeWriter = require(script.Parent.TypeWriter);
type TypeWriter = TypeWriter.TypeWriter;

local writer: TypeWriter = TypeWriter.new(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
);
```
## Start writing with the TypeWriter
To begin writing with the TypeWriter it's as simple as calling :Write().
```lua
-- This will begin writing the content into the TargetElement.
writer:Write();
```
## Skipping a TypeWriter
If you wish to implement a skip button for an npc dialogue or similar purposes,
you can `writer:Skip()` the TypeWriter causing the effect to end displaying all content at once.

There are 2 methods of skipping the TypeWriter:
```lua
writer:Skip();
writer:SkipSync();
```

## Stopping a TypeWriter
You can externally stop the TypeWriter for any reasons.

It follows the similar conventions of `writer:Skip()`:
```lua
writer:Stop();
writer:StopSync();
```

## What is the difference between the skip & stop normal and synchronous methods?
The sole purpose of the synchronous variants is for cases where you need to stop the TypeWriter to change
the content like in `writer:SetContent()` and you want to write the new content
straight away after the TypeWriter's thread has been fully suspended.

```lua
writer:Write();
writer:StopSync(); -- This method yields until the TypeWriter is ready for re-processing.
writer:Write(); -- Meaning this Write can be called immediately after.
```

**HOWEVER**

```lua
writer:Write();
writer:Stop();
writer:Write();
```

See the problem is that the TypeWriter's thread wouldn't of been haulted by the next `writer:Write()`
leading to the original thread not being suspended ignoring your `writer:Write()` call.

The reason that the sync variant is not default is because this is really only an issue when
your immediately trying to write upon a skip or stop.

Realistically, if you were to run the time from the skip/stop + `writer.TypeInterval` it would be safe to do this without yielding to begin with.

`NOTE:` This could change in the future possibly.

## Changing the TypeWriter's content
```lua
writer:Write();
-- This internally calls writer:StopSync() allowing you to change the content and re-run the TypeWriter.
writer:SetContent("The new content to write through the TypeWriter");
writer:Write();
```

## TypeWriter Events

- `writer.Finished:` This event is fired when the TypeWriter has finished writing it's content.
- `writer.Skipped:` This event is fired when the TypeWriter was skipped.
- `writer.Stopped:` This event is fired when the TypeWriter has been stopped externally.