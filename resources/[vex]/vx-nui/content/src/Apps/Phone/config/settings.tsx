import { SettingsIcon } from "@chakra-ui/icons";
import { MdWallpaper } from "react-icons/md";
import { VscBellDot } from "react-icons/vsc";

export const SettingsData: { [k: string]: SettingCategory } = {
  general: {
    id: 1,
    name: "general",
    pages: {
      general: {
        id: 1,
        Icon: () => SettingsIcon,
        color: "#525252",
        name: "general",
        options: {
          hide_home_button: {
            key: "hide_home_button",
            value: false,
          },
        },
      },
      notifications: {
        id: 2,
        Icon: () => VscBellDot,
        color: "#ef4444",
        name: "notifications",
        options: {
          disable_calls: {
            key: "disable_calls",
            value: false,
          },
          disable_messages: {
            key: "disable_messages",
            value: false,
          },
        },
      },
      wallpaper: {
        id: 3,
        Icon: () => MdWallpaper,
        color: "#eab308",
        name: "wallpaper",
        options: {
          wallpaper_link: {
            key: "wallpaper_link",
            value:
              "https://wallpapersflix.com/wp-content/uploads/2021/11/iPhone-13-Wallpapers-485x1024.png",
          },
        },
      },
    },
  },
};

export const GetKvPOptions = () => {
  let entries: any = {};
  Object.values(SettingsData).map((s) => {
    Object.values(s.pages).map((p) => {
      Object.values(p.options).map((o) => {
        entries = {
          ...entries,
          [o.key]: o.value,
        };
      });
    });
  });
  return entries;
};
