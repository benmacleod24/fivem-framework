export type ClothingComponentType = "clothing" | "prop" | "overlay";
export interface ClothingComponent {
  id: number;
  name: string;
  componentId: number;
  type: ClothingComponentType;
}

export const Clothes: ClothingComponent[] = [
  {
    id: 1,
    name: "Hair",
    componentId: 2,
    type: "clothing",
  },
  {
    id: 2,
    name: "Undershirt",
    componentId: 8,
    type: "clothing",
  },
  {
    id: 3,
    name: "Shirts & Jackets",
    componentId: 11,
    type: "clothing",
  },
  {
    id: 4,
    name: "Hands & Arms",
    componentId: 3,
    type: "clothing",
  },
  {
    id: 5,
    name: "Armour",
    componentId: 9,
    type: "clothing",
  },
  {
    id: 6,
    name: "Pants",
    componentId: 4,
    type: "clothing",
  },
  {
    id: 7,
    name: "Shoes",
    componentId: 6,
    type: "clothing",
  },
  {
    id: 8,
    name: "Masks",
    componentId: 1,
    type: "clothing",
  },
  {
    id: 9,
    name: "Bags & Parachutes",
    componentId: 5,
    type: "clothing",
  },
  {
    id: 10,
    name: "Necklaces & Ties",
    componentId: 7,
    type: "clothing",
  },
  {
    id: 11,
    name: "Clothing Patches",
    componentId: 10,
    type: "clothing",
  },
  {
    id: 12,
    name: "Ped Face",
    componentId: 0,
    type: "clothing",
  },
];
