"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[331],{3905:(e,t,r)=>{r.d(t,{Zo:()=>c,kt:()=>d});var n=r(67294);function i(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function a(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function o(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?a(Object(r),!0).forEach((function(t){i(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):a(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,n,i=function(e,t){if(null==e)return{};var r,n,i={},a=Object.keys(e);for(n=0;n<a.length;n++)r=a[n],t.indexOf(r)>=0||(i[r]=e[r]);return i}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(n=0;n<a.length;n++)r=a[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(i[r]=e[r])}return i}var p=n.createContext({}),s=function(e){var t=n.useContext(p),r=t;return e&&(r="function"==typeof e?e(t):o(o({},t),e)),r},c=function(e){var t=s(e.components);return n.createElement(p.Provider,{value:t},e.children)},u="mdxType",h={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},y=n.forwardRef((function(e,t){var r=e.components,i=e.mdxType,a=e.originalType,p=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),u=s(r),y=i,d=u["".concat(p,".").concat(y)]||u[y]||h[y]||a;return r?n.createElement(d,o(o({ref:t},c),{},{components:r})):n.createElement(d,o({ref:t},c))}));function d(e,t){var r=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var a=r.length,o=new Array(a);o[0]=y;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l[u]="string"==typeof e?e:i,o[1]=l;for(var s=2;s<a;s++)o[s]=r[s];return n.createElement.apply(null,o)}return n.createElement.apply(null,r)}y.displayName="MDXCreateElement"},76647:(e,t,r)=>{r.r(t),r.d(t,{contentTitle:()=>o,default:()=>u,frontMatter:()=>a,metadata:()=>l,toc:()=>p});var n=r(87462),i=(r(67294),r(3905));const a={},o="TypeWriter",l={type:"mdx",permalink:"/rbx-typewriter/",source:"@site/pages/index.md",title:"TypeWriter",description:"A Roblox module designed to simulate a Type Writer effect on a TextLabel Instance.",frontMatter:{}},p=[{value:"Creating a TypeWriter",id:"creating-a-typewriter",level:2},{value:"Start writing with the TypeWriter",id:"start-writing-with-the-typewriter",level:2},{value:"Skipping a TypeWriter",id:"skipping-a-typewriter",level:2},{value:"Stopping a TypeWriter",id:"stopping-a-typewriter",level:2},{value:"What is the difference between the skip &amp; stop normal and synchronous methods?",id:"what-is-the-difference-between-the-skip--stop-normal-and-synchronous-methods",level:2},{value:"Changing the TypeWriter&#39;s content",id:"changing-the-typewriters-content",level:2},{value:"TypeWriter Events",id:"typewriter-events",level:2}],s={toc:p},c="wrapper";function u(e){let{components:t,...r}=e;return(0,i.kt)(c,(0,n.Z)({},s,r,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("h1",{id:"typewriter"},"TypeWriter"),(0,i.kt)("p",null,"A Roblox module designed to simulate a Type Writer effect on a TextLabel Instance."),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Set your own interval at which the characters are typed"),(0,i.kt)("li",{parentName:"ul"},"Play a custom sound for each individual TypeWriter object")),(0,i.kt)("h2",{id:"creating-a-typewriter"},"Creating a TypeWriter"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},'local TypeWriter = require(script.Parent.TypeWriter);\ntype TypeWriter = TypeWriter.TypeWriter;\n\nlocal writer: TypeWriter = TypeWriter.new(\n    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, \n    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."\n);\n')),(0,i.kt)("h2",{id:"start-writing-with-the-typewriter"},"Start writing with the TypeWriter"),(0,i.kt)("p",null,"To begin writing with the TypeWriter it's as simple as calling :Write()."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},"-- This will begin writing the content into the TargetElement.\nwriter:Write();\n")),(0,i.kt)("h2",{id:"skipping-a-typewriter"},"Skipping a TypeWriter"),(0,i.kt)("p",null,"If you wish to implement a skip button for an npc dialogue or similar purposes,\nyou can ",(0,i.kt)("inlineCode",{parentName:"p"},"writer:Skip()")," the TypeWriter causing the effect to end displaying all content at once."),(0,i.kt)("p",null,"There are 2 methods of skipping the TypeWriter:"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},"writer:Skip();\nwriter:SkipSync();\n")),(0,i.kt)("h2",{id:"stopping-a-typewriter"},"Stopping a TypeWriter"),(0,i.kt)("p",null,"You can externally stop the TypeWriter for any reasons."),(0,i.kt)("p",null,"It follows the similar conventions of ",(0,i.kt)("inlineCode",{parentName:"p"},"writer:Skip()"),":"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},"writer:Stop();\nwriter:StopSync();\n")),(0,i.kt)("h2",{id:"what-is-the-difference-between-the-skip--stop-normal-and-synchronous-methods"},"What is the difference between the skip & stop normal and synchronous methods?"),(0,i.kt)("p",null,"The sole purpose of the synchronous variants is for cases where you need to stop the TypeWriter to change\nthe content like in ",(0,i.kt)("inlineCode",{parentName:"p"},"writer:SetContent()")," and you want to write the new content\nstraight away after the TypeWriter's thread has been fully suspended."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},"writer:Write();\nwriter:StopSync(); -- This method yields until the TypeWriter is ready for re-processing.\nwriter:Write(); -- Meaning this Write can be called immediately after.\n")),(0,i.kt)("p",null,(0,i.kt)("strong",{parentName:"p"},"HOWEVER")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},"writer:Write();\nwriter:Stop();\nwriter:Write();\n")),(0,i.kt)("p",null,"See the problem is that the TypeWriter's thread wouldn't of been haulted by the next ",(0,i.kt)("inlineCode",{parentName:"p"},"writer:Write()"),"\nleading to the original thread not being suspended ignoring your ",(0,i.kt)("inlineCode",{parentName:"p"},"writer:Write()")," call."),(0,i.kt)("p",null,"The reason that the sync variant is not default is because this is really only an issue when\nyour immediately trying to write upon a skip or stop."),(0,i.kt)("p",null,"Realistically, if you were to run the time from the skip/stop + ",(0,i.kt)("inlineCode",{parentName:"p"},"writer.TypeInterval")," it would be safe to do this without yielding to begin with."),(0,i.kt)("p",null,(0,i.kt)("inlineCode",{parentName:"p"},"NOTE:")," This could change in the future possibly."),(0,i.kt)("h2",{id:"changing-the-typewriters-content"},"Changing the TypeWriter's content"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-lua"},'writer:Write();\n-- This internally calls writer:StopSync() allowing you to change the content and re-run the TypeWriter.\nwriter:SetContent("The new content to write through the TypeWriter");\nwriter:Write();\n')),(0,i.kt)("h2",{id:"typewriter-events"},"TypeWriter Events"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"writer.Finished:")," This event is fired when the TypeWriter has finished writing it's content."),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"writer.Skipped:")," This event is fired when the TypeWriter was skipped."),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"writer.Stopped:")," This event is fired when the TypeWriter has been stopped externally.")))}u.isMDXComponent=!0}}]);