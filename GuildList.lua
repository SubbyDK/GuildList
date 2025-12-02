-- GuildList Addon
-- Automatically saves guild roster as CSV after login
-- Sorted by rank index (highest rank first), then alphabetically by name
-- Officer note is included only for "Alt" ranks if visible
-- Manual update available via /guildlist

GuildListDB = GuildListDB or {}

local LogInTime = GetTime()
local Stop = false
GuildRoster() -- request roster update
local f = CreateFrame("Frame")

-- ====================================================================================================
-- Local function to build and save CSV string
-- ====================================================================================================
local function GuildList_Update()
    local numMembers = GetNumGuildMembers()
    local members = {}

    for i = 1, numMembers do
        local name, rank, rankIndex, level, class, _, _, officernote = GetGuildRosterInfo(i)

        -- Base line: Name,Rank,Class
        local line = name .. "," .. rank .. "," .. class .. "," .. level

        -- Add officer note only for "Alt" ranks if visible
        if (string.find(rank, "Alt")) and (officernote) and (officernote ~= "") then
            line = line .. "," .. officernote
        end

        table.insert(members, {name = name, rankIndex = rankIndex or 99, line = line})
    end

    -- Sort by rank index (lower = higher rank), then alphabetically by name
    table.sort(members, function(a, b)
        if (a.rankIndex == b.rankIndex) then
            return a.name < b.name
        else
            return a.rankIndex < b.rankIndex
        end
    end)

    -- Concatenate lines with "-" separator
    local csv = {}
    for _, m in ipairs(members) do
        table.insert(csv, m.line)
    end
    GuildListDB.membersCSV = table.concat(csv, "-")
end

-- ====================================================================================================
-- Delay execution until roster data is available
-- ====================================================================================================
f:SetScript("OnUpdate", function()
    if ((LogInTime + 30) < GetTime()) and (Stop == false) then
        GuildList_Update()
        Stop = true
    end
end)

-- ====================================================================================================
-- Manual slash command (/guildlist)
-- ====================================================================================================
SLASH_GUILDLIST1 = "/guildlist"
SlashCmdList["GUILDLIST"] = function()
    GuildRoster()
    GuildList_Update()
end
