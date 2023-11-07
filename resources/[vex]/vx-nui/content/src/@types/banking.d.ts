type AccountTypes = "checking" | "savings" | "business" | "state";

interface Account {
  id: string;
  bank_id: number;
  type: AccountTypes;
  owner: Character["characterId"];
  amount: number;
  name: string;
}
