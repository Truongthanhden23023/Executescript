-- LocalScript: Tạo giao diện nhập script, thực thi và thêm tab để ẩn/hiện khung nhập script

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo một ScreenGui để chứa các thành phần UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Khung nhập script
local scriptInputBox = Instance.new("TextBox")
scriptInputBox.Size = UDim2.new(0, 400, 0, 200)
scriptInputBox.Position = UDim2.new(0.5, -200, 0.6, 0)
scriptInputBox.PlaceholderText = "Dán script vào đây"
scriptInputBox.Multiline = true
scriptInputBox.TextSize = 14
scriptInputBox.Visible = false  -- Khởi tạo ẩn khung nhập script
scriptInputBox.Parent = screenGui

-- Nút để thực thi script
local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 400, 0, 50)
executeButton.Position = UDim2.new(0.5, -200, 0.85, 0)
executeButton.Text = "Thực thi script"
executeButton.TextSize = 18
executeButton.Visible = false  -- Khởi tạo ẩn nút thực thi script
executeButton.Parent = screenGui

-- Nút thêm tab (hiển thị/ẩn khung nhập script)
local tabButton = Instance.new("TextButton")
tabButton.Size = UDim2.new(0, 300, 0, 50)
tabButton.Position = UDim2.new(0.5, -150, 0.2, 0)
tabButton.Text = "Thêm Tab"
tabButton.TextSize = 18
tabButton.Parent = screenGui

-- Hàm thực thi script dán vào
local function executeScript(scriptText)
    if scriptText ~= "" then
        local func, err = loadstring(scriptText)  -- Dùng loadstring để nạp script
        if func then
            -- Nếu không có lỗi, thực thi script
            pcall(func)
        else
            -- Nếu có lỗi, hiển thị lỗi
            print("Lỗi khi thực thi script: " .. err)
        end
    else
        print("Không có script để thực thi!")
    end
end

-- Kết nối sự kiện khi người chơi nhấn nút thực thi script
executeButton.MouseButton1Click:Connect(function()
    local scriptText = scriptInputBox.Text
    executeScript(scriptText)  -- Thực thi script dán vào
    scriptInputBox.Text = ""  -- Xóa TextBox sau khi thực thi
end)

-- Kết nối sự kiện khi người chơi nhấn nút thêm tab (hiển thị/ẩn khung nhập script)
tabButton.MouseButton1Click:Connect(function()
    if scriptInputBox.Visible then
        scriptInputBox.Visible = false  -- Ẩn khung nhập script
        executeButton.Visible = false  -- Ẩn nút thực thi script
    else
        scriptInputBox.Visible = true  -- Hiện khung nhập script
        executeButton.Visible = true  -- Hiện nút thực thi script
    end
end)
