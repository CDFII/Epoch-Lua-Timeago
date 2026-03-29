local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EpochConverter = require(ReplicatedStorage.EpochConverter)

local EpochString = EpochConverter.GetTimeAgo(1234567890)
-- At 26.3.2026 16:10
-- EpochString = "17 years ago"

local EpochStringAtCustomDate = EpochConverter.GetTimeAgo(
  1234567890, os.time() - 31536000 -- 31536000 seconds = 1 year
)
-- At 26.3.2026 16:10
-- EpochStringAtCustomDate = "16 yeas ago"
