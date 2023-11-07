import { PhoneState } from ".";
import { PhoneActions } from "./actions";

const PhoneReducer = (state: PhoneState, action: PhoneActions): PhoneState => {
  switch (action.type) {
    case "SET_APPLICATION":
      return {
        ...state,
        application: action.payload.appId,
      };
    case "SET_SETTINGS":
      return {
        ...state,
        settings: { ...action.payload.settings },
      };
    case "UPDATE_SETTING":
      return {
        ...state,
        settings: {
          ...state.settings,
          [action.payload.setting.key]: action.payload.setting.value,
        },
      };
    default:
      return state;
  }
};

export default PhoneReducer;
