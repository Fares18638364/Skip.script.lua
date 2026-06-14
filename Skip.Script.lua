local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local function fireNearestPrompt()
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    
    -- البحث عن أقرب زر تفاعل متاح حولك
    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local parentPart = prompt.Parent
            if parentPart and parentPart:IsA("BasePart") then
                local distance = (parentPart.Position - rootPart.Position).Magnitude
                
                -- إذا كنت قريب كفاية من الزر
                if distance <= prompt.MaxActivationDistance then
                    -- تفعيل الزر فوراً وتخطي الـ 3 ثواني كاملة
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    else
                        -- طريقة احتياطية سريعة جداً إذا كان المفسر لا يدعم الأمر المباشر
                        prompt:InputHoldBegin()
                        task.wait(0.05) -- جزء بسيط جداً من الثانية لتسجيل الضغطة
                        prompt:InputHoldEnd()
                    end
                    break
                end
            end
        end
    end
end

-- تشغيل الأمر فوراً عند استدعاء السكربت
fireNearestPrompt()
