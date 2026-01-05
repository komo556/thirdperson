local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

local originalMin = player.CameraMinZoomDistance
local originalMax = player.CameraMaxZoomDistance
local originalMode = player.CameraMode
local enabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui") -- CoreGui ではなく PlayerGui に入れる
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

closeBtn.MouseEnter:Connect(function()
	closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
end)
closeBtn.MouseLeave:Connect(function()
	closeBtn.TextColor3 = Color3.fromRGB(200,200,200)
end)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ON/OFF ボタン
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 40)
button.Font = Enum.Font.GothamBold
button.TextSize = 15
button.AutoButtonColor = false
Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)

local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function fadeButton(bgColor, textColor)
	TweenService:Create(button, tweenInfo, {
		BackgroundColor3 = bgColor,
		TextColor3 = textColor
	}):Play()
end

local function apply(on)
	if on then
		player.CameraMode = Enum.CameraMode.Classic
		player.CameraMinZoomDistance = 12
		player.CameraMaxZoomDistance = 12
		cam.CameraType = Enum.CameraType.Custom
		button.Text = "Third Person : ON"
		fadeButton(Color3.fromRGB(245,245,245), Color3.fromRGB(20,20,22))
	else
		player.CameraMode = originalMode
		player.CameraMinZoomDistance = originalMin
		player.CameraMaxZoomDistance = originalMax
		button.Text = "Third Person : OFF"
		fadeButton(Color3.fromRGB(25,25,28), Color3.fromRGB(230,230,230))
	end
end

apply(false)

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	apply(enabled)
end)

-- ドラッグ対応
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
