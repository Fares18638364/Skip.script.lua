local _v1 = game:GetService("ProximityPromptService")
local _v2 = game:GetService("Players").LocalPlayer

local function _f1()
    local _c = _v2.Character
    if not _c or not _c:FindFirstChild("HumanoidRootPart") then return end
    
    local _p = _c.HumanoidRootPart.Position
    local _n = nil
    local _m = math.huge
    
    -- البحث عن أقرب زر يظهر للاعب
    for _, _prompt in ipairs(workspace:GetDescendants()) do
        if _prompt:IsA("ProximityPrompt") and _prompt.Enabled then
            local _parent = _prompt.Parent
            if _parent and _parent:IsA("BasePart") then
                local _dist = (_parent.Position - _p).Magnitude
                -- التأكد من المسافة ومجال الرؤية للزر
                if _dist < _m and _dist <= _prompt.MaxActivationDistance then
                    _m = _dist
                    _n = _prompt
                end
            end
        end
    end
    
    -- تشغيل محاكاة الضغط لمدة 3 ثواني
    if _n then
        _n:InputHoldBegin()
        task.wait(3) -- مدة التعليق المطلوبة (3 ثواني)
        _n:InputHoldEnd()
    end
end

-- لتشغيل الأمر تلقائياً فوراً:
_f1()
