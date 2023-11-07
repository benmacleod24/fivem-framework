import { RootState } from ".";
import { RootActions } from "./actions";

const RootReducer = (state: RootState, action: RootActions): RootState => {
  switch (action.type) {
    case "SET_APPLICATION":
      return {
        ...state,
        application: action.payload.name,
      };
    case "SET_CHARACTER":
      return {
        ...state,
        isAppReady: true,
        character: { ...action.payload },
      };
    case "RESET_NUI":
      return {
        ...state,
        isAppReady: false,
        application: "",
        netId: 0,
        character: {
          characterId: 0,
          dateOfBirth: "NULL_DOB",
          firstName: "NULL",
          lastName: "NULL",
          characterOwner: 0,
          netId: 0,
        },
      };
    default:
      return state;
  }
};

export default RootReducer;
