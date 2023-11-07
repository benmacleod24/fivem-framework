import { PhoneState } from ".";

export type PhoneActions = SetApplication | SetSettings | UpdateSetting;

export interface SetApplication {
  type: "SET_APPLICATION";
  payload: {
    appId: PhoneState["application"];
  };
}

export interface SetSettings {
  type: "SET_SETTINGS";
  payload: {
    settings: { [k: string]: any };
  };
}

export interface UpdateSetting {
  type: "UPDATE_SETTING";
  payload: {
    setting: {
      key: string;
      value: any;
    };
  };
}
