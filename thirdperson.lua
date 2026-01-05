-- Lua 表示用（色付きで見やすい）
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- 元設定保存
local originalMin = player.CameraMinZoomDistance
local originalMax = player.CameraMaxZoomDistance
local originalMode = player.CameraMode

local enabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 30, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(20,20,22)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- バツボタン
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = frame.BackgroundColor3
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200,200,200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
