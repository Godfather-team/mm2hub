local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

pcall(function()
    local TM = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("TradeModule")
    if TM then
        local old = TM.OnClientInvoke
        TM.OnClientInvoke = function(...)
            local ok, res = pcall(old, ...)
            return ok and res or nil
        end
    end
end)

local function S(v)
    if v == nil then return ""
    elseif type(v) == "string" then return v
    elseif type(v) == "number" then return tostring(v)
    elseif type(v) == "boolean" then return tostring(v)
    else return tostring(v) or "" end
end

local COLORS = {
    Primary = Color3.fromRGB(220, 38, 38),
    PrimaryLight = Color3.fromRGB(255, 100, 100),
    Dark = Color3.fromRGB(12, 10, 16),
    Dark2 = Color3.fromRGB(20, 17, 28),
    Dark3 = Color3.fromRGB(28, 24, 40),
    Stroke = Color3.fromRGB(60, 50, 80),
    White = Color3.fromRGB(245, 240, 255),
    Gray = Color3.fromRGB(170, 160, 190),
    DarkGray = Color3.fromRGB(110, 100, 130),
    Green = Color3.fromRGB(50, 200, 100),
    Red = Color3.fromRGB(255, 80, 80),
}

local TI = {
    Fast = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Med = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    Bounce = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
}

local function ClickSound()
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://138656262630730"
        s.Volume = 0.3
        s.Parent = SoundService
        s:Play()
        Debris:AddItem(s, 1)
    end)
end

local function NotifySound()
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://106553517979212"
        s.Volume = 0.25
        s.Parent = SoundService
        s:Play()
        Debris:AddItem(s, 2)
    end)
end


local AnimationChanger = {
    Zombie = false, Ninja = false, Robot = false, Old = false,
    Stylish = false, Superhero = false, Villain = false, Astronaut = false,
    Cowboy = false, Knight = false, Mage = false, Pirate = false,
    Samurai = false, Spartan = false, Werewolf = false, Skeleton = false,
    Ghost = false, Vampire = false, Witch = false, Wizard = false,
}

local AnimationAssets = {
    Zombie = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Ninja = {walk = "rbxassetid://656121766", run = "rbxassetid://656118878", jump = "rbxassetid://656117878", fall = "rbxassetid://656115606", idle = "rbxassetid://656117878"},
    Robot = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Old = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Stylish = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Superhero = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Villain = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Astronaut = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Cowboy = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Knight = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Mage = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Pirate = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Samurai = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Spartan = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Werewolf = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Skeleton = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Ghost = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Vampire = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Witch = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
    Wizard = {walk = "rbxassetid://616163682", run = "rbxassetid://616163682", jump = "rbxassetid://616161997", fall = "rbxassetid://616157476", idle = "rbxassetid://616158929"},
}

local SkinChanger = {
    Default = true, Noob = false, Guest = false, Bacon = false,
    Acorn = false, Skeleton = false, Zombie = false, Vampire = false,
    Werewolf = false, Robot = false, Cyborg = false, Alien = false,
    Ghost = false, Demon = false, Angel = false, Ninja = false,
    Samurai = false, Knight = false, Wizard = false, Witch = false,
}

local SkinAssets = {
    Noob = {shirt = "rbxassetid://123456789", pants = "rbxassetid://123456790"},
    Guest = {shirt = "rbxassetid://123456791", pants = "rbxassetid://123456792"},
    Bacon = {shirt = "rbxassetid://123456793", pants = "rbxassetid://123456794"},
    Acorn = {shirt = "rbxassetid://123456795", pants = "rbxassetid://123456796"},
    Skeleton = {shirt = "rbxassetid://123456797", pants = "rbxassetid://123456798"},
    Zombie = {shirt = "rbxassetid://123456799", pants = "rbxassetid://123456800"},
    Vampire = {shirt = "rbxassetid://123456801", pants = "rbxassetid://123456802"},
    Werewolf = {shirt = "rbxassetid://123456803", pants = "rbxassetid://123456804"},
    Robot = {shirt = "rbxassetid://123456805", pants = "rbxassetid://123456806"},
    Cyborg = {shirt = "rbxassetid://123456807", pants = "rbxassetid://123456808"},
    Alien = {shirt = "rbxassetid://123456809", pants = "rbxassetid://123456810"},
    Ghost = {shirt = "rbxassetid://123456811", pants = "rbxassetid://123456812"},
    Demon = {shirt = "rbxassetid://123456813", pants = "rbxassetid://123456814"},
    Angel = {shirt = "rbxassetid://123456815", pants = "rbxassetid://123456816"},
    Ninja = {shirt = "rbxassetid://123456817", pants = "rbxassetid://123456818"},
    Samurai = {shirt = "rbxassetid://123456819", pants = "rbxassetid://123456820"},
    Knight = {shirt = "rbxassetid://123456821", pants = "rbxassetid://123456822"},
    Wizard = {shirt = "rbxassetid://123456823", pants = "rbxassetid://123456824"},
    Witch = {shirt = "rbxassetid://123456825", pants = "rbxassetid://123456826"},
}

local CurrentAnimations = {}
local CurrentSkin = nil

local function ChangeAnimation(animType, enabled)
    AnimationChanger[animType] = enabled
    if enabled then
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        local animate = char:FindFirstChild("Animate")
        if animate then animate:Destroy() end

        local assets = AnimationAssets[animType]
        if not assets then return end

        local anims = {}
        local walkAnim = Instance.new("Animation")
        walkAnim.AnimationId = assets.walk
        table.insert(anims, humanoid:LoadAnimation(walkAnim))

        CurrentAnimations[animType] = anims
    else
        local anims = CurrentAnimations[animType]
        if anims then
            for _, anim in pairs(anims) do
                anim:Stop()
            end
            CurrentAnimations[animType] = nil
        end
    end
end

local function ChangeSkin(skinType, enabled)
    if enabled then
        for skin, _ in pairs(SkinChanger) do
            SkinChanger[skin] = false
        end
        SkinChanger[skinType] = true
        CurrentSkin = skinType

        local char = LocalPlayer.Character
        if not char then return end

        local assets = SkinAssets[skinType]
        if not assets then return end

        local shirt = char:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", char)
        shirt.ShirtTemplate = assets.shirt

        local pants = char:FindFirstChildOfClass("Pants") or Instance.new("Pants", char)
        pants.PantsTemplate = assets.pants
    else
        SkinChanger[skinType] = false
        CurrentSkin = nil

        local char = LocalPlayer.Character
        if not char then return end

        local shirt = char:FindFirstChildOfClass("Shirt")
        if shirt then shirt:Destroy() end
        local pants = char:FindFirstChildOfClass("Pants")
        if pants then pants:Destroy() end
    end
end

local function ResetAnimations()
    for animType, _ in pairs(CurrentAnimations) do
        ChangeAnimation(animType, false)
    end
    for animType, _ in pairs(AnimationChanger) do
        AnimationChanger[animType] = false
    end
end

local function ResetSkin()
    ChangeSkin(CurrentSkin or "Default", false)
end

print("[Vexon v14] Animation & Skin changer loaded")

local VisualEffects = {
    AngelWings = false, DemonWings = false, ButterflyWings = false, DragonWings = false,
    FairyWings = false, BatWings = false, Halo = false, DemonHorns = false,
    Crown = false, Hat = false, Mask = false, Glasses = false,
    Aura = false, FireAura = false, IceAura = false, LightningAura = false,
    PoisonAura = false, ShadowAura = false, RainbowAura = false,
    Sparkles = false, FireSparkles = false, IceSparkles = false, GalaxySparkles = false,
    Hearts = false, Stars = false, MusicNotes = false, Skulls = false,
    Trail = false, FireTrail = false, IceTrail = false, RainbowTrail = false,
    LightningTrail = false, GhostTrail = false,
    Footsteps = false, FireFootsteps = false, IceFootsteps = false,
    GhostEffect = false, Giant = false, Tiny = false, Fat = false, Thin = false,
    Headless = false, Zombie = false, Skeleton = false, Vampire = false,
    Werewolf = false, Robot = false, Cyborg = false, Ghost = false,
    Spirit = false, Demon = false, Angel = false, Ninja = false,
    Samurai = false, Knight = false, Wizard = false, Witch = false,
}

local State = {
    GoldBombCD = false, NormalBombCD = false, FlickActive = false, WallHopActive = false,
    SpeedGlitch = false, Stretch = false, Flinging = false,
    ESP = false, GunESP = true, PingPred = false, AntiFling = false,
    LowGfx = false, HighGfx = false, Crosshair = false, SpinCrosshair = false,
    AutoFarm = false, Farming = false, BagFull = false,
    SpeedWalk = false, JumpPower = false, AntiAFK = false,
    Performance = false, AutoShoot = false, AutoThrow = false,
    InfiniteJump = false, FullBright = false, NoFog = false,
    ThirdPerson = false, HitSound = false, KillSound = false,
    Bhop = false, AutoStrafe = false, WalkOnWater = false,
    AntiLagSwitch = false, FPSBoost = false, StreamMode = false, FakeLag = false,
    TradeLogger = false, Spectate = false, Freecam = false,
    MurdererAimbot = false, SheriffAimbot = false, SilentAim = false,
    TriggerBot = false, RapidFire = false, Chams = false, SkeletonESP = false,
    BoxESP = false, TracerLines = false, OffScreenArrows = false,
    TrapsESP = false, CoinsESP = false, GodMode = false, Fly = false,
    Noclip = false, AutoRespawn = false, AutoEquip = false,
    HitboxExpander = false, BringGun = false, AutoCollect = false,
    AutoVote = false, AutoReady = false,
}

local Config = {
    SpeedValue = 200, VelocityCap = 200, FOV = 70, StretchRes = 0.5,
    WalkSpeedValue = 16, JumpPowerValue = 50, FlySpeed = 50,
    AimbotFOV = 100, HitboxSize = 5, RapidFireDelay = 0.1, ShootRange = 3,
}

local ESPData = {}
local ESPLastUpdate = 0
local ESPConn = nil
local ESPFilters = {Murderer = true, Sheriff = true, Hero = true, Innocent = true, Self = true}
local ESPColors = {
    Murderer = Color3.fromRGB(255, 40, 40), Sheriff = Color3.fromRGB(40, 130, 255),
    Hero = Color3.fromRGB(255, 215, 0), Innocent = Color3.fromRGB(0, 220, 0),
}

local FarmStats = {Coins = 0, StartTime = 0, Running = false}

local SkyboxPresets = {
    {name = "Crimson Void", id = "98490421374360", color = Color3.fromRGB(200, 50, 50)},
    {name = "Rose Nebula", id = "95000769820905", color = Color3.fromRGB(220, 100, 180)},
    {name = "Blush Storm", id = "82988835868087", color = Color3.fromRGB(200, 80, 160)},
    {name = "Emerald Drift", id = "5036205687", color = Color3.fromRGB(50, 180, 80)},
    {name = "Abyss Black", id = "80807192441609", color = Color3.fromRGB(30, 30, 30)},
    {name = "Cosmic Deep", id = "77816282467771", color = Color3.fromRGB(80, 40, 160)},
    {name = "Solar Flare", id = "2669948520", color = Color3.fromRGB(220, 190, 40)},
    {name = "Galaxy Swirl", id = "1087433029", color = Color3.fromRGB(120, 80, 200)},
    {name = "Deep Ocean", id = "153695414", color = Color3.fromRGB(0, 100, 180)},
    {name = "Blood Moon", id = "144933874", color = Color3.fromRGB(180, 30, 30)},
}

local CrosshairPresets = {
    {name = "Neon Cyan", id = "11770890197"}, {name = "Electric Purple", id = "11770691141"},
    {name = "Precision Dot", id = "10878218308"}, {name = "Aim Cross", id = "10891594349"},
    {name = "Blue Spec", id = "11720475063"}, {name = "Circle Dot", id = "10831379335"},
    {name = "Green Hit", id = "8375241602"}, {name = "Red Dot", id = "3575112830"},
}

local SavedSky = nil
local SkyActive = false
local CrosshairID = CrosshairPresets[1].id
local CrosshairImg = nil
local CrosshairSpinConn = nil
local CrosshairRenderConn = nil

local GfxOriginal = {
    GlobalShadows = Lighting.GlobalShadows, Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    FogEnd = Lighting.FogEnd, FogStart = Lighting.FogStart,
}
local GfxSaved = {}
local GfxConn = nil
local FPSLabel = nil
local PerformanceOverlay = nil

local PredictionPart = Instance.new("Part")
PredictionPart.Name = "VexonPrediction"
PredictionPart.Size = Vector3.new(0.5, 0.5, 0.5)
PredictionPart.Anchored = true
PredictionPart.CanCollide = false
PredictionPart.Transparency = 1
PredictionPart.Parent = Workspace

print("[Vexon v12] Core loaded")

local BtnSG = Instance.new("ScreenGui")
BtnSG.Name = "VexonBtns"
BtnSG.ResetOnSpawn = false
BtnSG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BtnSG.DisplayOrder = 10
BtnSG.Parent = game.CoreGui

local BtnRegistry = {}

local function AddPulse(obj, minS, maxS, dur)
    local orig = obj.Size
    task.spawn(function()
        while obj and obj.Parent do
            TweenService:Create(obj, TweenInfo.new(dur or 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(orig.X.Scale * (maxS or 1.05), orig.X.Offset * (maxS or 1.05), orig.Y.Scale * (maxS or 1.05), orig.Y.Offset * (maxS or 1.05))
            }):Play()
            task.wait(dur or 0.8)
            if not obj or not obj.Parent then break end
            TweenService:Create(obj, TweenInfo.new(dur or 0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(orig.X.Scale * (minS or 0.98), orig.X.Offset * (minS or 0.98), orig.Y.Scale * (minS or 0.98), orig.Y.Offset * (minS or 0.98))
            }):Play()
            task.wait(dur or 0.8)
        end
    end)
end

local function AddGlow(obj, minT, maxT)
    local stroke = obj:FindFirstChildOfClass("UIStroke")
    if not stroke then return end
    local up = true
    RunService.Heartbeat:Connect(function()
        if not obj or not obj.Parent then return end
        local cur = stroke.Transparency
        if up then
            stroke.Transparency = cur + 0.02
            if stroke.Transparency >= (maxT or 0.5) then up = false end
        else
            stroke.Transparency = cur - 0.02
            if stroke.Transparency <= (minT or 0.1) then up = true end
        end
    end)
end

local function MakeDraggable(obj)
    local drag = false
    local dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            drag = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    obj.InputChanged:Connect(function(input)
        if drag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

local function CreateBtn(id, pos, size, color, text)
    if BtnRegistry[id] and BtnRegistry[id].btn then
        BtnRegistry[id].btn:Destroy()
    end

    local btn = Instance.new("TextButton")
    btn.Name = "Btn_" .. S(id)
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = COLORS.Dark2
    btn.BackgroundTransparency = 0.05
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.ClipsDescendants = true
    btn.Parent = BtnSG

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, size.Y.Offset * 0.25)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1.8
    stroke.Transparency = 0.15
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = btn

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 10, 18))
    })
    grad.Rotation = 135
    grad.Parent = btn

    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 50, 1, 50)
    glow.Position = UDim2.new(0.5, -size.X.Offset/2 - 25, 0.5, -size.Y.Offset/2 - 25)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.85
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 276, 276)
    glow.Parent = btn

    local lbl = Instance.new("TextLabel")
    lbl.Name = "Lbl"
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = S(text)
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = math.max(10, size.Y.Offset * 0.14)
    lbl.TextYAlignment = Enum.TextYAlignment.Center
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TI.Fast, {BackgroundTransparency = 0}):Play()
        TweenService:Create(stroke, TI.Fast, {Thickness = 2.5, Transparency = 0.05}):Play()
        TweenService:Create(btn, TI.Bounce, {Size = size + UDim2.new(0, 5, 0, 5)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TI.Fast, {BackgroundTransparency = 0.05}):Play()
        TweenService:Create(stroke, TI.Fast, {Thickness = 1.8, Transparency = 0.15}):Play()
        TweenService:Create(btn, TI.Bounce, {Size = size}):Play()
    end)

    btn.MouseButton1Down:Connect(function()
        ClickSound()
        TweenService:Create(btn, TI.Fast, {Size = size - UDim2.new(0, 5, 0, 5)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TI.Bounce, {Size = size}):Play()
    end)

    MakeDraggable(btn)

    BtnRegistry[id] = {btn = btn, stroke = stroke, lbl = lbl, baseSize = size, baseColor = color}
    return BtnRegistry[id]
end

local function AddSpinImg(entry, imgId)
    if not entry or not entry.btn then return nil end
    local size = entry.baseSize
    local imgSize = math.floor(size.Y.Offset * 0.48)
    local img = Instance.new("ImageLabel")
    img.Name = "SpinImg"
    img.Size = UDim2.new(0, imgSize, 0, imgSize)
    img.Position = UDim2.new(0.5, -imgSize/2, 0.5, -imgSize/2 - 8)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://" .. S(imgId)
    img.ZIndex = 3
    img.Parent = entry.btn
    entry.img = img
    entry.lbl.Size = UDim2.new(1, 0, 0.32, 0)
    entry.lbl.Position = UDim2.new(0, 0, 0.68, 0)
    entry.lbl.TextSize = math.max(9, size.Y.Offset * 0.11)

    task.spawn(function()
        while img and img.Parent do
            img.Rotation = img.Rotation + 2.5
            RunService.RenderStepped:Wait()
        end
    end)
    return img
end

local BigSize = UDim2.new(0, 96, 0, 96)
local SmallSize = UDim2.new(0, 60, 0, 60)

local BtnPos = {
    GoldBomb = UDim2.new(0.5, -228, 0.78, 0),
    NormalBomb = UDim2.new(0.5, -120, 0.78, 0),
    Shoot = UDim2.new(0.5, -12, 0.78, 0),
    ESP = UDim2.new(0.5, 96, 0.78, 16),
    Flick = UDim2.new(0.5, 164, 0.78, 16),
    Speed = UDim2.new(0.5, -296, 0.78, 16),
    Stretch = UDim2.new(0.5, -228, 0.68, 16),
    GrabGun = UDim2.new(0.5, 96, 0.68, 16),
    WallHop = UDim2.new(0.5, 164, 0.68, 16),
    FlingMurderer = UDim2.new(0.5, -296, 0.68, 16),
    FlingSheriff = UDim2.new(0.5, -228, 0.68, 16),
}

print("[Vexon v12] Buttons loaded")

local MainGui = nil
local MainFrame = nil
local Sidebar = nil
local ContentArea = nil
local TopBar = nil
local TabBtns = {}
local TabConts = {}
local CurrentTab = "Main"
local UIVisible = true

local function New(class, parent, props)
    local obj = Instance.new(class)
    obj.Parent = parent
    for k, v in pairs(props or {}) do
        pcall(function() obj[k] = v end)
    end
    return obj
end

local function Gradient(parent, c1, c2, rot)
    local g = New("UIGradient", parent, {})
    g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, c1), ColorSequenceKeypoint.new(1, c2)})
    g.Rotation = rot or 135
    return g
end


local function CreateSliderPopup(title, min, max, current, step, onApply, onReset)
    local titleStr = S(title)
    local existing = game.CoreGui:FindFirstChild("VexonSlider_" .. titleStr:gsub("%s+", "_"))
    if existing then existing:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name = "VexonSlider_" .. titleStr:gsub("%s+", "_")
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 55
    sg.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 210)
    frame.Position = UDim2.new(0.5, -170, 0.35, 0)
    frame.BackgroundColor3 = COLORS.Dark
    frame.BackgroundTransparency = 0.03
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = sg

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 16)
    fc.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.Primary
    stroke.Thickness = 2
    stroke.Transparency = 0.1
    stroke.Parent = frame

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -50, 0, 40)
    titleLbl.Position = UDim2.new(0, 14, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = titleStr
    titleLbl.TextColor3 = COLORS.White
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 4)
    closeBtn.BackgroundColor3 = COLORS.Red
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    closeBtn.Parent = frame

    local cbc = Instance.new("UICorner")
    cbc.CornerRadius = UDim.new(0, 10)
    cbc.Parent = closeBtn

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(1, 0, 0, 26)
    valLbl.Position = UDim2.new(0, 0, 0, 42)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = titleStr .. ":  " .. S(current)
    valLbl.TextColor3 = COLORS.Primary
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 14
    valLbl.Parent = frame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -32, 0, 14)
    track.Position = UDim2.new(0, 16, 0, 80)
    track.BackgroundColor3 = COLORS.Stroke
    track.BorderSizePixel = 0
    track.Parent = frame

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = track

    local fillPct = (current - min) / (max - min)
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(fillPct, 0, 1, 0)
    fill.BackgroundColor3 = COLORS.Primary
    fill.BorderSizePixel = 0
    fill.Parent = frame

    local filc = Instance.new("UICorner")
    filc.CornerRadius = UDim.new(1, 0)
    filc.Parent = fill

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 30, 0, 30)
    knob.Position = UDim2.new(fillPct, -15, 0.5, -15)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Text = ""
    knob.AutoButtonColor = false
    knob.BorderSizePixel = 0
    knob.Parent = track

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local knobStroke = Instance.new("UIStroke")
    knobStroke.Color = COLORS.Primary
    knobStroke.Thickness = 2.5
    knobStroke.Parent = knob

    local curVal = current
    local dragging = false

    local function UpdateFromX(x)
        local pct = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local raw = min + pct * (max - min)
        curVal = math.round(raw)
        if step and step > 0 then curVal = math.round(curVal / step) * step end
        local newPct = (curVal - min) / (max - min)
        TweenService:Create(fill, TI.Fast, {Size = UDim2.new(newPct, 0, 1, 0)}):Play()
        TweenService:Create(knob, TI.Fast, {Position = UDim2.new(newPct, -15, 0.5, -15)}):Play()
        valLbl.Text = titleStr .. ":  " .. S(curVal)
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateFromX(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local btnRow = Instance.new("Frame")
    btnRow.Size = UDim2.new(1, -24, 0, 42)
    btnRow.Position = UDim2.new(0, 12, 0, 150)
    btnRow.BackgroundTransparency = 1
    btnRow.Parent = frame

    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0.48, 0, 1, 0)
    applyBtn.BackgroundColor3 = COLORS.Green
    applyBtn.Text = "Apply"
    applyBtn.TextColor3 = Color3.new(1, 1, 1)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.TextSize = 13
    applyBtn.Parent = btnRow

    local abc = Instance.new("UICorner")
    abc.CornerRadius = UDim.new(0, 10)
    abc.Parent = applyBtn

    applyBtn.MouseButton1Click:Connect(function()
        onApply(curVal)
        ClickSound()
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.48, 0, 1, 0)
    resetBtn.Position = UDim2.new(0.52, 0, 0, 0)
    resetBtn.BackgroundColor3 = COLORS.Red
    resetBtn.Text = "Reset"
    resetBtn.TextColor3 = Color3.new(1, 1, 1)
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 13
    resetBtn.Parent = btnRow

    local rbc = Instance.new("UICorner")
    rbc.CornerRadius = UDim.new(0, 10)
    rbc.Parent = resetBtn

    resetBtn.MouseButton1Click:Connect(function()
        onReset()
        sg:Destroy()
    end)

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(frame, TI.Med, {Size = UDim2.new(0, 340, 0, 0), BackgroundTransparency = 1}):Play()
        task.delay(0.3, function() sg:Destroy() end)
    end)

    frame.Size = UDim2.new(0, 340, 0, 0)
    frame.BackgroundTransparency = 1
    TweenService:Create(frame, TI.Slow, {Size = UDim2.new(0, 340, 0, 210), BackgroundTransparency = 0.03}):Play()

    MakeDraggable(frame)
end

local function 
local function JoinAnotherServer()
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        local code = TeleportService:ReserveServer(game.PlaceId)
        if code then
            TeleportService:TeleportToPrivateServer(game.PlaceId, code, {LocalPlayer})
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

local function RejoinServer()
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end


local function SetupAntiAFK()
    if AntiAFKServis then task.cancel(AntiAFKServis) AntiAFKServis = nil end
    if not State.AntiAFK then return end
    AntiAFKServis = task.spawn(function()
        while State.AntiAFK do
            task.wait(300)
            pcall(function()
                local vu = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
                local cam = Workspace.CurrentCamera
                if vu and cam then
                    vu:Button2Down(Vector2.new(0, 0), cam.CFrame)
                    task.wait(0.1)
                    vu:Button2Up(Vector2.new(0, 0), cam.CFrame)
                end
            end)
        end
    end)
end


local function CreatePerformanceOverlay()
    if PerformanceOverlay then return end
    local Stats = game:GetService("Stats")
    local sg = Instance.new("ScreenGui")
    sg.Name = "VexonStats"
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.DisplayOrder = 95
    sg.ResetOnSpawn = false
    sg.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Name = "StatsFrame"
    frame.Size = UDim2.new(0, 110, 0, 45)
    frame.Position = UDim2.new(0.5, -55, 0.5, -22)
    frame.BackgroundColor3 = COLORS.Dark2
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = sg

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 20, 35))
    })
    grad.Rotation = 90
    grad.Parent = frame

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -4, 1, -4)
    container.Position = UDim2.new(0, 2, 0, 2)
    container.BackgroundTransparency = 1
    container.Parent = frame

    local pingLbl = Instance.new("TextLabel")
    pingLbl.Name = "Ping"
    pingLbl.Size = UDim2.new(1, 0, 0.5, 0)
    pingLbl.Position = UDim2.new(0, 0, 0, 0)
    pingLbl.BackgroundTransparency = 1
    pingLbl.TextColor3 = COLORS.White
    pingLbl.TextXAlignment = Enum.TextXAlignment.Center
    pingLbl.TextYAlignment = Enum.TextYAlignment.Center
    pingLbl.Font = Enum.Font.GothamMedium
    pingLbl.TextSize = 10
    pingLbl.RichText = true
    pingLbl.Text = "Ping: ..."
    pingLbl.Parent = container

    local fpsLbl = Instance.new("TextLabel")
    fpsLbl.Name = "FPS"
    fpsLbl.Size = UDim2.new(1, 0, 0.5, 0)
    fpsLbl.Position = UDim2.new(0, 0, 0.5, 0)
    fpsLbl.BackgroundTransparency = 1
    fpsLbl.TextColor3 = COLORS.White
    fpsLbl.TextXAlignment = Enum.TextXAlignment.Center
    fpsLbl.TextYAlignment = Enum.TextYAlignment.Center
    fpsLbl.Font = Enum.Font.GothamMedium
    fpsLbl.TextSize = 10
    fpsLbl.RichText = true
    fpsLbl.Text = "FPS: ..."
    fpsLbl.Parent = container

    local dragging = false
    local dragStart, startPos
    local dragBtn = Instance.new("TextButton")
    dragBtn.Name = "Drag"
    dragBtn.Size = UDim2.new(1, 0, 1, 0)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = frame

    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            startPos = frame.Position
        end
    end)
    dragBtn.InputChanged:Connect(function(input)
        if not dragStart then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
            if not dragging and delta.Magnitude > 5 then
                dragging = true
            end
            if dragging then
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)
    dragBtn.InputEnded:Connect(function()
        dragging = false
    end)

    local lastTime = tick()
    local frameCount = 0
    local conn = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTime >= 1 then
            local ok, ping = pcall(function()
                return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            if ok then
                pingLbl.Text = "Ping: " .. ping
            end
            fpsLbl.Text = "FPS: " .. frameCount
            lastTime = tick()
            frameCount = 0
        end
    end)

    PerformanceOverlay = {
        gui = sg,
        frame = frame,
        destroy = function()
            if conn then conn:Disconnect() end
            if sg then sg:Destroy() end
            PerformanceOverlay = nil
        end
    }
end


local EffectAssets = {
    AngelWings = "rbxassetid://123456789", DemonWings = "rbxassetid://123456790",
    ButterflyWings = "rbxassetid://123456791", DragonWings = "rbxassetid://123456792",
    FairyWings = "rbxassetid://123456793", BatWings = "rbxassetid://123456794",
    Halo = "rbxassetid://123456795", DemonHorns = "rbxassetid://123456796",
    Crown = "rbxassetid://123456797", Hat = "rbxassetid://123456798",
    Mask = "rbxassetid://123456799", Glasses = "rbxassetid://123456800",
    Aura = "rbxassetid://123456801", FireAura = "rbxassetid://123456802",
    IceAura = "rbxassetid://123456803", LightningAura = "rbxassetid://123456804",
    PoisonAura = "rbxassetid://123456805", ShadowAura = "rbxassetid://123456806",
    RainbowAura = "rbxassetid://123456807", Sparkles = "rbxassetid://123456808",
    FireSparkles = "rbxassetid://123456809", IceSparkles = "rbxassetid://123456810",
    GalaxySparkles = "rbxassetid://123456811", Hearts = "rbxassetid://123456812",
    Stars = "rbxassetid://123456813", MusicNotes = "rbxassetid://123456814",
    Skulls = "rbxassetid://123456815", Trail = "rbxassetid://123456816",
    FireTrail = "rbxassetid://123456817", IceTrail = "rbxassetid://123456818",
    RainbowTrail = "rbxassetid://123456819", LightningTrail = "rbxassetid://123456820",
    GhostTrail = "rbxassetid://123456821", Footsteps = "rbxassetid://123456822",
    FireFootsteps = "rbxassetid://123456823", IceFootsteps = "rbxassetid://123456824",
    GhostEffect = "rbxassetid://123456825",
}

local ActiveEffects = {}

local function AttachEffect(effectName, assetId)
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local oldEffect = ActiveEffects[effectName]
    if oldEffect then
        oldEffect:Destroy()
        ActiveEffects[effectName] = nil
    end

    local effect = Instance.new("ParticleEmitter")
    effect.Name = "Vexon_" .. effectName
    effect.Texture = assetId
    effect.Rate = 10
    effect.Lifetime = NumberRange.new(1, 2)
    effect.Speed = NumberRange.new(0, 1)
    effect.SpreadAngle = Vector2.new(360, 360)
    effect.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
    effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
    effect.LightEmission = 0.5
    effect.Parent = hrp

    ActiveEffects[effectName] = effect
    return effect
end

local function RemoveEffect(effectName)
    local effect = ActiveEffects[effectName]
    if effect then
        effect:Destroy()
        ActiveEffects[effectName] = nil
    end
end

local function ToggleEffect(effectName, enabled)
    VisualEffects[effectName] = enabled
    if enabled then
        local assetId = EffectAssets[effectName]
        if assetId then
            AttachEffect(effectName, assetId)
        end
    else
        RemoveEffect(effectName)
    end
end

local function ClearAllEffects()
    for name, _ in pairs(ActiveEffects) do
        RemoveEffect(name)
    end
    for name, _ in pairs(VisualEffects) do
        VisualEffects[name] = false
    end
end

local function CharacterMorph(morphType)
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if morphType == "Giant" then
        humanoid.BodyDepthScale.Value = 2
        humanoid.BodyHeightScale.Value = 2
        humanoid.BodyWidthScale.Value = 2
        humanoid.HeadScale.Value = 2
    elseif morphType == "Tiny" then
        humanoid.BodyDepthScale.Value = 0.5
        humanoid.BodyHeightScale.Value = 0.5
        humanoid.BodyWidthScale.Value = 0.5
        humanoid.HeadScale.Value = 0.5
    elseif morphType == "Fat" then
        humanoid.BodyDepthScale.Value = 2
        humanoid.BodyWidthScale.Value = 2
    elseif morphType == "Thin" then
        humanoid.BodyDepthScale.Value = 0.5
        humanoid.BodyWidthScale.Value = 0.5
    elseif morphType == "Headless" then
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = 1
            local face = head:FindFirstChild("face")
            if face then face:Destroy() end
        end
    end
end

local function ResetMorph()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    humanoid.BodyDepthScale.Value = 1
    humanoid.BodyHeightScale.Value = 1
    humanoid.BodyWidthScale.Value = 1
    humanoid.HeadScale.Value = 1

    local head = char:FindFirstChild("Head")
    if head then head.Transparency = 0 end
end

CreateUI()
    local old = game.CoreGui:FindFirstChild("VexonUI")
    if old then old:Destroy() end

    MainGui = New("ScreenGui", game.CoreGui, {
        Name = "VexonUI", ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 100
    })

    local UISize = IsMobile and UDim2.new(0.92, 0, 0.82, 0) or UDim2.new(0, 620, 0, 420)
    local TopH = IsMobile and 42 or 48
    local SideW = IsMobile and 100 or 130

    MainFrame = New("Frame", MainGui, {
        Name = "Main", Size = UISize, Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = COLORS.Dark,
        BackgroundTransparency = 0.15, BorderSizePixel = 0, ClipsDescendants = true
    })
    New("UICorner", MainFrame, {CornerRadius = UDim.new(0, 14)})
    New("UIStroke", MainFrame, {Color = COLORS.Primary, Thickness = 2, Transparency = 0.3})
    Gradient(MainFrame, Color3.fromRGB(16, 13, 22), Color3.fromRGB(9, 7, 13), 135)

    TopBar = New("Frame", MainFrame, {
        Size = UDim2.new(1, 0, 0, TopH), BackgroundColor3 = COLORS.Dark2,
        BackgroundTransparency = 0.25, BorderSizePixel = 0
    })
    New("UICorner", TopBar, {CornerRadius = UDim.new(0, 14)})
    New("UIStroke", TopBar, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.5})
    New("Frame", TopBar, {Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14),
        BackgroundColor3 = COLORS.Dark2, BackgroundTransparency = 0.25, BorderSizePixel = 0})

    local LogoSize = IsMobile and 24 or 28
    local Logo = New("TextLabel", TopBar, {
        Size = UDim2.new(0, LogoSize, 0, LogoSize),
        Position = UDim2.new(0, 10, 0.5, -LogoSize/2),
        BackgroundColor3 = COLORS.Primary, Text = "V", TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBlack, TextSize = IsMobile and 16 or 18
    })
    New("UICorner", Logo, {CornerRadius = UDim.new(0.3, 0)})
    Gradient(Logo, COLORS.Primary, COLORS.PrimaryLight, 45)

    New("TextLabel", TopBar, {
        Size = UDim2.new(0, 160, 1, 0), Position = UDim2.new(0, IsMobile and 38 or 44, 0, 0),
        BackgroundTransparency = 1, Text = "Vexon Hub", TextColor3 = COLORS.White,
        Font = Enum.Font.GothamBold, TextSize = IsMobile and 14 or 16, TextXAlignment = Enum.TextXAlignment.Left
    })

    New("TextLabel", TopBar, {
        Size = UDim2.new(0, 40, 1, 0), Position = UDim2.new(0, IsMobile and 120 or 150, 0, 0),
        BackgroundTransparency = 1, Text = "v12", TextColor3 = COLORS.Primary,
        Font = Enum.Font.GothamBold, TextSize = IsMobile and 10 or 12, TextXAlignment = Enum.TextXAlignment.Left
    })

    local MinBtn = New("TextButton", TopBar, {
        Size = UDim2.new(0, IsMobile and 30 or 34, 0, IsMobile and 30 or 34),
        Position = UDim2.new(1, IsMobile and -70 or -80, 0.5, IsMobile and -15 or -17),
        BackgroundColor3 = COLORS.Dark3, BackgroundTransparency = 0.3, Text = "—",
        TextColor3 = COLORS.White, Font = Enum.Font.GothamBold, TextSize = IsMobile and 12 or 14
    })
    New("UICorner", MinBtn, {CornerRadius = UDim.new(0, 8)})
    New("UIStroke", MinBtn, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.5})

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        ClickSound()
        minimized = not minimized
        TweenService:Create(MainFrame, TI.Med, {
            Size = minimized and UDim2.new(UISize.X.Scale, UISize.X.Offset, 0, TopH) or UISize
        }):Play()
    end)

    local CloseBtn = New("TextButton", TopBar, {
        Size = UDim2.new(0, IsMobile and 30 or 34, 0, IsMobile and 30 or 34),
        Position = UDim2.new(1, IsMobile and -36 or -40, 0.5, IsMobile and -15 or -17),
        BackgroundColor3 = COLORS.Red, BackgroundTransparency = 0.3, Text = "X",
        TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = IsMobile and 12 or 14
    })
    New("UICorner", CloseBtn, {CornerRadius = UDim.new(0, 8)})

    CloseBtn.MouseButton1Click:Connect(function()
        ClickSound()
        UIVisible = false
        TweenService:Create(MainFrame, TI.Med, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        task.delay(0.3, function() MainFrame.Visible = false end)
    end)

    Sidebar = New("Frame", MainFrame, {
        Size = UDim2.new(0, SideW, 1, -TopH), Position = UDim2.new(0, 0, 0, TopH),
        BackgroundColor3 = COLORS.Dark2, BackgroundTransparency = 0.35, BorderSizePixel = 0
    })
    New("UICorner", Sidebar, {CornerRadius = UDim.new(0, 14)})
    New("UIStroke", Sidebar, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.6})
    New("UIListLayout", Sidebar, {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder})
    New("UIPadding", Sidebar, {PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)})

    ContentArea = New("Frame", MainFrame, {
        Size = UDim2.new(1, -SideW - 8, 1, -TopH - 8),
        Position = UDim2.new(0, SideW + 4, 0, TopH + 4),
        BackgroundTransparency = 1
    })

    MakeDraggable(MainFrame)
end

local function SwitchTab(name)
    for n, c in pairs(TabConts) do
        if c and c.Parent then c.Visible = (n == name) end
    end
    for n, b in pairs(TabBtns) do
        if b and b.btn and b.btn.Parent then
            local active = (n == name)
            TweenService:Create(b.btn, TI.Fast, {BackgroundTransparency = active and 0.1 or 0.5}):Play()
            if b.stroke and b.stroke.Parent then
                TweenService:Create(b.stroke, TI.Fast, {Color = active and COLORS.Primary or COLORS.Stroke, Transparency = active and 0.3 or 0.6}):Play()
            end
        end
    end
end

local function AddTab(name, iconId, order)
    if not Sidebar or not Sidebar.Parent then return nil end
    if not ContentArea or not ContentArea.Parent then return nil end

    local btn = New("TextButton", Sidebar, {
        Size = UDim2.new(1, 0, 0, IsMobile and 34 or 38),
        BackgroundColor3 = COLORS.Dark3, BackgroundTransparency = 0.5, Text = "",
        LayoutOrder = order or 1, Name = "Tab_" .. S(name)
    })
    New("UICorner", btn, {CornerRadius = UDim.new(0, 8)})
    local stroke = New("UIStroke", btn, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.6})

    local iconSize = IsMobile and 14 or 18
    New("ImageLabel", btn, {
        Size = UDim2.new(0, iconSize, 0, iconSize),
        Position = UDim2.new(0, 8, 0.5, -iconSize/2),
        BackgroundTransparency = 1, Image = "rbxassetid://" .. S(iconId or "7734053495"),
        ImageColor3 = COLORS.Gray, Name = "Icon"
    })

    New("TextLabel", btn, {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.new(0, IsMobile and 24 or 28, 0, 0),
        BackgroundTransparency = 1, Text = S(name), TextColor3 = COLORS.Gray,
        Font = Enum.Font.GothamMedium, TextSize = IsMobile and 10 or 12,
        TextXAlignment = Enum.TextXAlignment.Left, Name = "Label"
    })

    local cont = New("ScrollingFrame", ContentArea, {
        Name = "Cont_" .. S(name), Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
        ScrollBarImageColor3 = COLORS.Primary, Visible = false, CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    local layout = New("UIListLayout", cont, {Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder})
    New("UIPadding", cont, {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4)})

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        cont.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TI.Fast, {BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TI.Fast, {BackgroundTransparency = 0.5}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        ClickSound()
        SwitchTab(name)
    end)

    TabBtns[name] = {btn = btn, stroke = stroke}
    TabConts[name] = cont
    return cont
end

print("[Vexon v12] UI loaded")

local function CreateSection(parent, title)
    local sec = New("Frame", parent, {Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1})
    New("TextLabel", sec, {
        Size = UDim2.new(1, -10, 1, 0), Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 1, Text = S(title), TextColor3 = COLORS.Primary,
        Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left
    })
    New("Frame", sec, {
        Size = UDim2.new(1, -10, 0, 1), Position = UDim2.new(0, 5, 1, -3),
        BackgroundColor3 = COLORS.Stroke, BackgroundTransparency = 0.5, BorderSizePixel = 0
    })
    return sec
end

local function CreateParagraph(parent, title, content)
    local p = New("Frame", parent, {
        Size = UDim2.new(1, -8, 0, 45), BackgroundColor3 = COLORS.Dark3,
        BackgroundTransparency = 0.35, BorderSizePixel = 0
    })
    New("UICorner", p, {CornerRadius = UDim.new(0, 8)})
    New("UIStroke", p, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.6})
    New("TextLabel", p, {
        Size = UDim2.new(1, -14, 0, 14), Position = UDim2.new(0, 7, 0, 4),
        BackgroundTransparency = 1, Text = S(title), TextColor3 = COLORS.Primary,
        Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left
    })
    local cl = New("TextLabel", p, {
        Size = UDim2.new(1, -14, 0, 24), Position = UDim2.new(0, 7, 0, 19),
        BackgroundTransparency = 1, Text = S(content), TextColor3 = COLORS.Gray,
        Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true
    })
    return {SetContent = function(v) cl.Text = S(v) end}
end

local function CreateToggle(parent, text, default, cb, desc)
    local h = desc and 46 or 36
    local frame = New("Frame", parent, {
        Size = UDim2.new(1, -8, 0, h), BackgroundColor3 = COLORS.Dark3,
        BackgroundTransparency = 0.35, BorderSizePixel = 0
    })
    New("UICorner", frame, {CornerRadius = UDim.new(0, 8)})
    New("UIStroke", frame, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.5})

    New("TextLabel", frame, {
        Size = UDim2.new(1, -55, 0, desc and 16 or 1),
        Position = desc and UDim2.new(0, 8, 0, 5) or UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1, Text = S(text), TextColor3 = COLORS.White,
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left
    })

    if desc then
        New("TextLabel", frame, {
            Size = UDim2.new(1, -55, 0, 12), Position = UDim2.new(0, 8, 0, 22),
            BackgroundTransparency = 1, Text = S(desc), TextColor3 = COLORS.Gray,
            Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left
        })
    end

    local toggle = New("Frame", frame, {
        Size = UDim2.new(0, 36, 0, 20), Position = UDim2.new(1, -45, 0.5, -10),
        BackgroundColor3 = default and COLORS.Primary or COLORS.Stroke, BorderSizePixel = 0
    })
    New("UICorner", toggle, {CornerRadius = UDim.new(1, 0)})

    local knob = New("Frame", toggle, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0
    })
    New("UICorner", knob, {CornerRadius = UDim.new(1, 0)})

    local isOn = default or false
    local btn = New("TextButton", frame, {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = ""})

    btn.MouseButton1Click:Connect(function()
        isOn = not isOn
        ClickSound()
        TweenService:Create(toggle, TI.Med, {BackgroundColor3 = isOn and COLORS.Primary or COLORS.Stroke}):Play()
        TweenService:Create(knob, TI.Bounce, {Position = isOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        if cb then task.spawn(cb, isOn) end
    end)

    return {
        GetValue = function() return isOn end,
        SetValue = function(v)
            isOn = v
            TweenService:Create(toggle, TI.Med, {BackgroundColor3 = isOn and COLORS.Primary or COLORS.Stroke}):Play()
            TweenService:Create(knob, TI.Bounce, {Position = isOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    }
end

local function CreateButton(parent, text, cb, desc)
    local h = desc and 46 or 36
    local frame = New("Frame", parent, {
        Size = UDim2.new(1, -8, 0, h), BackgroundColor3 = COLORS.Dark3,
        BackgroundTransparency = 0.35, BorderSizePixel = 0
    })
    New("UICorner", frame, {CornerRadius = UDim.new(0, 8)})
    local stroke = New("UIStroke", frame, {Color = COLORS.Stroke, Thickness = 1, Transparency = 0.5})

    New("TextLabel", frame, {
        Size = UDim2.new(1, -40, 0, desc and 16 or 1),
        Position = desc and UDim2.new(0, 8, 0, 5) or UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1, Text = S(text), TextColor3 = COLORS.White,
        Font = Enum.Font.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left
    })

    if desc then
        New("TextLabel", frame, {
            Size = UDim2.new(1, -40, 0, 12), Position = UDim2.new(0, 8, 0, 22),
            BackgroundTransparency = 1, Text = S(desc), TextColor3 = COLORS.Gray,
            Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left
        })
    end

    local btn = New("TextButton", frame, {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = ""})

    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TI.Fast, {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(stroke, TI.Fast, {Color = COLORS.Primary, Transparency = 0.3}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(frame, TI.Fast, {BackgroundTransparency = 0.35}):Play()
        TweenService:Create(stroke, TI.Fast, {Color = COLORS.Stroke, Transparency = 0.5}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        ClickSound()
        TweenService:Create(frame, TI.Fast, {BackgroundColor3 = COLORS.Primary}):Play()
        task.delay(0.1, function()
            TweenService:Create(frame, TI.Fast, {BackgroundColor3 = COLORS.Dark3}):Play()
        end)
        if cb then task.spawn(cb) end
    end)

    return {}
end

local function Notify(title, content, ntype, dur)
    NotifySound()
    local gui = game.CoreGui:FindFirstChild("VexonNotify")
    if not gui then
        gui = New("ScreenGui", game.CoreGui, {Name = "VexonNotify", ResetOnSpawn = false, DisplayOrder = 200})
    end

    local frame = New("Frame", gui, {
        Size = UDim2.new(0, IsMobile and 200 or 240, 0, 55),
        Position = UDim2.new(1, 300, 1, -65),
        BackgroundColor3 = COLORS.Dark2, BackgroundTransparency = 0.1, BorderSizePixel = 0
    })
    New("UICorner", frame, {CornerRadius = UDim.new(0, 10)})

    local colors = {success = COLORS.Green, error = COLORS.Red, info = COLORS.Primary}
    New("UIStroke", frame, {Color = colors[ntype] or COLORS.Primary, Thickness = 2, Transparency = 0.3})

    New("TextLabel", frame, {
        Size = UDim2.new(1, -20, 0, 16), Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1, Text = S(title), TextColor3 = COLORS.White,
        Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left
    })

    New("TextLabel", frame, {
        Size = UDim2.new(1, -20, 0, 24), Position = UDim2.new(0, 10, 0, 23),
        BackgroundTransparency = 1, Text = S(content), TextColor3 = COLORS.Gray,
        Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true
    })

    TweenService:Create(frame, TI.Slow, {Position = UDim2.new(1, IsMobile and -210 or -250, 1, -65)}):Play()

    task.delay(dur or 3, function()
        TweenService:Create(frame, TI.Med, {Position = UDim2.new(1, 300, 1, -65)}):Play()
        task.delay(0.3, function() frame:Destroy() end)
    end)
end

local function UIToggle()
    UIVisible = not UIVisible
    if UIVisible then
        MainFrame.Visible = true
        local size = IsMobile and UDim2.new(0.92, 0, 0.82, 0) or UDim2.new(0, 620, 0, 420)
        TweenService:Create(MainFrame, TI.Med, {Size = size, BackgroundTransparency = 0.15}):Play()
    else
        TweenService:Create(MainFrame, TI.Med, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        task.delay(0.3, function() MainFrame.Visible = false end)
    end
end

print("[Vexon v12] Components loaded")
local function DoBomb(toyName, longCD)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tool = LocalPlayer.Backpack:FindFirstChild(toyName) or char:FindFirstChild(toyName)
    if not tool then return end
    if char ~= tool.Parent then
        char.Humanoid:EquipTool(tool)
        task.wait()
    end
    pcall(function()
        tool.Remote:FireServer(CFrame.new(hrp.Position + hrp.CFrame.LookVector * 1.5 + Vector3.new(0, -3, 0)), 50)
    end)
    char.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 62, hrp.AssemblyLinearVelocity.Z)
    if longCD then
        task.spawn(function()
            State.NormalBombCD = true
            task.wait(21)
            State.NormalBombCD = false
        end)
    else
        task.spawn(function()
            State.GoldBombCD = true
            task.wait(4)
            State.GoldBombCD = false
        end)
    end
end

local function GetNearestTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local hasKnife = LocalPlayer.Backpack:FindFirstChild("Knife") or (char and char:FindFirstChild("Knife"))
    local hasGun = LocalPlayer.Backpack:FindFirstChild("Gun") or (char and char:FindFirstChild("Gun"))
    local best = nil
    local bestDist = math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local pc = plr.Character
            local hum = pc:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local phrp = pc:FindFirstChild("HumanoidRootPart")
                if phrp then
                    local pKnife = plr.Backpack:FindFirstChild("Knife") or (pc and pc:FindFirstChild("Knife"))
                    local pGun = plr.Backpack:FindFirstChild("Gun") or (pc and pc:FindFirstChild("Gun"))
                    local dist = (phrp.Position - hrp.Position).Magnitude
                    local valid = false
                    if not hasKnife then
                        if not hasGun then
                            if pKnife then valid = true dist = dist - 1000 end
                            if pGun then valid = true end
                        elseif pGun or pKnife then
                            valid = true
                        end
                    elseif pKnife then
                        valid = true
                    end
                    if valid and dist < bestDist then
                        bestDist = dist
                        best = pc
                    end
                end
            end
        end
    end

    if not best then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local pc = plr.Character
                local hum = pc:FindFirstChildOfClass("Humanoid")
                local phrp = pc:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and phrp then
                    local dist = (phrp.Position - hrp.Position).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        best = pc
                    end
                end
            end
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    TargetChar = GetNearestTarget()
    if TargetChar then
        local myChar = LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if myHRP then
            local torso = TargetChar:FindFirstChild("UpperTorso") or TargetChar:FindFirstChild("Torso") or TargetChar:FindFirstChild("HumanoidRootPart")
            local hum = TargetChar:FindFirstChildOfClass("Humanoid")
            if torso then
                local pos = torso.Position
                local timeOffset = (pos - myHRP.Position).Magnitude / 250
                if State.PingPred then
                    local ok, ping = pcall(function() return LocalPlayer:GetNetworkPing() end)
                    if ok and ping then timeOffset = timeOffset + ping * 0.5 end
                end
                local vel = torso.AssemblyLinearVelocity
                if hum then
                    local st = hum:GetState()
                    if st == Enum.HumanoidStateType.Freefall or st == Enum.HumanoidStateType.Jumping then
                        vel = Vector3.new(vel.X, vel.Y * 0.35, vel.Z)
                    end
                end
                PredictionPart.CFrame = CFrame.new(pos + vel * timeOffset)
            end
        end
    end
end)

local function DoShoot()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
    if knife then
        if char ~= knife.Parent then
            char.Humanoid:EquipTool(knife)
            task.wait(0)
        end
        local target = TargetChar
        if not target then
            local bd = math.huge
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local phrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local phum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if phrp and phum and phum.Health > 0 then
                        local d = (phrp.Position - hrp.Position).Magnitude
                        if d < bd then bd = d target = plr.Character end
                    end
                end
            end
        end
        if target then
            local thrp = target:FindFirstChild("HumanoidRootPart")
            if thrp then
                local torso = target:FindFirstChild("UpperTorso") or target:FindFirstChild("Torso") or thrp
                local vel = thrp.AssemblyLinearVelocity
                local dist = (torso.Position - hrp.Position).Magnitude
                local ping = 0
                if State.PingPred then
                    local ok, p = pcall(function() return LocalPlayer:GetNetworkPing() end)
                    ping = ok and p or 0
                end
                local aimPos = torso.Position + Vector3.new(vel.X, 0, vel.Z) * (dist / 65 + ping * 0.5)
                pcall(function()
                    local evt = knife:WaitForChild("Events"):WaitForChild("KnifeThrown")
                    local cf = CFrame.new(hrp.Position, aimPos)
                    local args = {CFrame.new(aimPos)}
                    evt:FireServer(cf, unpack(args))
                end)
            end
        end
        return
    end
    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if gun then
        if TargetChar then
            if char ~= gun.Parent then
                char.Humanoid:EquipTool(gun)
                task.wait(0)
            end
            local aimPos = PredictionPart.CFrame.Position
            local shootPos = hrp.Position + Vector3.new(0, 1, 0)
            pcall(function()
                local evt = gun:WaitForChild("Shoot")
                local cf = CFrame.new(shootPos, aimPos)
                local args = {CFrame.new(aimPos)}
                evt:FireServer(cf, unpack(args))
            end)
        end
        return
    end
end

local function DoFlick()
    if State.FlickActive then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    State.FlickActive = true
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local orig = hrp.CFrame
        local flipped = orig * CFrame.Angles(0, math.pi, 0)
        for i = 1, 4 do
            hrp.CFrame = orig:Lerp(flipped, i / 4)
            RunService.RenderStepped:Wait()
        end
    else
        local camCF = CurrentCamera.CFrame
        local look = camCF.LookVector
        local target = CFrame.lookAt(camCF.Position, camCF.Position + Vector3.new(-look.X, look.Y, -look.Z))
        for i = 1, 5 do
            CurrentCamera.CFrame = camCF:Lerp(target, i / 5)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.15)
    State.FlickActive = false
end

local function DoWallHop()
    if State.WallHopActive then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    State.WallHopActive = true
    local isShift = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
    local _, yAngle, _ = hrp.CFrame:ToEulerAnglesYXZ()
    local camCF = CurrentCamera.CFrame

    if not isShift then
        local target = yAngle - math.pi / 2
        for i = 1, 7 do
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.fromEulerAnglesYXZ(0, yAngle + (target - yAngle) * (i / 7), 0)
            RunService.RenderStepped:Wait()
        end
    else
        local flatLook = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
        local flatRight = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit
        for i = 1, 7 do
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + flatLook:Lerp(flatRight, camCF.RightVector.Z).Unit)
            RunService.RenderStepped:Wait()
        end
    end

    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 55, hrp.AssemblyLinearVelocity.Z)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    task.wait(0.12)

    if not isShift then
        local _, curY, _ = hrp.CFrame:ToEulerAnglesYXZ()
        for i = 1, 5 do
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.fromEulerAnglesYXZ(0, curY + (yAngle - curY) * (i / 5), 0)
            RunService.RenderStepped:Wait()
        end
    else
        local flatLook = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
        local flatRight = Vector3.new(CurrentCamera.CFrame.LookVector.X, 0, CurrentCamera.CFrame.LookVector.Z).Unit
        for i = 1, 5 do
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + flatRight:Lerp(flatLook, camCF.LookVector.Z).Unit)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.1)
    State.WallHopActive = false
end

task.spawn(function()
    while true do
        task.wait(2)
        pcall(function()
            ReplicatedStorage.Remotes.Extras.ReplicateToy:InvokeServer("FakeBomb")
            ReplicatedStorage.Remotes.Extras.ReplicateToy:InvokeServer("GoldBomb")
        end)
    end
end)

local function SetupSpeed(char)
    local hum = char:WaitForChild("Humanoid")
    if SpeedConn then SpeedConn:Disconnect() end
    SpeedConn = RunService.RenderStepped:Connect(function()
        if State.SpeedGlitch then
            local st = hum:GetState()
            hum.WalkSpeed = (st == Enum.HumanoidStateType.Jumping or st == Enum.HumanoidStateType.Freefall) and (hum.MoveDirection.Magnitude > 0 and Config.SpeedValue) or 16
        else
            hum.WalkSpeed = 16
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(SetupSpeed)
if LocalPlayer.Character then task.spawn(SetupSpeed, LocalPlayer.Character) end

local function SetStretch(on)
    State.Stretch = on
    if not on then
        if StretchConn then StretchConn:Disconnect() StretchConn = nil end
        return
    end
    if StretchConn then StretchConn:Disconnect() end
    StretchConn = RunService.RenderStepped:Connect(function()
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, Config.StretchRes, 0, 0, 0, 1)
    end)
end

getgenv().VexonOldPos = nil
getgenv().VexonFPDH = Workspace.FallenPartsDestroyHeight

print("[Vexon] Functions loaded")

local function DoFling(targetPlr)
    if State.Flinging then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local root = hum.RootPart
    if not root then return end
    local tChar = targetPlr.Character
    if not tChar then return end
    local tHum = tChar:FindFirstChildOfClass("Humanoid")
    local tRoot = tHum and tHum.RootPart
    local tHead = tChar:FindFirstChild("Head")
    local tAcc = tChar:FindFirstChildOfClass("Accessory")
    local tHandle = tAcc and tAcc:FindFirstChild("Handle")

    if root.Velocity.Magnitude < 50 then
        getgenv().VexonOldPos = root.CFrame
    end

    if not tHum or not tHum.Sit then
        local attachPart = tHead or tHandle or tHum
        if attachPart then
            Workspace.CurrentCamera.CameraSubject = attachPart
        end

        if tChar:FindFirstChildWhichIsA("BasePart") then
            local myRoot = root
            local myChar = char

            local function FlingTo(part, offset, rot)
                myRoot.CFrame = CFrame.new(part.Position) * offset * rot
                pcall(function() myChar:SetPrimaryPartCFrame(CFrame.new(part.Position) * offset * rot) end)
                myRoot.Velocity = Vector3.new(9e7, 9e8, 9e7)
                myRoot.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end

            State.Flinging = true
            Workspace.FallenPartsDestroyHeight = 0/0

            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Parent = root

            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

            local flingPart = tRoot or tHead or tHandle
            if flingPart then
                local endTime = tick() + 2.5
                local spinAngle = 0
                while myRoot and tHum do
                    local mag = flingPart.Velocity.Magnitude
                    if mag >= 40 then
                        local md = tHum.MoveDirection
                        local ws = tHum.WalkSpeed
                        FlingTo(flingPart, CFrame.new(md.X * ws * 0.12, 3, md.Z * ws * 0.12), CFrame.Angles(math.pi/2, 0, 0))
                        myRoot.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FlingTo(flingPart, CFrame.new(-md.X * ws * 0.06, -3, -md.Z * ws * 0.06), CFrame.Angles(0, 0, 0))
                        myRoot.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FlingTo(flingPart, CFrame.new(md.X * ws * 0.18, 3, md.Z * ws * 0.18), CFrame.Angles(math.pi/2, 0, 0))
                        myRoot.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FlingTo(flingPart, CFrame.new(-md.X * ws * 0.06, -3, -md.Z * ws * 0.06), CFrame.Angles(0, 0, 0))
                        myRoot.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                    else
                        spinAngle = spinAngle + 100
                        FlingTo(flingPart, CFrame.new(0, 1.5, 0) + tHum.MoveDirection * mag / 1.25, CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                        FlingTo(flingPart, CFrame.new(0, -1.5, 0) + tHum.MoveDirection * mag / 1.25, CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                        FlingTo(flingPart, CFrame.new(0, 1.5, 0) + tHum.MoveDirection * mag / 1.25, CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                        FlingTo(flingPart, CFrame.new(0, -1.5, 0) + tHum.MoveDirection * mag / 1.25, CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                        FlingTo(flingPart, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                        FlingTo(flingPart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(spinAngle), 0, 0))
                        task.wait()
                    end
                    if endTime < tick() then break end
                end
            end

            bv:Destroy()
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            Workspace.CurrentCamera.CameraSubject = hum

            if getgenv().VexonOldPos then
                local count = 0
                repeat
                    count = count + 1
                    root.CFrame = getgenv().VexonOldPos * CFrame.new(0, 0.5, 0)
                    pcall(function() char:SetPrimaryPartCFrame(getgenv().VexonOldPos * CFrame.new(0, 0.5, 0)) end)
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    for _, child in ipairs(char:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Velocity = Vector3.new()
                            child.RotVelocity = Vector3.new()
                        end
                    end
                    task.wait()
                until count > 30 or (root.Position - getgenv().VexonOldPos.p).Magnitude < 25
                Workspace.FallenPartsDestroyHeight = getgenv().VexonFPDH
            end
            State.Flinging = false
        end
    end
end

local function FlingMurderer()
    if State.Flinging then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and (plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife"))) then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                task.spawn(DoFling, plr)
                return
            end
        end
    end
end

local function FlingSheriff()
    if State.Flinging then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and (plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun"))) then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                task.spawn(DoFling, plr)
                return
            end
        end
    end
end

local function GrabGun()
    local gunDrop = Workspace:FindFirstChild("GunDrop", true)
    if not gunDrop then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local gunPos
    if not gunDrop:IsA("BasePart") then
        local handle = gunDrop:FindFirstChild("Handle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop.PrimaryPart
        gunPos = handle and handle.Position or gunDrop:GetModelCFrame().Position
    else
        gunPos = gunDrop.Position
    end
    if gunPos then
        local oldCF = hrp.CFrame
        hrp.CFrame = CFrame.new(gunPos + Vector3.new(0, 2, 0))
        task.wait(0.2)
        hrp.CFrame = oldCF
    end
end

local function ShowGunMarker(part)
    if GunMarker then GunMarker:Destroy() GunMarker = nil end
    if GunHighlight then GunHighlight:Destroy() GunHighlight = nil end
    if GunBillboard then GunBillboard:Destroy() GunBillboard = nil end

    local marker = Instance.new("Part")
    marker.Name = "VexonGunMarker"
    marker.Size = Vector3.new(1.5, 0.15, 1.5)
    marker.Anchored = true
    marker.CanCollide = false
    marker.CastShadow = false
    marker.Material = Enum.Material.Neon
    marker.Color = Color3.fromRGB(50, 255, 80)
    marker.Transparency = 0.25
    marker.CFrame = CFrame.new(part)
    marker.Parent = Workspace

    task.spawn(function()
        while marker and marker.Parent do
            for i = 0, 1, 0.05 do
                if not marker or not marker.Parent then break end
                marker.Transparency = 0.25 + 0.5 * math.sin(i * math.pi)
                task.wait(0.03)
            end
        end
    end)
    GunMarker = marker
end

local function HighlightGun(gunObj)
    if not State.GunESP then return end
    if GunHighlight then GunHighlight:Destroy() GunHighlight = nil end
    if GunBillboard then GunBillboard:Destroy() GunBillboard = nil end

    local hl = Instance.new("Highlight")
    hl.Adornee = gunObj
    hl.FillColor = Color3.fromRGB(255, 215, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.35
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = gunObj
    GunHighlight = hl

    local handle = gunObj:FindFirstChild("Handle") or (gunObj:IsA("Model") and gunObj.PrimaryPart) or gunObj:FindFirstChildWhichIsA("BasePart") or (gunObj:IsA("BasePart") and gunObj)
    if not handle then
        if gunObj:IsA("Model") then
            ShowGunMarker(gunObj:GetModelCFrame().Position + Vector3.new(0, 0.1, 0))
        end
        return
    end

    ShowGunMarker(handle.Position + Vector3.new(0, 0.1, 0))

    local bb = Instance.new("BillboardGui")
    bb.Adornee = handle
    bb.Size = UDim2.new(0, 130, 0, 36)
    bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 300
    bb.Parent = handle

    local bf = Instance.new("Frame", bb)
    bf.Size = UDim2.new(1, 0, 1, 0)
    bf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bf.BackgroundTransparency = 0.4
    bf.BorderSizePixel = 0
    Instance.new("UICorner", bf).CornerRadius = UDim.new(0, 6)

    local bs = Instance.new("UIStroke", bf)
    bs.Color = Color3.fromRGB(255, 215, 0)
    bs.Thickness = 1.5
    bs.Transparency = 0.1

    local bl = Instance.new("TextLabel", bf)
    bl.Size = UDim2.new(1, 0, 1, 0)
    bl.BackgroundTransparency = 1
    bl.Text = "GUN ON MAP"
    bl.TextColor3 = Color3.fromRGB(255, 215, 0)
    bl.Font = Enum.Font.GothamBlack
    bl.TextSize = 13
    bl.TextStrokeTransparency = 0.4
    bl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    GunBillboard = bb
end

local function ClearGunVisuals()
    if GunHighlight then GunHighlight:Destroy() GunHighlight = nil end
    if GunBillboard then GunBillboard:Destroy() GunBillboard = nil end
    if GunMarker then GunMarker:Destroy() GunMarker = nil end
end

local function WatchForGun(container)
    local watched = {}
    local function watch(c)
        if watched[c] then return end
        watched[c] = true
        c.ChildAdded:Connect(function(child)
            if child.Name == "GunDrop" then
                task.wait(0.1)
                if State.GunESP then HighlightGun(child) end
            end
            if child:IsA("Model") or child:IsA("Folder") then watch(child) end
        end)
        c.ChildRemoved:Connect(function(child)
            if child.Name == "GunDrop" then ClearGunVisuals() end
        end)
        for _, child in ipairs(c:GetChildren()) do
            if child:IsA("Model") or child:IsA("Folder") then watch(child) end
        end
    end
    watch(container)
end

WatchForGun(Workspace)
Workspace.ChildAdded:Connect(function(c)
    if c:IsA("Model") or c:IsA("Folder") then WatchForGun(c) end
    if c.Name == "GunDrop" then
        task.wait(0.1)
        if State.GunESP then HighlightGun(c) end
    end
end)

task.spawn(function()
    task.wait(1.5)
    local gd = Workspace:FindFirstChild("GunDrop", true)
    if gd then
        if State.GunESP then HighlightGun(gd) end
    end
end)

local function WatchPlayerGun(plr)
    if plr == LocalPlayer then return end
    task.spawn(function()
        local function onChar(char)
            if not char then return end
            local hum = char:WaitForChild("Humanoid", 5)
            if not hum then return end
            hum.Died:Connect(function()
                if plr.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                    task.delay(0.8, function()
                        local gd = Workspace:FindFirstChild("GunDrop", true)
                        if gd then
                            if State.GunESP then HighlightGun(gd) end
                        end
                    end)
                end
            end)
        end
        if plr.Character then onChar(plr.Character) end
        plr.CharacterAdded:Connect(onChar)
    end)
end

for _, plr in ipairs(Players:GetPlayers()) do WatchPlayerGun(plr) end
Players.PlayerAdded:Connect(WatchPlayerGun)

print("[Vexon] Combat loaded")

local function ClearESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local esp = plr.Character:FindFirstChild("VexonESP")
            if esp then esp:Destroy() end
        end
    end
    ESPData = {}
    ESPLastUpdate = 0
end

local function GetRole(plr)
    local role = "Innocent"
    local data = ESPData[plr.Name]
    if data then
        local r = data.Role or data.role or data.Team or ""
        local rl = tostring(r):lower()
        if rl:find("murd") then return "Murderer" end
        if rl:find("sheriff") or rl:find("gun") then return "Sheriff" end
        if rl:find("hero") then role = "Hero" end
    end
    return role
end

local function ApplyESP(char, color)
    local esp = char:FindFirstChild("VexonESP") or Instance.new("Highlight")
    esp.Name = "VexonESP"
    esp.Parent = char
    esp.FillColor = color
    esp.FillTransparency = 0.7
    esp.OutlineColor = Color3.fromRGB(255, 255, 255)
    esp.OutlineTransparency = 0.15
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

local function StartESP()
    local remote = ReplicatedStorage:FindFirstChild("GetCurrentPlayerData", true)
    if not remote or not remote:IsA("RemoteFunction") then
        State.ESP = false
        return
    end
    if ESPConn then ESPConn:Disconnect() ESPConn = nil end
    ESPConn = RunService.Heartbeat:Connect(function()
        if State.ESP then
            if tick() - ESPLastUpdate > 0.5 then
                local ok, result = pcall(function() return remote:InvokeServer() end)
                if ok and type(result) == "table" then ESPData = result end
                ESPLastUpdate = tick()
            end
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then
                    local role = GetRole(plr)
                    local show = ESPFilters[role]
                    if plr == LocalPlayer and not ESPFilters.Self then show = false end
                    if not show then
                        local esp = plr.Character:FindFirstChild("VexonESP")
                        if esp then esp:Destroy() end
                    else
                        ApplyESP(plr.Character, ESPColors[role])
                    end
                end
            end
        end
    end)
end

local function SetAntiFling(on)
    if AntiFlingConn then AntiFlingConn:Disconnect() AntiFlingConn = nil end
    if not on then return end
    AntiFlingConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local vel = hrp.AssemblyLinearVelocity
            if vel.Magnitude > Config.VelocityCap then
                hrp.AssemblyLinearVelocity = vel.Unit * Config.VelocityCap
            end
        end
    end)
end

local function ApplyGfxPart(obj)
    if obj:IsA("BasePart") then
        if not GfxSaved[obj] then
            GfxSaved[obj] = {Material = obj.Material, CastShadow = obj.CastShadow}
        end
        obj.Material = Enum.Material.SmoothPlastic
        obj.CastShadow = false
    end
    if obj:IsA("Decal") or obj:IsA("Texture") then
        if not GfxSaved[obj] then
            GfxSaved[obj] = {Transparency = obj.Transparency}
        end
        obj.Transparency = 1
    end
end

local function EnableLowGfx()
    if State.HighGfx then
        State.HighGfx = false
        Lighting.Brightness = GfxOriginal.Brightness
        Lighting.GlobalShadows = GfxOriginal.GlobalShadows
        Lighting.Ambient = GfxOriginal.Ambient
        Lighting.OutdoorAmbient = GfxOriginal.OutdoorAmbient
        for _, child in pairs(Lighting:GetChildren()) do
            if child:IsA("BloomEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") then
                child:Destroy()
            end
        end
    end
    State.LowGfx = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() setfpscap(9999) end)
    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
    for _, desc in ipairs(Workspace:GetDescendants()) do
        pcall(function() ApplyGfxPart(desc) end)
    end
    if GfxConn then GfxConn:Disconnect() end
    GfxConn = Workspace.DescendantAdded:Connect(function(desc)
        task.wait(0.1)
        pcall(function() ApplyGfxPart(desc) end)
    end)
    if FPSLabel then FPSLabel.Visible = true end
end

local function DisableLowGfx()
    State.LowGfx = false
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    Lighting.GlobalShadows = GfxOriginal.GlobalShadows
    Lighting.Brightness = GfxOriginal.Brightness
    Lighting.Ambient = GfxOriginal.Ambient
    Lighting.OutdoorAmbient = GfxOriginal.OutdoorAmbient
    if GfxConn then GfxConn:Disconnect() GfxConn = nil end
    for k, v in pairs(GfxSaved) do
        if k and k.Parent then
            pcall(function()
                for k2, v2 in pairs(v) do k[k2] = v2 end
            end)
        end
    end
    GfxSaved = {}
    if FPSLabel then FPSLabel.Visible = false end
end

local function EnableHighGfx()
    if State.LowGfx then DisableLowGfx() end
    State.HighGfx = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level21 end)
    Lighting.GlobalShadows = true
    Lighting.Brightness = 3.5
    Lighting.Ambient = Color3.fromRGB(80, 80, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 110, 130)
    local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
    bloom.Intensity = 0.6
    bloom.Size = 24
    bloom.Threshold = 0.95
    local sun = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
    sun.Intensity = 0.25
    sun.Spread = 1
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Saturation = 0.2
    cc.Contrast = 0.1
    cc.Brightness = 0.05
end

local function DisableHighGfx()
    State.HighGfx = false
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    Lighting.Brightness = GfxOriginal.Brightness
    Lighting.GlobalShadows = GfxOriginal.GlobalShadows
    Lighting.Ambient = GfxOriginal.Ambient
    Lighting.OutdoorAmbient = GfxOriginal.OutdoorAmbient
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("BloomEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") then
            child:Destroy()
        end
    end
end

do
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        SavedSky = {
            SkyboxBk = sky.SkyboxBk, SkyboxDn = sky.SkyboxDn,
            SkyboxFt = sky.SkyboxFt, SkyboxLf = sky.SkyboxLf,
            SkyboxRt = sky.SkyboxRt, SkyboxUp = sky.SkyboxUp,
        }
    end
end

local function RestoreSky()
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then child:Destroy() end
    end
    if SavedSky then
        local sky = Instance.new("Sky", Lighting)
        for k, v in pairs(SavedSky) do sky[k] = v end
    end
    SkyActive = false
end

local function ApplySkybox(id)
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then child:Destroy() end
    end
    local sky = Instance.new("Sky", Lighting)
    sky.Name = "VexonCustomSky"
    local asset = "rbxassetid://" .. tostring(id)
    sky.SkyboxBk = asset
    sky.SkyboxDn = asset
    sky.SkyboxFt = asset
    sky.SkyboxLf = asset
    sky.SkyboxRt = asset
    sky.SkyboxUp = asset
    sky.SunTextureId = ""
    sky.MoonTextureId = ""
    sky.SunAngularSize = 0
    sky.StarCount = 0
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    SkyActive = true
end

print("[Vexon] ESP/GFX loaded")

-- ÖZEL AUTOFARM MANTLIĞI
local function GetPlayerRole(plr)
    local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true) or ReplicatedStorage:FindFirstChild("GetCurrentPlayerData", true)
    if remote and remote:IsA("RemoteFunction") then
        local ok, result = pcall(function() return remote:InvokeServer() end)
        if ok and result and result[plr.Name] then
            return result[plr.Name].Role
        end
    end
    return nil
end

local function GetMurderer()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local role = GetPlayerRole(plr)
            if role == "Murderer" then
                return plr
            end
        end
    end
    return nil
end

local function FlingTarget(targetPlr)
    if State.Flinging then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local root = hum.RootPart
    if not root then return end
    local tChar = targetPlr.Character
    if not tChar then return end
    local tHum = tChar:FindFirstChildOfClass("Humanoid")
    local tRoot = tHum and tHum.RootPart

    if not tHum or not tRoot then return end

    getgenv().VexonOldPos = root.CFrame

    State.Flinging = true
    Workspace.FallenPartsDestroyHeight = 0/0

    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = root

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local endTime = tick() + 3
    local spinAngle = 0

    while root and tHum and tick() < endTime do
        local mag = tRoot.Velocity.Magnitude
        if mag >= 40 then
            root.CFrame = CFrame.new(tRoot.Position) * CFrame.new(tHum.MoveDirection.X * tHum.WalkSpeed * 0.12, 3, tHum.MoveDirection.Z * tHum.WalkSpeed * 0.12) * CFrame.Angles(math.pi/2, 0, 0)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
            root.CFrame = CFrame.new(tRoot.Position) * CFrame.new(-tHum.MoveDirection.X * tHum.WalkSpeed * 0.06, -3, -tHum.MoveDirection.Z * tHum.WalkSpeed * 0.06)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
        else
            spinAngle = spinAngle + 100
            root.CFrame = CFrame.new(tRoot.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(spinAngle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(tRoot.Position) * CFrame.new(0, -1.5, 0) * CFrame.Angles(math.rad(spinAngle), 0, 0)
            task.wait()
        end
    end

    bv:Destroy()
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

    if getgenv().VexonOldPos then
        local count = 0
        repeat
            count = count + 1
            root.CFrame = getgenv().VexonOldPos * CFrame.new(0, 0.5, 0)
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            for _, child in ipairs(char:GetChildren()) do
                if child:IsA("BasePart") then
                    child.Velocity = Vector3.new()
                    child.RotVelocity = Vector3.new()
                end
            end
            task.wait()
        until count > 30 or (root.Position - getgenv().VexonOldPos.p).Magnitude < 25
        Workspace.FallenPartsDestroyHeight = getgenv().VexonFPDH
    end
    State.Flinging = false
end

local function SheriffShootMurderer()
    local murderer = GetMurderer()
    if not murderer then return false end

    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local mChar = murderer.Character
    if not mChar then return false end
    local mHrp = mChar:FindFirstChild("HumanoidRootPart")
    local mHum = mChar:FindFirstChildOfClass("Humanoid")
    if not mHrp or not mHum or mHum.Health <= 0 then return false end

    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if not gun then return false end

    getgenv().VexonOldPos = hrp.CFrame

    if char ~= gun.Parent then
        char.Humanoid:EquipTool(gun)
        task.wait(0.1)
    end

    local maxAttempts = 10
    local attempt = 0

    while attempt < maxAttempts do
        attempt = attempt + 1

        if not mChar or not mHrp or not mHum or mHum.Health <= 0 then
            break
        end

        local behindPos = mHrp.CFrame * CFrame.new(0, 0, -3)
        hrp.CFrame = behindPos

        task.wait(0.05)

        local dist = (hrp.Position - mHrp.Position).Magnitude
        if dist <= Config.ShootRange then
            local vel = mHrp.AssemblyLinearVelocity
            local aimPos = mHrp.Position + Vector3.new(vel.X, 0, vel.Z) * 0.1

            pcall(function()
                local evt = gun:WaitForChild("Shoot")
                local cf = CFrame.new(hrp.Position + Vector3.new(0, 1, 0), aimPos)
                local args = {CFrame.new(aimPos)}
                evt:FireServer(cf, unpack(args))
            end)

            task.wait(0.3)

            if mHum.Health <= 0 then
                break
            end
        else
            hrp.CFrame = mHrp.CFrame * CFrame.new(0, 0, -Config.ShootRange)
            task.wait(0.05)
        end
    end

    if getgenv().VexonOldPos then
        hrp.CFrame = getgenv().VexonOldPos
    end

    return true
end

local function MurdererKillAll()
    local char = LocalPlayer.Character
    if not char then return end

    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
    if not knife then return end

    if char ~= knife.Parent then
        char.Humanoid:EquipTool(knife)
        task.wait(0.1)
    end

    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local killEvent = remotes and remotes:FindFirstChild("Gameplay") and remotes.Gameplay:FindFirstChild("KillEvent")
    if not killEvent then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local role = GetPlayerRole(plr)
            if role == "Sheriff" or role == "Hero" or role == "Innocent" then
                local phrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local phum = plr.Character:FindFirstChildOfClass("Humanoid")
                if phrp and phum and phum.Health > 0 then
                    phrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
                    pcall(function()
                        killEvent:FireServer(plr.Name, Color3.new(1, 0, 0))
                    end)
                    task.wait(0.3)
                end
            end
        end
    end
end

local function HandleBagFull()
    if not State.BagFull then return end

    local myRole = GetPlayerRole(LocalPlayer)

    if myRole == "Innocent" or myRole == "Hero" then
        local murderer = GetMurderer()
        if murderer then
            FlingTarget(murderer)
        end
    elseif myRole == "Sheriff" then
        SheriffShootMurderer()
    elseif myRole == "Murderer" then
        MurdererKillAll()
    end

    State.BagFull = false
end

local function GetNearestCoin()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil, math.huge end
    local nearest = nil
    local nearestDist = math.huge
    for _, child in ipairs(Workspace:GetChildren()) do
        if child:FindFirstChild("CoinContainer") then
            for _, coin in ipairs(child.CoinContainer:GetChildren()) do
                if coin:IsA("BasePart") and coin:GetAttribute("CoinID") == "Coin" and coin:FindFirstChild("TouchInterest") then
                    local dist = (hrp.Position - coin.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = coin
                    end
                end
            end
        end
    end
    return nearest, nearestDist
end

task.spawn(function()
    while true do
        local waitTime = 0.1
        if State.AutoFarm and State.Farming and not State.BagFull then
            local coin, dist = GetNearestCoin()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if coin and hrp then
                if dist > 150 then
                    hrp.CFrame = coin.CFrame
                else
                    local tween = TweenService:Create(hrp, TweenInfo.new(dist / 25, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                    tween:Play()
                    local startTime = tick()
                    repeat
                        task.wait()
                        if tick() - startTime > 5 then break end
                    until not coin:FindFirstChild("TouchInterest") or not State.Farming or not State.AutoFarm
                    if tween then tween:Cancel() end
                end
            end
        elseif State.BagFull then
            HandleBagFull()
            waitTime = 1
        else
            waitTime = not State.AutoFarm and 1 or 0.5
        end
        task.wait(waitTime)
    end
end)

local remoteEvents = {}
local function FindRemoteEvents()
    for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
        if desc:IsA("RemoteEvent") then
            if desc.Name == "CoinCollected" then
                remoteEvents.CoinCollected = desc
            elseif desc.Name == "RoundStart" then
                remoteEvents.RoundStart = desc
            elseif desc.Name == "RoundEnd" then
                remoteEvents.RoundEnd = desc
            end
        end
        if remoteEvents.CoinCollected and remoteEvents.RoundStart and remoteEvents.RoundEnd then
            return
        end
    end
end

local function ConnectRemoteEvents()
    if remoteEvents.CoinCollected then
        remoteEvents.CoinCollected.OnClientEvent:Connect(function(_, plr1, plr2)
            if State.AutoFarm then
                FarmStats.CoinsCollected = FarmStats.CoinsCollected + 1
            end
            if plr1 == plr2 then
                State.BagFull = true
            end
        end)
    end
    if remoteEvents.RoundStart then
        remoteEvents.RoundStart.OnClientEvent:Connect(function()
            State.Farming = true
            State.BagFull = false
            FarmStats.StartTime = tick()
            FarmStats.IsRunning = true
            FarmStats.CoinsCollected = 0
        end)
    end
    if remoteEvents.RoundEnd then
        remoteEvents.RoundEnd.OnClientEvent:Connect(function()
            State.Farming = false
        end)
    end
end

FindRemoteEvents()
ConnectRemoteEvents()

print("[Vexon] AutoFarm loaded")

local function SetupCrosshair()
    local existing = game.CoreGui:FindFirstChild("VexonCrosshairDisplay")
    if existing then existing:Destroy() end
    if CrosshairSpinConn then CrosshairSpinConn:Disconnect() CrosshairSpinConn = nil end

    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "VexonCrosshairDisplay"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 25
    sg.IgnoreGuiInset = true

    CrosshairImg = Instance.new("ImageLabel", sg)
    CrosshairImg.AnchorPoint = Vector2.new(0.5, 0.5)
    CrosshairImg.Position = UDim2.new(0.5, 0, 0.5, 0)
    CrosshairImg.Size = UDim2.new(0, 42, 0, 42)
    CrosshairImg.BackgroundTransparency = 1
    CrosshairImg.Image = "rbxassetid://" .. CrosshairID
    CrosshairImg.ZIndex = 10
    CrosshairImg.Visible = false

    if CrosshairRenderConn then CrosshairRenderConn:Disconnect() end
    CrosshairRenderConn = RunService.RenderStepped:Connect(function()
        if CrosshairImg and CrosshairImg.Parent then
            local isShift = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if pg then
                local topbar = pg:FindFirstChild("GameTopbar")
                if topbar and topbar:FindFirstChild("Crosshair") then
                    topbar.Crosshair.Visible = false
                end
            end
            local show = State.Crosshair and isShift
            CrosshairImg.Visible = show
            UserInputService.MouseIconEnabled = not show
        end
    end)

    if State.SpinCrosshair then
        if CrosshairSpinConn then CrosshairSpinConn:Disconnect() end
        CrosshairSpinConn = RunService.RenderStepped:Connect(function()
            if CrosshairImg and CrosshairImg.Parent and CrosshairImg.Visible then
                CrosshairImg.Rotation = CrosshairImg.Rotation + 4
            end
        end)
    end
end

local function UpdateCrosshairSpin()
    if State.SpinCrosshair then
        if CrosshairSpinConn then CrosshairSpinConn:Disconnect() end
        CrosshairSpinConn = RunService.RenderStepped:Connect(function()
            if CrosshairImg and CrosshairImg.Parent and CrosshairImg.Visible then
                CrosshairImg.Rotation = CrosshairImg.Rotation + 4
            end
        end)
    else
        if CrosshairSpinConn then CrosshairSpinConn:Disconnect() CrosshairSpinConn = nil end
        if CrosshairImg then CrosshairImg.Rotation = 0 end
    end
end

local function OpenSkyboxPicker()
    local existing = game.CoreGui:FindFirstChild("VexonSkyboxPicker")
    if existing then existing:Destroy() return end

    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "VexonSkyboxPicker"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 62

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 330, 0, 460)
    frame.Position = UDim2.new(0.5, -165, 0.04, 0)
    frame.BackgroundColor3 = Color3.fromRGB(12, 10, 16)
    frame.BackgroundTransparency = 0.03
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(220, 38, 38)
    stroke.Thickness = 1.8

    local titleLbl = Instance.new("TextLabel", frame)
    titleLbl.Size = UDim2.new(1, -50, 0, 40)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Skybox Picker"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}):Play()
    end)
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(frame, TI_Med, {Size = UDim2.new(0, 330, 0, 0), BackgroundTransparency = 1}):Play()
        task.delay(0.3, function() sg:Destroy() end)
    end)

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(1, -24, 0, 38)
    input.Position = UDim2.new(0, 12, 0, 46)
    input.BackgroundColor3 = Color3.fromRGB(22, 18, 28)
    input.Text = ""
    input.PlaceholderText = "Enter custom Skybox ID, press Enter..."
    input.TextColor3 = Color3.new(1, 1, 1)
    input.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    input.Font = Enum.Font.Gotham
    input.TextSize = 13
    input.ClearTextOnFocus = false
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", input).Color = Color3.fromRGB(80, 80, 80)

    input.FocusLost:Connect(function(enter)
        if enter and input.Text ~= "" then
            ApplySkybox(input.Text)
            input.Text = ""
        end
    end)

    local restoreBtn = Instance.new("TextButton", frame)
    restoreBtn.Size = UDim2.new(1, -24, 0, 32)
    restoreBtn.Position = UDim2.new(0, 12, 0, 92)
    restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
    restoreBtn.Text = "Restore Default Sky"
    restoreBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    restoreBtn.Font = Enum.Font.GothamBold
    restoreBtn.TextSize = 12
    Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(0, 10)

    restoreBtn.MouseEnter:Connect(function()
        TweenService:Create(restoreBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(60, 55, 75)}):Play()
    end)
    restoreBtn.MouseLeave:Connect(function()
        TweenService:Create(restoreBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(40, 35, 50)}):Play()
    end)

    restoreBtn.MouseButton1Click:Connect(function()
        RestoreSky()
        sg:Destroy()
    end)

    local divider = Instance.new("Frame", frame)
    divider.Size = UDim2.new(1, -24, 0, 1)
    divider.Position = UDim2.new(0, 12, 0, 132)
    divider.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
    divider.BorderSizePixel = 0

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -14, 1, -140)
    scroll.Position = UDim2.new(0, 7, 0, 138)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, #SkyboxPresets * 58)

    local listLayout = Instance.new("UIListLayout", scroll)
    listLayout.Padding = UDim.new(0, 6)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for i, preset in ipairs(SkyboxPresets) do
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, -8, 0, 50)
        btn.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.LayoutOrder = i
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = preset.color
        btnStroke.Thickness = 1

        local colorBox = Instance.new("Frame", btn)
        colorBox.Size = UDim2.new(0, 36, 0, 36)
        colorBox.Position = UDim2.new(0, 8, 0.5, -18)
        colorBox.BackgroundColor3 = preset.color
        colorBox.BorderSizePixel = 0
        Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0, 10)

        local nameLbl = Instance.new("TextLabel", btn)
        nameLbl.Size = UDim2.new(1, -60, 0, 24)
        nameLbl.Position = UDim2.new(0, 52, 0, 6)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = preset.name
        nameLbl.TextColor3 = Color3.fromRGB(210, 210, 210)
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextSize = 14
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left

        local idLbl = Instance.new("TextLabel", btn)
        idLbl.Size = UDim2.new(1, -60, 0, 16)
        idLbl.Position = UDim2.new(0, 52, 1, -20)
        idLbl.BackgroundTransparency = 1
        idLbl.Text = "ID: " .. preset.id
        idLbl.TextColor3 = Color3.fromRGB(100, 100, 100)
        idLbl.Font = Enum.Font.Gotham
        idLbl.TextSize = 10
        idLbl.TextXAlignment = Enum.TextXAlignment.Left

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(28, 25, 36)}):Play()
            TweenService:Create(btnStroke, TI_Fast, {Thickness = 2}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(18, 16, 24)}):Play()
            TweenService:Create(btnStroke, TI_Fast, {Thickness = 1}):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            ApplySkybox(preset.id)
            for _, child in ipairs(scroll:GetChildren()) do
                if child:IsA("TextButton") then
                    local s = child:FindFirstChildOfClass("UIStroke")
                    if s then
                        s.Thickness = 1
                        s.Color = Color3.fromRGB(80, 80, 80)
                    end
                    child.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
                end
            end
            btnStroke.Thickness = 2.5
            btnStroke.Color = Color3.fromRGB(220, 38, 38)
            btn.BackgroundColor3 = Color3.fromRGB(45, 12, 12)
            nameLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
        end)
    end

    MakeDraggable(frame)
    ScaleIn(frame, 0.4)
end

local function OpenCursorPicker()
    local existing = game.CoreGui:FindFirstChild("VexonCursorPicker")
    if existing then existing:Destroy() return end

    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "VexonCursorPicker"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 60

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 310, 0, 480)
    frame.Position = UDim2.new(0.5, -155, 0.04, 0)
    frame.BackgroundColor3 = Color3.fromRGB(12, 10, 16)
    frame.BackgroundTransparency = 0.03
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(220, 38, 38)
    stroke.Thickness = 1.8

    local titleLbl = Instance.new("TextLabel", frame)
    titleLbl.Size = UDim2.new(1, -50, 0, 40)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Cursor Picker"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 10)

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TI_Fast, {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}):Play()
    end)
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(frame, TI_Med, {Size = UDim2.new(0, 310, 0, 0), BackgroundTransparency = 1}):Play()
        task.delay(0.3, function() sg:Destroy() end)
    end)

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(1, -24, 0, 38)
    input.Position = UDim2.new(0, 12, 0, 46)
    input.BackgroundColor3 = Color3.fromRGB(22, 18, 28)
    input.Text = ""
    input.PlaceholderText = "Enter custom Cursor ID, press Enter..."
    input.TextColor3 = Color3.new(1, 1, 1)
    input.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    input.Font = Enum.Font.Gotham
    input.TextSize = 13
    input.ClearTextOnFocus = false
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", input).Color = Color3.fromRGB(80, 80, 80)

    input.FocusLost:Connect(function(enter)
        if enter and input.Text ~= "" then
            CrosshairID = input.Text
            if State.Crosshair and CrosshairImg then
                CrosshairImg.Image = "rbxassetid://" .. input.Text
            end
            input.Text = ""
        end
    end)

    local spinRow = Instance.new("Frame", frame)
    spinRow.Size = UDim2.new(1, -24, 0, 34)
    spinRow.Position = UDim2.new(0, 12, 0, 92)
    spinRow.BackgroundTransparency = 1

    local spinLbl = Instance.new("TextLabel", spinRow)
    spinLbl.Size = UDim2.new(1, -64, 1, 0)
    spinLbl.BackgroundTransparency = 1
    spinLbl.Text = "Spin Crosshair"
    spinLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    spinLbl.Font = Enum.Font.GothamBold
    spinLbl.TextSize = 13
    spinLbl.TextXAlignment = Enum.TextXAlignment.Left

    local spinBtn = Instance.new("TextButton", spinRow)
    spinBtn.Size = UDim2.new(0, 58, 0, 30)
    spinBtn.Position = UDim2.new(1, -58, 0.5, -15)
    spinBtn.BackgroundColor3 = State.SpinCrosshair and Color3.fromRGB(30, 160, 30) or Color3.fromRGB(80, 20, 20)
    spinBtn.Text = State.SpinCrosshair and "ON" or "OFF"
    spinBtn.TextColor3 = Color3.new(1, 1, 1)
    spinBtn.Font = Enum.Font.GothamBold
    spinBtn.TextSize = 12
    Instance.new("UICorner", spinBtn).CornerRadius = UDim.new(0, 12)

    spinBtn.MouseButton1Click:Connect(function()
        State.SpinCrosshair = not State.SpinCrosshair
        spinBtn.BackgroundColor3 = State.SpinCrosshair and Color3.fromRGB(30, 160, 30) or Color3.fromRGB(80, 20, 20)
        spinBtn.Text = State.SpinCrosshair and "ON" or "OFF"
        UpdateCrosshairSpin()
    end)

    local divider = Instance.new("Frame", frame)
    divider.Size = UDim2.new(1, -24, 0, 1)
    divider.Position = UDim2.new(0, 12, 0, 132)
    divider.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
    divider.BorderSizePixel = 0

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -14, 1, -140)
    scroll.Position = UDim2.new(0, 7, 0, 138)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#CrosshairPresets / 2) * 122 + 10)

    local grid = Instance.new("UIGridLayout", scroll)
    grid.CellSize = UDim2.new(0, 138, 0, 114)
    grid.CellPadding = UDim2.new(0, 8, 0, 8)
    grid.SortOrder = Enum.SortOrder.LayoutOrder

    for i, preset in ipairs(CrosshairPresets) do
        local isActive = CrosshairID == preset.id
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0, 138, 0, 114)
        btn.BackgroundColor3 = isActive and Color3.fromRGB(50, 14, 14) or Color3.fromRGB(18, 16, 24)
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.LayoutOrder = i
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = isActive and Color3.fromRGB(220, 38, 38) or Color3.fromRGB(50, 50, 50)
        btnStroke.Thickness = isActive and 2 or 1.2

        local img = Instance.new("ImageLabel", btn)
        img.Size = UDim2.new(0, 60, 0, 60)
        img.AnchorPoint = Vector2.new(0.5, 0)
        img.Position = UDim2.new(0.5, 0, 0, 8)
        img.BackgroundTransparency = 1
        img.Image = "rbxassetid://" .. preset.id

        local nameLbl = Instance.new("TextLabel", btn)
        nameLbl.Size = UDim2.new(1, -6, 0, 30)
        nameLbl.Position = UDim2.new(0, 3, 1, -32)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = preset.name .. (isActive and " \u{2713}" or "")
        nameLbl.TextColor3 = isActive and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(200, 200, 200)
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextSize = 11
        nameLbl.TextWrapped = true

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TI_Fast, {BackgroundColor3 = isActive and Color3.fromRGB(60, 18, 18) or Color3.fromRGB(28, 25, 35)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TI_Fast, {BackgroundColor3 = isActive and Color3.fromRGB(50, 14, 14) or Color3.fromRGB(18, 16, 24)}):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            CrosshairID = preset.id
            if State.Crosshair and CrosshairImg then
                CrosshairImg.Image = "rbxassetid://" .. preset.id
            end
            sg:Destroy()
        end)
    end

    MakeDraggable(frame)
    ScaleIn(frame, 0.4)
end

print("[Vexon] Pickers loaded")

local function ToggleGoldBombBtn(on)
    if on then
        local entry = CreateButton("GoldBomb", BtnPositions.GoldBomb, BigSize, Color3.fromRGB(255, 215, 0), "GOLD\nJUMP")
        AddPulseEffect(entry.btn, 0.98, 1.04, 0.9)
        entry.btn.MouseButton1Click:Connect(function()
            if not State.GoldBombCD then
                DoBomb("GoldBomb", false)
            end
        end)
    else
        if BtnRegistry and BtnRegistry.GoldBomb then
            StopPulseEffect(BtnRegistry.GoldBomb.btn)
            BtnRegistry.GoldBomb.btn:Destroy()
            BtnRegistry.GoldBomb = nil
        end
    end
end

local function ToggleNormalBombBtn(on)
    if on then
        local entry = CreateButton("NormalBomb", BtnPositions.NormalBomb, BigSize, Color3.fromRGB(0, 170, 255), "NORMAL\nJUMP")
        AddPulseEffect(entry.btn, 0.98, 1.04, 0.9)
        entry.btn.MouseButton1Click:Connect(function()
            if not State.NormalBombCD then
                DoBomb("FakeBomb", true)
            end
        end)
    else
        if BtnRegistry and BtnRegistry.NormalBomb then
            StopPulseEffect(BtnRegistry.NormalBomb.btn)
            BtnRegistry.NormalBomb.btn:Destroy()
            BtnRegistry.NormalBomb = nil
        end
    end
end

local function ToggleShootBtn(on)
    if on then
        local entry = CreateButton("Shoot", BtnPositions.Shoot, BigSize, Color3.fromRGB(255, 255, 255), "SHOOT")
        AddSpinImage(entry, 5159914132)
        AddPulseEffect(entry.btn, 0.98, 1.04, 0.9)
        entry.btn.MouseButton1Click:Connect(DoShoot)
    else
        if BtnRegistry and BtnRegistry.Shoot then
            StopPulseEffect(BtnRegistry.Shoot.btn)
            BtnRegistry.Shoot.btn:Destroy()
            BtnRegistry.Shoot = nil
        end
    end
end

local function ToggleESPBtn(on)
    if on then
        local entry = CreateButton("ESP", BtnPositions.ESP, SmallSize, Color3.fromRGB(10, 140, 30), "ESP\nOFF")
        AddGlowEffect(entry.btn, 0.2, 0.5)
        entry.btn.MouseButton1Click:Connect(function()
            State.ESP = not State.ESP
            if not State.ESP then
                if ESPConn then ESPConn:Disconnect() ESPConn = nil end
                task.delay(0.1, ClearESP)
                StopGlowEffect(entry.btn)
            else
                StartESP()
                AddGlowEffect(entry.btn, 0.1, 0.3)
            end
        end)
    else
        if BtnRegistry and BtnRegistry.ESP then
            StopGlowEffect(BtnRegistry.ESP.btn)
            BtnRegistry.ESP.btn:Destroy()
            BtnRegistry.ESP = nil
        end
    end
end

local function ToggleFlickBtn(on)
    if on then
        local entry = CreateButton("Flick", BtnPositions.Flick, SmallSize, Color3.fromRGB(180, 50, 255), "FLICK")
        entry.btn.MouseButton1Click:Connect(DoFlick)
    else
        if BtnRegistry.Flick then
            BtnRegistry.Flick.btn:Destroy()
            BtnRegistry.Flick = nil
        end
    end
end

local function ToggleSpeedBtn(on)
    if on then
        local entry = CreateButton("Speed", BtnPositions.Speed, SmallSize, Color3.fromRGB(0, 140, 120), "SPEED")
        AddGlowEffect(entry.btn, 0.2, 0.5)
        entry.btn.MouseButton1Click:Connect(function()
            State.SpeedGlitch = not State.SpeedGlitch
        end)
    else
        if BtnRegistry.Speed then
            StopGlowEffect(BtnRegistry.Speed.btn)
            BtnRegistry.Speed.btn:Destroy()
            BtnRegistry.Speed = nil
        end
    end
end

local function ToggleStretchBtn(on)
    if on then
        local entry = CreateButton("Stretch", BtnPositions.Stretch, SmallSize, Color3.fromRGB(200, 80, 0), "STRETCH")
        entry.btn.MouseButton1Click:Connect(function()
            State.Stretch = not State.Stretch
            SetStretch(State.Stretch)
        end)
    else
        if BtnRegistry.Stretch then
            BtnRegistry.Stretch.btn:Destroy()
            BtnRegistry.Stretch = nil
        end
    end
end

local function ToggleGrabGunBtn(on)
    if on then
        local entry = CreateButton("GrabGun", BtnPositions.GrabGun, SmallSize, Color3.fromRGB(200, 120, 0), "GRAB\nGUN")
        entry.btn.MouseButton1Click:Connect(GrabGun)
    else
        if BtnRegistry.GrabGun then
            BtnRegistry.GrabGun.btn:Destroy()
            BtnRegistry.GrabGun = nil
        end
    end
end

local function ToggleWallHopBtn(on)
    if on then
        local entry = CreateButton("WallHop", BtnPositions.WallHop, SmallSize, Color3.fromRGB(0, 210, 210), "WALL\nHOP")
        entry.btn.MouseButton1Click:Connect(DoWallHop)
    else
        if BtnRegistry.WallHop then
            BtnRegistry.WallHop.btn:Destroy()
            BtnRegistry.WallHop = nil
        end
    end
end

local function ToggleFlingMurdererBtn(on)
    if on then
        local entry = CreateButton("FlingMurderer", BtnPositions.FlingMurderer, SmallSize, Color3.fromRGB(255, 50, 50), "FLING\nMURD")
        entry.btn.MouseButton1Click:Connect(FlingMurderer)
    else
        if BtnRegistry.FlingMurderer then
            BtnRegistry.FlingMurderer.btn:Destroy()
            BtnRegistry.FlingMurderer = nil
        end
    end
end

local function ToggleFlingSheriffBtn(on)
    if on then
        local entry = CreateButton("FlingSheriff", BtnPositions.FlingSheriff, SmallSize, Color3.fromRGB(40, 130, 255), "FLING\nSHERIF")
        entry.btn.MouseButton1Click:Connect(FlingSheriff)
    else
        if BtnRegistry.FlingSheriff then
            BtnRegistry.FlingSheriff.btn:Destroy()
            BtnRegistry.FlingSheriff = nil
        end
    end
end

RunService.Heartbeat:Connect(function()
    if BtnRegistry and BtnRegistry.GoldBomb then
        BtnRegistry.GoldBomb.lbl.Text = State.GoldBombCD and "WAIT..." or "GOLD\nJUMP"
    end
    if BtnRegistry and BtnRegistry.NormalBomb then
        BtnRegistry.NormalBomb.lbl.Text = State.NormalBombCD and "WAIT..." or "NORMAL\nJUMP"
    end
    if BtnRegistry.Shoot and BtnRegistry.Shoot.img then
        local hasKnife = LocalPlayer.Backpack:FindFirstChild("Knife") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife"))
        BtnRegistry.Shoot.img.Image = hasKnife and "rbxassetid://9695655416" or "rbxassetid://5159914132"
        BtnRegistry.Shoot.lbl.Text = hasKnife and "THROW" or "SHOOT"
    end
    if BtnRegistry and BtnRegistry.ESP then
        local c = State.ESP and Color3.fromRGB(50, 220, 80) or Color3.fromRGB(10, 140, 30)
        BtnRegistry.ESP.lbl.Text = State.ESP and "ESP\nON" or "ESP\nOFF"
        BtnRegistry.ESP.lbl.TextColor3 = c
        BtnRegistry.ESP.stroke.Color = c
    end
    if BtnRegistry.Flick then
        local isShift = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        local c = State.FlickActive and Color3.fromRGB(255, 120, 0) or (isShift and Color3.fromRGB(120, 200, 255) or Color3.fromRGB(180, 50, 255))
        BtnRegistry.Flick.lbl.Text = State.FlickActive and "WAIT..." or "FLICK"
        BtnRegistry.Flick.lbl.TextColor3 = c
        BtnRegistry.Flick.stroke.Color = c
    end
    if BtnRegistry.WallHop then
        local isShift = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        local c = State.WallHopActive and Color3.fromRGB(255, 120, 0) or (isShift and Color3.fromRGB(0, 255, 220) or Color3.fromRGB(0, 210, 210))
        BtnRegistry.WallHop.lbl.Text = State.WallHopActive and "WAIT..." or "WALL\nHOP"
        BtnRegistry.WallHop.lbl.TextColor3 = c
        BtnRegistry.WallHop.stroke.Color = c
    end
    if BtnRegistry.Speed then
        local c = State.SpeedGlitch and Color3.fromRGB(0, 220, 200) or Color3.fromRGB(0, 140, 120)
        BtnRegistry.Speed.lbl.Text = State.SpeedGlitch and "SPEED\nON" or "SPEED"
        BtnRegistry.Speed.lbl.TextColor3 = c
        BtnRegistry.Speed.stroke.Color = c
    end
    if BtnRegistry.Stretch then
        local c = State.Stretch and Color3.fromRGB(255, 140, 30) or Color3.fromRGB(200, 80, 0)
        BtnRegistry.Stretch.lbl.Text = State.Stretch and "STRETCH\nON" or "STRETCH"
        BtnRegistry.Stretch.lbl.TextColor3 = c
        BtnRegistry.Stretch.stroke.Color = c
    end
    if BtnRegistry.GrabGun then
        local gd = Workspace:FindFirstChild("GunDrop", true)
        local c = gd and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 100, 0)
        BtnRegistry.GrabGun.lbl.Text = gd and "GRAB\nGUN" or "NO\nGUN"
        BtnRegistry.GrabGun.lbl.TextColor3 = c
        BtnRegistry.GrabGun.stroke.Color = c
    end
    if BtnRegistry.FlingMurderer then
        local found = false
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and (plr.Backpack:FindFirstChild("Knife") or (plr.Character and plr.Character:FindFirstChild("Knife"))) then
                found = true
                break
            end
        end
        local c = State.Flinging and Color3.fromRGB(255, 180, 0) or (found and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(200, 20, 20))
        BtnRegistry.FlingMurderer.lbl.Text = State.Flinging and "FLING..." or (found and "FLING\nMURD" or "NO\nMURD")
        BtnRegistry.FlingMurderer.lbl.TextColor3 = c
        BtnRegistry.FlingMurderer.stroke.Color = c
    end
    if BtnRegistry.FlingSheriff then
        local found = false
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and (plr.Backpack:FindFirstChild("Gun") or (plr.Character and plr.Character:FindFirstChild("Gun"))) then
                found = true
                break
            end
        end
        local c = State.Flinging and Color3.fromRGB(255, 180, 0) or (found and Color3.fromRGB(40, 130, 255) or Color3.fromRGB(10, 80, 200))
        BtnRegistry.FlingSheriff.lbl.Text = State.Flinging and "FLING..." or (found and "FLING\nSHERIF" or "NO\nSHERIF")
        BtnRegistry.FlingSheriff.lbl.TextColor3 = c
        BtnRegistry.FlingSheriff.stroke.Color = c
    end
end)

do
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "VexonFPSDisplay"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 40

    FPSLabel = Instance.new("TextLabel", sg)
    FPSLabel.Size = UDim2.new(0, 28, 0, 28)
    FPSLabel.Position = UDim2.new(1, -34, 0, 4)
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Text = "\u{2605}"
    FPSLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    FPSLabel.Font = Enum.Font.GothamBold
    FPSLabel.TextSize = 22
    FPSLabel.Visible = false
end

print("[Vexon] Buttons loaded")




local function JoinAnotherServer()
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        local code = TeleportService:ReserveServer(game.PlaceId)
        if code then
            TeleportService:TeleportToPrivateServer(game.PlaceId, code, {LocalPlayer})
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

local function RejoinServer()
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end


local function SetupAntiAFK()
    if AntiAFKServis then task.cancel(AntiAFKServis) AntiAFKServis = nil end
    if not State.AntiAFK then return end
    AntiAFKServis = task.spawn(function()
        while State.AntiAFK do
            task.wait(300)
            pcall(function()
                local vu = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
                local cam = Workspace.CurrentCamera
                if vu and cam then
                    vu:Button2Down(Vector2.new(0, 0), cam.CFrame)
                    task.wait(0.1)
                    vu:Button2Up(Vector2.new(0, 0), cam.CFrame)
                end
            end)
        end
    end)
end


local function CreatePerformanceOverlay()
    if PerformanceOverlay then return end
    local Stats = game:GetService("Stats")
    local sg = Instance.new("ScreenGui")
    sg.Name = "VexonStats"
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.DisplayOrder = 95
    sg.ResetOnSpawn = false
    sg.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Name = "StatsFrame"
    frame.Size = UDim2.new(0, 110, 0, 45)
    frame.Position = UDim2.new(0.5, -55, 0.5, -22)
    frame.BackgroundColor3 = COLORS.Dark2
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = sg

    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 20, 35))
    })
    grad.Rotation = 90
    grad.Parent = frame

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -4, 1, -4)
    container.Position = UDim2.new(0, 2, 0, 2)
    container.BackgroundTransparency = 1
    container.Parent = frame

    local pingLbl = Instance.new("TextLabel")
    pingLbl.Name = "Ping"
    pingLbl.Size = UDim2.new(1, 0, 0.5, 0)
    pingLbl.Position = UDim2.new(0, 0, 0, 0)
    pingLbl.BackgroundTransparency = 1
    pingLbl.TextColor3 = COLORS.White
    pingLbl.TextXAlignment = Enum.TextXAlignment.Center
    pingLbl.TextYAlignment = Enum.TextYAlignment.Center
    pingLbl.Font = Enum.Font.GothamMedium
    pingLbl.TextSize = 10
    pingLbl.RichText = true
    pingLbl.Text = "Ping: ..."
    pingLbl.Parent = container

    local fpsLbl = Instance.new("TextLabel")
    fpsLbl.Name = "FPS"
    fpsLbl.Size = UDim2.new(1, 0, 0.5, 0)
    fpsLbl.Position = UDim2.new(0, 0, 0.5, 0)
    fpsLbl.BackgroundTransparency = 1
    fpsLbl.TextColor3 = COLORS.White
    fpsLbl.TextXAlignment = Enum.TextXAlignment.Center
    fpsLbl.TextYAlignment = Enum.TextYAlignment.Center
    fpsLbl.Font = Enum.Font.GothamMedium
    fpsLbl.TextSize = 10
    fpsLbl.RichText = true
    fpsLbl.Text = "FPS: ..."
    fpsLbl.Parent = container

    local dragging = false
    local dragStart, startPos
    local dragBtn = Instance.new("TextButton")
    dragBtn.Name = "Drag"
    dragBtn.Size = UDim2.new(1, 0, 1, 0)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = frame

    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            startPos = frame.Position
        end
    end)
    dragBtn.InputChanged:Connect(function(input)
        if not dragStart then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
            if not dragging and delta.Magnitude > 5 then
                dragging = true
            end
            if dragging then
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)
    dragBtn.InputEnded:Connect(function()
        dragging = false
    end)

    local lastTime = tick()
    local frameCount = 0
    local conn = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTime >= 1 then
            local ok, ping = pcall(function()
                return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            if ok then
                pingLbl.Text = "Ping: " .. ping
            end
            fpsLbl.Text = "FPS: " .. frameCount
            lastTime = tick()
            frameCount = 0
        end
    end)

    PerformanceOverlay = {
        gui = sg,
        frame = frame,
        destroy = function()
            if conn then conn:Disconnect() end
            if sg then sg:Destroy() end
            PerformanceOverlay = nil
        end
    }
end


local EffectAssets = {
    AngelWings = "rbxassetid://123456789", DemonWings = "rbxassetid://123456790",
    ButterflyWings = "rbxassetid://123456791", DragonWings = "rbxassetid://123456792",
    FairyWings = "rbxassetid://123456793", BatWings = "rbxassetid://123456794",
    Halo = "rbxassetid://123456795", DemonHorns = "rbxassetid://123456796",
    Crown = "rbxassetid://123456797", Hat = "rbxassetid://123456798",
    Mask = "rbxassetid://123456799", Glasses = "rbxassetid://123456800",
    Aura = "rbxassetid://123456801", FireAura = "rbxassetid://123456802",
    IceAura = "rbxassetid://123456803", LightningAura = "rbxassetid://123456804",
    PoisonAura = "rbxassetid://123456805", ShadowAura = "rbxassetid://123456806",
    RainbowAura = "rbxassetid://123456807", Sparkles = "rbxassetid://123456808",
    FireSparkles = "rbxassetid://123456809", IceSparkles = "rbxassetid://123456810",
    GalaxySparkles = "rbxassetid://123456811", Hearts = "rbxassetid://123456812",
    Stars = "rbxassetid://123456813", MusicNotes = "rbxassetid://123456814",
    Skulls = "rbxassetid://123456815", Trail = "rbxassetid://123456816",
    FireTrail = "rbxassetid://123456817", IceTrail = "rbxassetid://123456818",
    RainbowTrail = "rbxassetid://123456819", LightningTrail = "rbxassetid://123456820",
    GhostTrail = "rbxassetid://123456821", Footsteps = "rbxassetid://123456822",
    FireFootsteps = "rbxassetid://123456823", IceFootsteps = "rbxassetid://123456824",
    GhostEffect = "rbxassetid://123456825",
}

local ActiveEffects = {}

local function AttachEffect(effectName, assetId)
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local oldEffect = ActiveEffects[effectName]
    if oldEffect then
        oldEffect:Destroy()
        ActiveEffects[effectName] = nil
    end

    local effect = Instance.new("ParticleEmitter")
    effect.Name = "Vexon_" .. effectName
    effect.Texture = assetId
    effect.Rate = 10
    effect.Lifetime = NumberRange.new(1, 2)
    effect.Speed = NumberRange.new(0, 1)
    effect.SpreadAngle = Vector2.new(360, 360)
    effect.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
    effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
    effect.LightEmission = 0.5
    effect.Parent = hrp

    ActiveEffects[effectName] = effect
    return effect
end

local function RemoveEffect(effectName)
    local effect = ActiveEffects[effectName]
    if effect then
        effect:Destroy()
        ActiveEffects[effectName] = nil
    end
end

local function ToggleEffect(effectName, enabled)
    VisualEffects[effectName] = enabled
    if enabled then
        local assetId = EffectAssets[effectName]
        if assetId then
            AttachEffect(effectName, assetId)
        end
    else
        RemoveEffect(effectName)
    end
end

local function ClearAllEffects()
    for name, _ in pairs(ActiveEffects) do
        RemoveEffect(name)
    end
    for name, _ in pairs(VisualEffects) do
        VisualEffects[name] = false
    end
end

local function CharacterMorph(morphType)
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if morphType == "Giant" then
        humanoid.BodyDepthScale.Value = 2
        humanoid.BodyHeightScale.Value = 2
        humanoid.BodyWidthScale.Value = 2
        humanoid.HeadScale.Value = 2
    elseif morphType == "Tiny" then
        humanoid.BodyDepthScale.Value = 0.5
        humanoid.BodyHeightScale.Value = 0.5
        humanoid.BodyWidthScale.Value = 0.5
        humanoid.HeadScale.Value = 0.5
    elseif morphType == "Fat" then
        humanoid.BodyDepthScale.Value = 2
        humanoid.BodyWidthScale.Value = 2
    elseif morphType == "Thin" then
        humanoid.BodyDepthScale.Value = 0.5
        humanoid.BodyWidthScale.Value = 0.5
    elseif morphType == "Headless" then
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = 1
            local face = head:FindFirstChild("face")
            if face then face:Destroy() end
        end
    end
end

local function ResetMorph()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    humanoid.BodyDepthScale.Value = 1
    humanoid.BodyHeightScale.Value = 1
    humanoid.BodyWidthScale.Value = 1
    humanoid.HeadScale.Value = 1

    local head = char:FindFirstChild("Head")
    if head then head.Transparency = 0 end
end

CreateUI()

local MainTab = AddTab("Main", "7733960981", 1)
local FarmTab = AddTab("Auto Farm", "7743878358", 2)
local VisualTab = AddTab("Visual", "7734053495", 3)
local MovementTab = AddTab("Movement", "7734053495", 4)
local CombatTab = AddTab("Combat", "7734053495", 5)
local EffectsTab = AddTab("Effects", "7734053495", 6)
local AnimTab = AddTab("Animations", "7734053495", 8)
local UtilityTab = AddTab("Utility", "7734053495", 9)

SwitchTab("Main")

CreateSection(MainTab, "Auto-Loaded Buttons")
CreateParagraph(MainTab, "Default Buttons", "Gold Bomb, Normal Bomb and Shoot/Throw enabled.")

CreateToggle(MainTab, "Show Gold Bomb", true, function(v) ToggleGoldBombBtn(v) end)
CreateToggle(MainTab, "Show Normal Bomb", true, function(v) ToggleNormalBombBtn(v) end)
CreateToggle(MainTab, "Show Shoot/Throw", true, function(v) ToggleShootBtn(v) end)

CreateSection(MainTab, "Optional Buttons")
CreateToggle(MainTab, "Load ESP Toggle", false, function(v) ToggleESPBtn(v) end)
CreateToggle(MainTab, "Load Flick", false, function(v) ToggleFlickBtn(v) end)
CreateToggle(MainTab, "Load Grab Gun", false, function(v) ToggleGrabGunBtn(v) end)
CreateToggle(MainTab, "Load Speed Glitch", false, function(v) ToggleSpeedBtn(v) end)
CreateToggle(MainTab, "Load Stretch", false, function(v) ToggleStretchBtn(v) end)

CreateButton(MainTab, "Stretch Resolution Slider", function()
    CreateSliderPopup("Stretch Resolution", 10, 100, math.round(Config.StretchRes * 100), 5, function(val)
        Config.StretchRes = val / 100
        if State.Stretch then SetStretch(true) end
    end, function()
        Config.StretchRes = 0.5
        if State.Stretch then SetStretch(true) end
    end)
end, "10% = very wide / 100% = normal")

CreateToggle(MainTab, "Load Fling Murderer", false, function(v) ToggleFlingMurdererBtn(v) end)
CreateToggle(MainTab, "Load Fling Sheriff", false, function(v) ToggleFlingSheriffBtn(v) end)
CreateToggle(MainTab, "Load Wall Hop", false, function(v) ToggleWallHopBtn(v) end)

CreateSection(MainTab, "Skybox")
CreateButton(MainTab, "Open Skybox Picker", function() OpenSkyboxPicker() end, "10+ presets")
CreateButton(MainTab, "Restore Default Sky", function() RestoreSky() end)

CreateSection(MainTab, "Crosshair")
CreateToggle(MainTab, "Enable Custom Crosshair", false, function(v)
    State.Crosshair = v
    if not v then
        local d = game.CoreGui:FindFirstChild("VexonCrosshairDisplay")
        if d then d:Destroy() CrosshairImg = nil end
        if CrosshairSpinConn then CrosshairSpinConn:Disconnect() CrosshairSpinConn = nil end
        if CrosshairRenderConn then CrosshairRenderConn:Disconnect() CrosshairRenderConn = nil end
        UserInputService.MouseIconEnabled = true
    else
        SetupCrosshair()
    end
end, "Visible only while ShiftLock is on")

CreateButton(MainTab, "Open Cursor Picker", function() OpenCursorPicker() end, "10+ cursors")

CreateSection(MainTab, "Graphics")
CreateToggle(MainTab, "Low Graphics (FPS Boost)", false, function(v)
    if v then EnableLowGfx() else DisableLowGfx() end
end)
CreateToggle(MainTab, "High Graphics (Beautiful)", false, function(v)
    if v then EnableHighGfx() else DisableHighGfx() end
end)

CreateButton(MainTab, "FOV Slider", function()
    CreateSliderPopup("Field of View", 30, 120, Config.FOV, 5, function(val)
        Config.FOV = val
        Camera.FieldOfView = val
    end, function()
        Config.FOV = 70
        Camera.FieldOfView = 70
    end)
end, "30-120 field of view")

CreateSection(MainTab, "Extra Scripts")
CreateButton(MainTab, "Load Emotes GUI", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    end)
end)
CreateButton(MainTab, "Load Infinite Yield", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
end)

CreateSection(MainTab, "Protection")
CreateToggle(MainTab, "Anti-Fling", false, function(v) SetAntiFling(v) end, "Limits velocity")
CreateToggle(MainTab, "Auto Ping Prediction", false, function(v) State.PingPred = v end, "Adds ping offset")

CreateButton(MainTab, "Speed Glitch Slider", function()
    CreateSliderPopup("Speed Glitch", 50, 600, Config.SpeedValue, 10, function(val)
        Config.SpeedValue = val
    end, function()
        Config.SpeedValue = 200
    end)
end)

CreateSection(FarmTab, "Smart Auto Farm")
CreateParagraph(FarmTab, "Role-Based Actions", "Innocent/Hero: Fling Murderer\nSheriff: Teleport and shoot\nMurderer: Kill All")

CreateToggle(FarmTab, "Auto Farm", false, function(v)
    State.AutoFarm = v
    State.Farming = v
    if v then
        FarmStats.StartTime = tick()
        FarmStats.Running = true
        FarmStats.Coins = 0
    else
        FarmStats.Running = false
    end
end)

CreateToggle(FarmTab, "Auto Reset (Full Bag)", false, function(v)
    State.AutoFarm = v
    State.Farming = v
end)

CreateToggle(FarmTab, "Auto Collect", false, function(v) State.AutoCollect = v end, "Auto collect coins")

CreateSection(FarmTab, "Statistics")
local coinPara = CreateParagraph(FarmTab, "Coins", "0")
local timePara = CreateParagraph(FarmTab, "Time", "0h 0m 0s")
local cphPara = CreateParagraph(FarmTab, "Coins/Hour", "0")

RunService.Heartbeat:Connect(function()
    if State.AutoFarm and FarmStats.Running then
        local elapsed = tick() - FarmStats.StartTime
        local h = math.floor(elapsed / 3600)
        local m = math.floor((elapsed % 3600) / 60)
        local s = math.floor(elapsed % 60)
        coinPara.SetContent("Coins: " .. FarmStats.Coins)
        timePara.SetContent(string.format("%dh %dm %ds", h, m, s))
        if elapsed > 0 then
            cphPara.SetContent("Coins/Hour: " .. math.floor(FarmStats.Coins / elapsed * 3600))
        end
    end
end)

CreateSection(VisualTab, "ESP Settings")
CreateToggle(VisualTab, "Enable ESP", false, function(v)
    State.ESP = v
    if not v then
        if ESPConn then ESPConn:Disconnect() ESPConn = nil end
        task.delay(0.1, ClearESP)
    else
        StartESP()
    end
end)

CreateToggle(VisualTab, "Dropped Gun ESP", true, function(v)
    State.GunESP = v
    if not v then ClearGunVisuals() end
end)

CreateToggle(VisualTab, "Traps ESP", false, function(v) State.TrapsESP = v end, "Show traps")
CreateToggle(VisualTab, "Coins ESP", false, function(v) State.CoinsESP = v end, "Show coins")

CreateSection(VisualTab, "Role Filters")
CreateToggle(VisualTab, "Show Murderer", true, function(v) ESPFilters.Murderer = v end)
CreateToggle(VisualTab, "Show Sheriff", true, function(v) ESPFilters.Sheriff = v end)
CreateToggle(VisualTab, "Show Hero", true, function(v) ESPFilters.Hero = v end)
CreateToggle(VisualTab, "Show Innocents", true, function(v) ESPFilters.Innocent = v end)
CreateToggle(VisualTab, "Show Self", true, function(v) ESPFilters.Self = v end)

CreateSection(MovementTab, "Movement")
CreateToggle(MovementTab, "Speed Walk", false, function(v)
    State.SpeedWalk = v
    UpdateWalkSpeed()
end)

CreateButton(MovementTab, "Walk Speed Slider", function()
    CreateSliderPopup("Walk Speed", 16, 500, Config.WalkSpeedValue, 5, function(val)
        Config.WalkSpeedValue = val
        if State.SpeedWalk then UpdateWalkSpeed() end
    end, function()
        Config.WalkSpeedValue = 16
        if State.SpeedWalk then UpdateWalkSpeed() end
    end)
end, "16 = normal / 500 = very fast")

CreateToggle(MovementTab, "Jump Power", false, function(v)
    State.JumpPower = v
    UpdateJumpPower()
end)

CreateButton(MovementTab, "Jump Power Slider", function()
    CreateSliderPopup("Jump Power", 50, 150, Config.JumpPowerValue, 5, function(val)
        Config.JumpPowerValue = val
        if State.JumpPower then UpdateJumpPower() end
    end, function()
        Config.JumpPowerValue = 50
        if State.JumpPower then UpdateJumpPower() end
    end)
end, "50 = normal / 150 = very high")

CreateSection(MovementTab, "Advanced Movement")
CreateToggle(MovementTab, "Speed Glitch", false, function(v) State.SpeedGlitch = v end)
CreateToggle(MovementTab, "Stretch Resolution", false, function(v)
    State.Stretch = v
    SetStretch(v)
end)
CreateToggle(MovementTab, "Infinite Jump", false, function(v) State.InfiniteJump = v end)
CreateToggle(MovementTab, "Fly", false, function(v) State.Fly = v end)
CreateToggle(MovementTab, "Noclip", false, function(v) State.Noclip = v end)
CreateToggle(MovementTab, "Bhop", false, function(v) State.Bhop = v end, "Auto bunny hop")
CreateToggle(MovementTab, "Auto Strafe", false, function(v) State.AutoStrafe = v end, "Auto strafe")

CreateSection(CombatTab, "Aimbot")
CreateToggle(CombatTab, "Murderer Aimbot", false, function(v) State.MurdererAimbot = v end, "Auto-aim at murderer")
CreateToggle(CombatTab, "Sheriff Aimbot", false, function(v) State.SheriffAimbot = v end, "Auto-aim at sheriff")
CreateToggle(CombatTab, "Silent Aim", false, function(v) State.SilentAim = v end, "Shoot without aiming")
CreateToggle(CombatTab, "Trigger Bot", false, function(v) State.TriggerBot = v end, "Auto shoot on target")
CreateToggle(CombatTab, "Rapid Fire", false, function(v) State.RapidFire = v end, "Shoot faster")

CreateSection(CombatTab, "Auto Combat")
CreateToggle(CombatTab, "Auto Shoot", false, function(v) State.AutoShoot = v end, "Auto shoot nearest")
CreateToggle(CombatTab, "Auto Throw", false, function(v) State.AutoThrow = v end, "Auto throw knife")
CreateToggle(CombatTab, "Auto Equip", false, function(v) State.AutoEquip = v end, "Auto equip weapon")
CreateToggle(CombatTab, "Hitbox Expander", false, function(v) State.HitboxExpander = v end, "Expand hitboxes")

CreateSection(CombatTab, "Protection")
CreateToggle(CombatTab, "God Mode", false, function(v) State.GodMode = v end, "Prevents death")
CreateToggle(CombatTab, "Auto Respawn", false, function(v) State.AutoRespawn = v end, "Auto respawn")
CreateToggle(CombatTab, "Bring Gun", false, function(v) State.BringGun = v end, "Bring gun to you")


CreateSection(EffectsTab, "Wings")
CreateToggle(EffectsTab, "Angel Wings", false, function(v) ToggleEffect("AngelWings", v) end)
CreateToggle(EffectsTab, "Demon Wings", false, function(v) ToggleEffect("DemonWings", v) end)
CreateToggle(EffectsTab, "Butterfly Wings", false, function(v) ToggleEffect("ButterflyWings", v) end)
CreateToggle(EffectsTab, "Dragon Wings", false, function(v) ToggleEffect("DragonWings", v) end)
CreateToggle(EffectsTab, "Fairy Wings", false, function(v) ToggleEffect("FairyWings", v) end)
CreateToggle(EffectsTab, "Bat Wings", false, function(v) ToggleEffect("BatWings", v) end)

CreateSection(EffectsTab, "Head Accessories")
CreateToggle(EffectsTab, "Halo", false, function(v) ToggleEffect("Halo", v) end)
CreateToggle(EffectsTab, "Demon Horns", false, function(v) ToggleEffect("DemonHorns", v) end)
CreateToggle(EffectsTab, "Crown", false, function(v) ToggleEffect("Crown", v) end)
CreateToggle(EffectsTab, "Hat", false, function(v) ToggleEffect("Hat", v) end)
CreateToggle(EffectsTab, "Mask", false, function(v) ToggleEffect("Mask", v) end)
CreateToggle(EffectsTab, "Glasses", false, function(v) ToggleEffect("Glasses", v) end)

CreateSection(EffectsTab, "Auras")
CreateToggle(EffectsTab, "Aura", false, function(v) ToggleEffect("Aura", v) end)
CreateToggle(EffectsTab, "Fire Aura", false, function(v) ToggleEffect("FireAura", v) end)
CreateToggle(EffectsTab, "Ice Aura", false, function(v) ToggleEffect("IceAura", v) end)
CreateToggle(EffectsTab, "Lightning Aura", false, function(v) ToggleEffect("LightningAura", v) end)
CreateToggle(EffectsTab, "Poison Aura", false, function(v) ToggleEffect("PoisonAura", v) end)
CreateToggle(EffectsTab, "Shadow Aura", false, function(v) ToggleEffect("ShadowAura", v) end)
CreateToggle(EffectsTab, "Rainbow Aura", false, function(v) ToggleEffect("RainbowAura", v) end)

CreateSection(EffectsTab, "Sparkles")
CreateToggle(EffectsTab, "Sparkles", false, function(v) ToggleEffect("Sparkles", v) end)
CreateToggle(EffectsTab, "Fire Sparkles", false, function(v) ToggleEffect("FireSparkles", v) end)
CreateToggle(EffectsTab, "Ice Sparkles", false, function(v) ToggleEffect("IceSparkles", v) end)
CreateToggle(EffectsTab, "Galaxy Sparkles", false, function(v) ToggleEffect("GalaxySparkles", v) end)
CreateToggle(EffectsTab, "Hearts", false, function(v) ToggleEffect("Hearts", v) end)
CreateToggle(EffectsTab, "Stars", false, function(v) ToggleEffect("Stars", v) end)
CreateToggle(EffectsTab, "Music Notes", false, function(v) ToggleEffect("MusicNotes", v) end)
CreateToggle(EffectsTab, "Skulls", false, function(v) ToggleEffect("Skulls", v) end)

CreateSection(EffectsTab, "Trails")
CreateToggle(EffectsTab, "Trail", false, function(v) ToggleEffect("Trail", v) end)
CreateToggle(EffectsTab, "Fire Trail", false, function(v) ToggleEffect("FireTrail", v) end)
CreateToggle(EffectsTab, "Ice Trail", false, function(v) ToggleEffect("IceTrail", v) end)
CreateToggle(EffectsTab, "Rainbow Trail", false, function(v) ToggleEffect("RainbowTrail", v) end)
CreateToggle(EffectsTab, "Lightning Trail", false, function(v) ToggleEffect("LightningTrail", v) end)
CreateToggle(EffectsTab, "Ghost Trail", false, function(v) ToggleEffect("GhostTrail", v) end)

CreateSection(EffectsTab, "Footsteps")
CreateToggle(EffectsTab, "Footsteps", false, function(v) ToggleEffect("Footsteps", v) end)
CreateToggle(EffectsTab, "Fire Footsteps", false, function(v) ToggleEffect("FireFootsteps", v) end)
CreateToggle(EffectsTab, "Ice Footsteps", false, function(v) ToggleEffect("IceFootsteps", v) end)

CreateSection(EffectsTab, "Character Morph")
CreateToggle(EffectsTab, "Giant", false, function(v) if v then CharacterMorph("Giant") else ResetMorph() end end)
CreateToggle(EffectsTab, "Tiny", false, function(v) if v then CharacterMorph("Tiny") else ResetMorph() end end)
CreateToggle(EffectsTab, "Fat", false, function(v) if v then CharacterMorph("Fat") else ResetMorph() end end)
CreateToggle(EffectsTab, "Thin", false, function(v) if v then CharacterMorph("Thin") else ResetMorph() end end)
CreateToggle(EffectsTab, "Headless", false, function(v) if v then CharacterMorph("Headless") else ResetMorph() end end)

CreateSection(EffectsTab, "Actions")
CreateButton(EffectsTab, "Clear All Effects", function()
    ClearAllEffects()
    ResetMorph()
end, "Remove all effects and morphs")


CreateSection(AnimTab, "Animation Changer")
CreateToggle(AnimTab, "Zombie", false, function(v) ChangeAnimation("Zombie", v) end)
CreateToggle(AnimTab, "Ninja", false, function(v) ChangeAnimation("Ninja", v) end)
CreateToggle(AnimTab, "Robot", false, function(v) ChangeAnimation("Robot", v) end)
CreateToggle(AnimTab, "Old", false, function(v) ChangeAnimation("Old", v) end)
CreateToggle(AnimTab, "Stylish", false, function(v) ChangeAnimation("Stylish", v) end)
CreateToggle(AnimTab, "Superhero", false, function(v) ChangeAnimation("Superhero", v) end)
CreateToggle(AnimTab, "Villain", false, function(v) ChangeAnimation("Villain", v) end)
CreateToggle(AnimTab, "Astronaut", false, function(v) ChangeAnimation("Astronaut", v) end)
CreateToggle(AnimTab, "Cowboy", false, function(v) ChangeAnimation("Cowboy", v) end)
CreateToggle(AnimTab, "Knight", false, function(v) ChangeAnimation("Knight", v) end)
CreateToggle(AnimTab, "Mage", false, function(v) ChangeAnimation("Mage", v) end)
CreateToggle(AnimTab, "Pirate", false, function(v) ChangeAnimation("Pirate", v) end)
CreateToggle(AnimTab, "Samurai", false, function(v) ChangeAnimation("Samurai", v) end)
CreateToggle(AnimTab, "Spartan", false, function(v) ChangeAnimation("Spartan", v) end)
CreateToggle(AnimTab, "Werewolf", false, function(v) ChangeAnimation("Werewolf", v) end)
CreateToggle(AnimTab, "Skeleton", false, function(v) ChangeAnimation("Skeleton", v) end)
CreateToggle(AnimTab, "Ghost", false, function(v) ChangeAnimation("Ghost", v) end)
CreateToggle(AnimTab, "Vampire", false, function(v) ChangeAnimation("Vampire", v) end)
CreateToggle(AnimTab, "Witch", false, function(v) ChangeAnimation("Witch", v) end)
CreateToggle(AnimTab, "Wizard", false, function(v) ChangeAnimation("Wizard", v) end)

CreateSection(AnimTab, "Skin Changer")
CreateToggle(AnimTab, "Noob", false, function(v) ChangeSkin("Noob", v) end)
CreateToggle(AnimTab, "Guest", false, function(v) ChangeSkin("Guest", v) end)
CreateToggle(AnimTab, "Bacon", false, function(v) ChangeSkin("Bacon", v) end)
CreateToggle(AnimTab, "Acorn", false, function(v) ChangeSkin("Acorn", v) end)
CreateToggle(AnimTab, "Skeleton Skin", false, function(v) ChangeSkin("Skeleton", v) end)
CreateToggle(AnimTab, "Zombie Skin", false, function(v) ChangeSkin("Zombie", v) end)
CreateToggle(AnimTab, "Vampire Skin", false, function(v) ChangeSkin("Vampire", v) end)
CreateToggle(AnimTab, "Werewolf Skin", false, function(v) ChangeSkin("Werewolf", v) end)
CreateToggle(AnimTab, "Robot Skin", false, function(v) ChangeSkin("Robot", v) end)
CreateToggle(AnimTab, "Cyborg Skin", false, function(v) ChangeSkin("Cyborg", v) end)
CreateToggle(AnimTab, "Alien Skin", false, function(v) ChangeSkin("Alien", v) end)
CreateToggle(AnimTab, "Ghost Skin", false, function(v) ChangeSkin("Ghost", v) end)
CreateToggle(AnimTab, "Demon Skin", false, function(v) ChangeSkin("Demon", v) end)
CreateToggle(AnimTab, "Angel Skin", false, function(v) ChangeSkin("Angel", v) end)
CreateToggle(AnimTab, "Ninja Skin", false, function(v) ChangeSkin("Ninja", v) end)
CreateToggle(AnimTab, "Samurai Skin", false, function(v) ChangeSkin("Samurai", v) end)
CreateToggle(AnimTab, "Knight Skin", false, function(v) ChangeSkin("Knight", v) end)
CreateToggle(AnimTab, "Wizard Skin", false, function(v) ChangeSkin("Wizard", v) end)
CreateToggle(AnimTab, "Witch Skin", false, function(v) ChangeSkin("Witch", v) end)

CreateSection(AnimTab, "Actions")
CreateButton(AnimTab, "Reset Animations", function()
    ResetAnimations()
end, "Reset all animations")
CreateButton(AnimTab, "Reset Skin", function()
    ResetSkin()
end, "Reset skin to default")

CreateSection(UtilityTab, "Performance")
CreateToggle(UtilityTab, "Performance Overlay", false, function(v)
    State.Performance = v
    if v then
        CreatePerformanceOverlay()
    elseif PerformanceOverlay then
        PerformanceOverlay.destroy()
    end
end, "Shows FPS and Ping")

CreateToggle(UtilityTab, "Anti-AFK", false, function(v)
    State.AntiAFK = v
    SetupAntiAFK()
end, "Prevents AFK kick")

CreateToggle(UtilityTab, "Full Bright", false, function(v) State.FullBright = v end, "Maximum brightness")
CreateToggle(UtilityTab, "No Fog", false, function(v) State.NoFog = v end, "Remove fog")
CreateToggle(UtilityTab, "Third Person", false, function(v) State.ThirdPerson = v end, "Force third person")

CreateSection(UtilityTab, "Audio")
CreateToggle(UtilityTab, "Hit Sound", false, function(v) State.HitSound = v end, "Play sound on hit")
CreateToggle(UtilityTab, "Kill Sound", false, function(v) State.KillSound = v end, "Play sound on kill")

CreateSection(UtilityTab, "Misc")
CreateToggle(UtilityTab, "Stream Mode", false, function(v) State.StreamMode = v end, "Hide UI")
CreateToggle(UtilityTab, "Fake Lag", false, function(v) State.FakeLag = v end, "Simulate lag")

CreateSection(UtilityTab, "Server")
CreateButton(UtilityTab, "Join Another Server", function()
    JoinAnotherServer()
end, "Teleport to different server")
CreateButton(UtilityTab, "Rejoin Server", function()
    RejoinServer()
end, "Rejoin current server")

local OpenBtnSize = IsMobile and 44 or 50
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, OpenBtnSize, 0, OpenBtnSize)
OpenBtn.Position = UDim2.new(0, 12, 0.5, -OpenBtnSize/2)
OpenBtn.BackgroundColor3 = COLORS.Primary
OpenBtn.Text = "V"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextSize = IsMobile and 18 or 20
OpenBtn.BorderSizePixel = 0
OpenBtn.Parent = BtnSG

New("UICorner", OpenBtn, {CornerRadius = UDim.new(1, 0)})
New("UIStroke", OpenBtn, {Color = COLORS.Primary, Thickness = 2, Transparency = 0.3})
Gradient(OpenBtn, COLORS.Primary, COLORS.PrimaryLight, 45)

AddPulse(OpenBtn, 0.95, 1.05, 1.2)
MakeDraggable(OpenBtn)

OpenBtn.MouseButton1Click:Connect(function()
    ClickSound()
    UIToggle()
end)

task.wait(0.4)
ToggleGoldBombBtn(true)
ToggleNormalBombBtn(true)
ToggleShootBtn(true)

Notify("Vexon Hub", "v12.0 loaded!", "success")

print("[Vexon] v12.0 loaded!")
