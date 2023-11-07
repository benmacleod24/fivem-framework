-- Returns string (without WHERE key)
-- Operator is AND,OR,etc...(default = AND)
function TableToWhereClause(tbl, operator)
    vTable = {}

    -- Return empty string
    if (not tbl) then
        return ""
    end

    for k,v in pairs(tbl) do
        table.insert(vTable, tostring(k).."="..json.encode(v))
    end

    -- Build Where clause string
    return table.concat(vTable, (operator and " "..operator:upper().." ") or " AND ")
end