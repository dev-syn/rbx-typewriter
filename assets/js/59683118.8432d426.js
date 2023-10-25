"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[835],{56500:e=>{e.exports=JSON.parse('{"functions":[{"name":"GetDefaultSoundID","desc":"Gets the default TypeWriter type sound effect.","params":[],"returns":[{"desc":"","lua_type":"string\\r\\n"}],"function_type":"static","source":{"line":109,"path":"src/init.lua"}},{"name":"SetSoundID","desc":"Sets the [Sound.SoundId] of the \'TypeSound\' Sound Instance to the given id.","params":[{"name":"id","desc":"","lua_type":"string"}],"returns":[],"function_type":"static","source":{"line":116,"path":"src/init.lua"}},{"name":"SetPlaybackSpeed","desc":"Allows changing the playback speed of the \'TypeSound\' Sound Instance.\\nThis helps control [TypeWriter.MatchSFX].","params":[{"name":"speed","desc":"","lua_type":"number"}],"returns":[],"function_type":"static","source":{"line":125,"path":"src/init.lua"}},{"name":"new","desc":"Creates a new TypeWriter object.","params":[{"name":"content","desc":"The string content that the TypeWriter will process.","lua_type":"string"}],"returns":[{"desc":"","lua_type":"TypeWriter"}],"function_type":"static","source":{"line":135,"path":"src/init.lua"}},{"name":"SetContent","desc":"Sets the content of the TypeWriter safely preventing old content from overlapping with new content.\\n:::info\\nThis method does yield because of an internal [TypeWriter:StopSync]\\\\() call.\\n:::","params":[{"name":"content","desc":"The new content to update to the TypeWriter.","lua_type":"string"}],"returns":[],"function_type":"method","yields":true,"source":{"line":330,"path":"src/init.lua"}},{"name":"Write","desc":"Starts the TypeWriter which will start processing the content.","params":[],"returns":[],"function_type":"method","source":{"line":338,"path":"src/init.lua"}},{"name":"Skip","desc":"Skips the [TypeWriter] content processing displaying all content immediately.\\n\\n:::caution\\nWhen using this async function, you must be aware that if you are to skip\\nthe [TypeWriter] processing you must make sure you don\'t call [TypeWriter:Write]\\\\()\\nuntil the [TypeWriter.Skipped] event is called or that duration between the next write\\nis greater than the [TypeWriter.TypeInterval].\\n:::","params":[],"returns":[],"function_type":"method","source":{"line":375,"path":"src/init.lua"}},{"name":"SkipSync","desc":"Skips the [TypeWriter] content processing displaying all content immediately.\\n\\n:::note\\nThis method yields until the TypeWriter\'s thread has yielded.\\n:::","params":[],"returns":[],"function_type":"method","yields":true,"source":{"line":389,"path":"src/init.lua"}},{"name":"Stop","desc":"Stops the [TypeWriter] haulting it\'s thread.\\n\\n:::info\\nThis method will shortly yield until the thread is haulted\\n:::\\n:::caution\\nWhen using this async function, you must be aware that if you are to stop\\nthe [TypeWriter] processing you must make sure you don\'t call [TypeWriter:Write]\\\\()\\nuntil the [TypeWriter.Stopped] event is called or that duration between the next write\\nis greater than the [TypeWriter.TypeInterval].\\n:::","params":[],"returns":[],"function_type":"method","source":{"line":409,"path":"src/init.lua"}},{"name":"StopSync","desc":"Stops the [TypeWriter] haulting it\'s thread.\\n\\n:::info\\nThis method will shortly yield until the thread is haulted\\n:::\\n:::tip\\nIf you want to stop the TypeWriter permanently without yielding you can use [TypeWriter:Destroy]\\\\()\\n:::","params":[],"returns":[],"function_type":"method","yields":true,"source":{"line":424,"path":"src/init.lua"}},{"name":"Destroy","desc":"Destroys the [TypeWriter] cleaning up resources.\\n:::caution\\nWhen you are finished with the [TypeWriter],\\nremember to call [TypeWriter:Destroy]\\\\().\\n:::","params":[],"returns":[],"function_type":"method","source":{"line":438,"path":"src/init.lua"}}],"properties":[{"name":"WriterStates","desc":"This is an enum-like table containing the TypeWriter\'s last running state.","lua_type":"IWriterStates","tags":["enum-like"],"source":{"line":96,"path":"src/init.lua"}},{"name":"ClassName","desc":"The ClassName of this class.","lua_type":"\\"TypeWriter\\"","source":{"line":104,"path":"src/init.lua"}},{"name":"_isWriting","desc":"An internal property that contains the writing state of the TypeWriter.\\n\\n        ","lua_type":"boolean","private":true,"source":{"line":145,"path":"src/init.lua"}},{"name":"_isSkipped","desc":"An internal property that tracks when the TypeWriter should be skipped.\\n\\n        ","lua_type":"boolean?","private":true,"source":{"line":153,"path":"src/init.lua"}},{"name":"_isDestroyed","desc":"An internal property that tracks when the TypeWriter has been destroyed.\\n\\n        ","lua_type":"boolean?","private":true,"source":{"line":161,"path":"src/init.lua"}},{"name":"_thread","desc":"An internal property that contains the TypeWriter\'s working Thread.\\n\\n        ","lua_type":"thread?","private":true,"source":{"line":169,"path":"src/init.lua"}},{"name":"_state","desc":"An internal property that stores the last running state of the TypeWriter.\\n\\n        ","lua_type":"WriterState","private":true,"source":{"line":177,"path":"src/init.lua"}},{"name":"SFXEnabled","desc":"Whether the TypeWriter type SFX is enabled or not. Defaults to true.\\n\\n        ","lua_type":"boolean","source":{"line":184,"path":"src/init.lua"}},{"name":"Content","desc":"The content that will be typed through the TypeWriter.\\n:::warning\\nThis is intended to be read-only if you wish to change the content use [TypeWriter:SetContent].\\n:::\\n\\n        ","lua_type":"string","readonly":true,"source":{"line":195,"path":"src/init.lua"}},{"name":"TargetElement","desc":"The TextLabel Instance that the TypeWriter will feed letters to.\\n\\n        ","lua_type":"TextLabel?","source":{"line":202,"path":"src/init.lua"}},{"name":"TypeInterval","desc":"The interval at which letters are typed. Defaults to (0.1, 1/10 of a second).\\n\\n        ","lua_type":"number","source":{"line":209,"path":"src/init.lua"}},{"name":"MatchSFX","desc":"Whether the TypeWriter TypeInterval should instead be based off the \'TypeSound\' aligning the type with the sound. Defaults to false.\\n:::caution\\nI haven\'t managed to get this to function properly but it is something I will try to improve so for now\\nit is better to just do manual timing with playback speed modifiers.\\n:::\\n\\n        ","lua_type":"boolean?","source":{"line":220,"path":"src/init.lua"}},{"name":"Finished","desc":"This event is fired when the TypeWriter has finished processing the content.\\n\\n        ","lua_type":"GoodSignal","tags":["event"],"source":{"line":228,"path":"src/init.lua"}},{"name":"Skipped","desc":"This event is fired when the TypeWriter processing effect is skipped.\\n\\n        ","lua_type":"GoodSignal","tags":["event"],"source":{"line":236,"path":"src/init.lua"}},{"name":"Stopped","desc":"This event is fired when the TypeWriter has stopped because of abnormal reasons.\\n\\n        ","lua_type":"GoodSignal","tags":["event"],"source":{"line":244,"path":"src/init.lua"}}],"types":[{"name":"IWriterStates","desc":"","fields":[{"name":"Finished","lua_type":"\\"Finished\\"","desc":"The TypeWriter was finished"},{"name":"Skipped","lua_type":"\\"Skipped\\"","desc":"The TypeWriter was skipped"},{"name":"Stopped","lua_type":"\\"Stopped\\"","desc":"The TypeWriter was stopped externally"}],"private":true,"source":{"line":75,"path":"src/init.lua"}},{"name":"WriterState","desc":"The possible last running states of the TypeWriter.","lua_type":"\\"Finished\\" | \\"Skipped | \\"Stopped\\"","private":true,"source":{"line":83,"path":"src/init.lua"}}],"name":"TypeWriter","desc":"A module that allows simulating a Type Writer effect on a given TextLabel Instance.","source":{"line":64,"path":"src/init.lua"}}')}}]);