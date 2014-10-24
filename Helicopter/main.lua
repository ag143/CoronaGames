-- kiwi Game
-- Developed by Timothy Lok
utils = require("utils");
-- Hide Status Bar

display.setStatusBar(display.HiddenStatusBar)

-- Initial startup info.
os.execute("cls");

utils:log("main", "ASTRO RESCUE STARTING...");
utils:log("main", "Environment: " .. system.getInfo("environment"));
utils:log("main", "Model: " .. system.getInfo("model"));
utils:log("main", "Device ID: " .. system.getInfo("deviceID"));
utils:log("main", "Platform Name: " .. system.getInfo("platformName"));
utils:log("main", "Platform Version: " .. system.getInfo("version"));
utils:log("main", "Corona Version: " .. system.getInfo("version"));
utils:log("main", "Corona Build: " .. system.getInfo("build"));
utils:log("main", "display.contentWidth: " .. display.contentWidth);
utils:log("main", "display.contentHeight: " .. display.contentHeight);
utils:log("main", "display.fps: " .. display.fps);
utils:log("main", "audio.totalChannels: " .. audio.totalChannels);

-- Require the storyboard API and go to the menu scene
local storyboard = require "storyboard"
storyboard.gotoScene( "menu" )
-- END:mainMenuScene
