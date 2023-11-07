// NEW STUFF
type InventoryTypes = "store" | "player" | "verhicle";

interface Inventory {
  data: InventoryData;
  stacks: { [slot: number]: InventoryStack };
}

interface InventoryData {
  id: string;
  owner?: number;
  slots: number;
  type: InventoryTypes;
  max_weight: number;
  created: number;
  created_by: number;
  data: any;
}

interface StackConfig {
  id: string;
  name: string;
  weight: number;
  max: number;
  price: number;
  event: string;
  description?: string;
  aliases: string[];
}

interface InventoryStack {
  config: StackConfig;
  items: InventoryItem[];
  amount: number;
  weight: number;
}

interface InventoryItem {
  id: string;
  item: string;
  inventory_id: string;
  durability: number;
  slot: number;
  weight: number;
  created: Date;
  data: any;
}
