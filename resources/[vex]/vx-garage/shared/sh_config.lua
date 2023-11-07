CONFIG = {}

CONFIG.shared_options = {
    {
        id = 1,
        title = 'Personal Vehicles',
        description = 'Your personal shitty cars.',
        data = {
            event = 'garage:open:shared:personal'
        }
    },
    {
        id = 2,
        title = 'Shared Vehicles',
        description = 'Can you not afford your own?',
        data = {
            event = 'garage:open:shared'
        }
    },
}

CONFIG.shared_garage = {
    id = 1,
    title = '< Go Back',
    data = {
        event = 'garage:open'
    }
}



CONFIG.shared_personal_garage = {
    {
        id = 1,
        title = '< Go Back',
        data = {
            event = 'vx-garage:open'
        }
    },
}

CONFIG.personal_garage = {
    {
        id = 1,
        title = 'Vehicle Garage',
    },
}