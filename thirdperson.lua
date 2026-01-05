local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

local enabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.Name = "ThirdPersonGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0, 30, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(20,20,22)
frame.ZIndex = 1
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
closeBtn.ZIndex = 10

closeBtn.MouseEnter:Connect(function()
	closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
end)
closeBtn.MouseLeave:Connect(function()
	closeBtn.TextColor3 = Color3.fromRGB(200,200,200)
end)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ON/OFF ボタン（Third Person切替）
local tpButton = Instance.new("TextButton", frame)
tpButton.Size = UDim2.new(1, -20, 0, 40)
tpButton.Position = UDim2.new(0, 10, 0, 40)
tpButton.Font = Enum.Font.GothamBold
tpButton.TextSize = 15
tpButton.Text = "Third Person : OFF"
tpButton.AutoButtonColor = false
Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0,10)
tpButton.ZIndex = 9

local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function fadeButton(bgColor, textColor)
	TweenService:Create(tpButton, tweenInfo, {BackgroundColor3 = bgColor, TextColor3 = textColor}):Play()
end

local function apply(on)
	if on then
		player.CameraMode = Enum.CameraMode.Classic
		player.CameraMinZoomDistance = 12
		player.CameraMaxZoomDistance = 12
		cam.CameraType = Enum.CameraType.Custom
		tpButton.Text = "Third Person : ON"
		fadeButton(Color3.fromRGB(245,245,245), Color3.fromRGB(20,20,22))
	else
		player.CameraMode = Enum.CameraMode.Default
		player.CameraMinZoomDistance = 0.5
		player.CameraMaxZoomDistance = 400
		tpButton.Text = "Third Person : OFF"
		fadeButton(Color3.fromRGB(25,25,28), Color3.fromRGB(230,230,230))
	end
end

tpButton.MouseButton1Click:Connect(function()
	enabled = not enabled
	apply(enabled)
end)

-- 新しいボタン「nou tiktok.@nou__tan」
local nouButton = Instance.new("TextButton", frame)
nouButton.Size = UDim2.new(1, -20, 0, 30)
nouButton.Position = UDim2.new(0, 10, 0, 90)
nouButton.Font = Enum.Font.GothamBold
nouButton.TextSize = 14
nouButton.Text = "nou tiktok.@nou__tan"
nouButton.BackgroundColor3 = Color3.fromRGB(40,40,42)
nouButton.TextColor3 = Color3.fromRGB(230,230,230)
nouButton.AutoButtonColor = false
Instance.new("UICorner", nouButton).CornerRadius = UDim.new(0,8)
nouButton.ZIndex = 9

-- ホバーで少し明るくなる
nouButton.MouseEnter:Connect(function()
	nouButton.BackgroundColor3 = Color3.fromRGB(60,60,62)
end)
nouButton.MouseLeave:Connect(function()
	nouButton.BackgroundColor3 = Color3.fromRGB(40,40,42)
end)
nouButton.MouseButton1Click:Connect(function()
	print("nou button clicked!")  -- ここにクリック処理を追加可能
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
