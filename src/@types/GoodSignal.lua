export type Schema_Connection = {
    __index: Schema_Connection,

    new: (signal: GoodSignal,fn: (...any) -> ()) -> (),
    Disconnect: (self: Connection) -> ()
};

export type Connection = typeof(setmetatable({} :: {
    _connected: boolean,
    _signal: GoodSignal,
    _fn: (...any) -> (),
    _next: Connection | false
},{} :: Schema_Connection));

export type Schema_GoodSignal = {
    __index: Schema_GoodSignal,

    new: () -> GoodSignal,
    Connect: (self: GoodSignal,fn: () -> ()) -> Connection,
    DisconnectAll: (self: GoodSignal) -> (),
    Fire: (self: GoodSignal,...any) -> (),
    Wait: (self: GoodSignal) -> any,
    Once: (self: GoodSignal,fn: (...any) -> ()) -> Connection
};

export type GoodSignal = typeof(setmetatable({} :: {
    _handlerListHead: boolean
},{} :: Schema_GoodSignal));
return nil;