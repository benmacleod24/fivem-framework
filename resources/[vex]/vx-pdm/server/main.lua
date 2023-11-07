SHOWROOM = {
    [1] = 'adder',
    [2] = 'evo9',
    [3] = 'skyline'
}

RPC.Register('vx-pdm:showroom:vehicles', function()
    return SHOWROOM
end)