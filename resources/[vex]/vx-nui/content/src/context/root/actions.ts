export type RootActions = SetApplication | SetCharacter | Reset;

export interface SetApplication {
  type: "SET_APPLICATION";
  payload: {
    name: string;
  };
}

export interface SetCharacter {
  type: "SET_CHARACTER";
  payload: Character;
}

export interface Reset {
  type: "RESET_NUI";
}
