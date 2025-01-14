-- LocalScript: Tạo giao diện nhập key, key generation mỗi 24 giờ, và thực thi script từ TextBox

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo một ScreenGui để chứa các thành phần UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Khung hiển thị key đã tạo
local generatedKeyLabel = Instance.new("TextLabel")
generatedKeyLabel.Size = UDim2.new(0, 300, 0, 50)
generatedKeyLabel.Position = UDim2.new(0.5, -150, 0.3, 0)
generatedKeyLabel.Text = "Key của bạn: " .. "Chưa có key"
generatedKeyLabel.TextSize = 18
generatedKeyLabel.Parent = screenGui

-- Khung nhập key
local keyInputBox = Instance.new("TextBox")
keyInputBox.Size = UDim2.new(0, 300, 0, 50)
keyInputBox.Position = UDim2.new(0.5, -150, 0.4, 0)
keyInputBox.PlaceholderText = "Nhập key của bạn"
keyInputBox.TextSize = 18
keyInputBox.Parent = screenGui

-- Nút để kiểm tra key
local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(0, 300, 0, 50)
checkButton.Position = UDim2.new(0.5, -150, 0.5, 0)
checkButton.Text = "Kiểm tra key"
checkButton.TextSize = 18
checkButton.Parent = screenGui

-- Khung nhập script
local scriptInputBox = Instance.new("TextBox")
scriptInputBox.Size = UDim2.new(0, 400, 0, 200)
scriptInputBox.Position = UDim2.new(0.5, -200, 0.6, 0)
scriptInputBox.PlaceholderText = "Dán script vào đây"
scriptInputBox.Multiline = true
scriptInputBox.TextSize = 14
scriptInputBox.Parent = screenGui

-- Nút để thực thi script
local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 400, 0, 50)
executeButton.Position = UDim2.new(0.5, -200, 0.85, 0)
executeButton.Text = "Thực thi script"
executeButton.TextSize = 18
executeButton.Parent = screenGui

-- Hàm tạo key ngẫu nhiên
local function generateKey()
    local key = ""
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    for i = 1, 16 do  -- Tạo key dài 16 ký tự
        local rand = math.random(1, #characters)
        key = key .. characters:sub(rand, rand)
    end
    return key
end

-- Tạo key mới mỗi 24 giờ
local lastGeneratedTime = os.time()
local currentKey = generateKey()
generatedKeyLabel.Text = "Key của bạn: " .. currentKey

-- Cập nhật lại key sau 24 giờ
game:GetService("RunService").Heartbeat:Connect(function()
    if os.time() - lastGeneratedTime >= 86400 then  -- 86400 giây = 24 giờ
        currentKey = generateKey()
        generatedKeyLabel.Text = "Key của bạn: " .. currentKey
        lastGeneratedTime = os.time()
    end
end)

-- Hàm kiểm tra key người chơi nhập vào
local function checkKey(inputKey)
    if inputKey == currentKey then
        print("Key hợp lệ!")
        return true
    else
        print("Key không hợp lệ!")
        return false
    end
end

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

-- Kết nối sự kiện khi người chơi nhấn nút kiểm tra key
checkButton.MouseButton1Click:Connect(function()
    local inputKey = keyInputBox.Text
    if checkKey(inputKey) then
        -- Nếu key hợp lệ, hiển thị thông báo và mở chức năng thực thi script
        scriptInputBox.Visible = true
        executeButton.Visible = true
    end
    keyInputBox.Text = ""  -- Xóa TextBox sau khi kiểm tra
end)

-- Kết nối sự kiện khi người chơi nhấn nút thực thi script
executeButton.MouseButton1Click:Connect(function()
    local scriptText = scriptInputBox.Text
    executeScript(scriptText)  -- Thực thi script dán vào
    scriptInputBox.Text = ""  -- Xóa TextBox sau khi thực thi
end)
