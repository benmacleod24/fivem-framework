export const LeftInventory: Inventory = {
  data: {
    created_by: 1,
    data: {},
    id: "char:1",
    max_weight: 400,
    slots: 40,
    type: "player",
    owner: 1,
    created: 10,
  },
  stacks: {
    1: {
      amount: 5,
      config: {
        name: "sword",
        id: "sword",
        max: 10,
        event: "",
        price: 1000,
        weight: 25,
        aliases: [],
        description: "To chop off someone's dick ;).",
      },
      items: [
        {
          id: "uuid",
          created: new Date(),
          data: {},
          inventory_id: "char:1",
          item: "sword",
          slot: 1,
          weight: 25,
          durability: 83,
        },
      ],
      weight: 25,
    },
  },
};
