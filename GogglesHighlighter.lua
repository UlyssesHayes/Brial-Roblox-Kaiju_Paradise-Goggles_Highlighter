--[[
	<Goggles Highlighter>

    Copyright (C) 1999-2026 Brial,Inc. 

    Author: Dr.U-H
    Version: 0.0.2

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.

	Online script loader:
	loadstring(game:HttpGet("https://raw.githubusercontent.com/UlyssesHayes/Brial-Roblox-Kaiju_Paradise-Goggles_Highlighter/main/GogglesHighlighter.lua"))()
	
	!!!Disclaimer!!!
	This script is for educational purposes only.
	Using cheats, exploits, or automation scripts in Roblox may violate Roblox's Terms of Service and can result in your account being permanently banned.
	You are fully responsible for any actions taken using this script. Use at your own risk.
]]

local workspace = game:GetService("Workspace")
local targetName = "Goggles"
local className = "MeshPart"
local highlightFillColor = Color3.new(0.819608, 0.4, 1)
local highlightFillTransparency = 0.3
local highlightOutlineColor = Color3.new(1, 0, 0)
local highlightOutlineTransparency = 0
local highlightDepthMode = Enum.HighlightDepthMode.AlwaysOnTop

local function addHighlight(instance)
	local highlight = Instance.new("Highlight")
	highlight.Parent = workspace
	highlight.Adornee = instance
	highlight.DepthMode = highlightDepthMode
	highlight.FillColor = highlightFillColor
	highlight.FillTransparency = highlightFillTransparency
	highlight.OutlineColor = highlightOutlineColor
	highlight.OutlineTransparency = highlightOutlineTransparency
	
	print("Added highlight to object: " .. instance:GetFullName())
	return highlight
end

local function checkAndAddHighlight(obj)
	if obj.Name == targetName and obj:IsA(className) then
		local existingHighlight = obj:FindFirstChild("Highlight")
		if not existingHighlight then
			addHighlight(obj)
		end
	end
end

local function scanExistingObjects()
	local allObjects = workspace:GetDescendants()
	local foundCount = 0
	
	for _, obj in ipairs(allObjects) do
		if obj.Name == targetName and obj:IsA(className) then
			checkAndAddHighlight(obj)
			foundCount = foundCount + 1
		end
	end
	
	print("Initial scan completed, processed " .. foundCount .. " " .. targetName)
end

workspace.DescendantAdded:Connect(function(obj)
	task.wait()
	checkAndAddHighlight(obj)
end)

workspace.DescendantAdded:Connect(function(obj)
	obj:GetPropertyChangedSignal("Name"):Connect(function()
		if obj.Name == targetName and obj:IsA(className) then
			checkAndAddHighlight(obj)
		end
	end)
end)

scanExistingObjects()
print("Highlight listener started, waiting for new " .. targetName .. " objects...")