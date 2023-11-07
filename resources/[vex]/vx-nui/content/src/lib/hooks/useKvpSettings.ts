import * as React from "react";
import EventBus from "../events";

export const useKvpSettings = <T>(
  settingId: string
): { settings: T; updateSettings: (data: any) => void } => {
  const localStorage = window.localStorage;

  // Get settings and create or parse
  const settingsString = localStorage.getItem("settings");
  let settingsDecoded: any;
  if (!settingsString) {
    localStorage.setItem("settings", JSON.stringify({}));
    settingsDecoded = {};
  } else {
    settingsDecoded = JSON.parse(settingsString);
  }

  const [settings, setSettings] = React.useState<any>(settingsDecoded[settingId]);

  React.useEffect(() => {
    const settingIdData: T = settingsDecoded[settingId];
    if (!Boolean(settingIdData)) {
      setSettings({});
    } else {
      setSettings(settingIdData);
    }
  }, []);

  const updateSettings = (data: any) => {
    delete settingsDecoded[settingId];
    const newSettings = {
      ...settingsDecoded,
      [settingId]: { ...data },
    };

    localStorage.setItem("settings", JSON.stringify(newSettings));
    setSettings({ ...settings, ...data });
    EventBus.getInstance().dispatch(`${settingId}:settings`, {
      ...settings,
      ...data,
    });
  };

  return { settings, updateSettings };
};
