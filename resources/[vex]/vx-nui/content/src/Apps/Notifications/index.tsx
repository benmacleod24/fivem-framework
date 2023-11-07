import { Flex } from "@chakra-ui/react";
import isEmpty from "is-empty";
import * as React from "react";
import EventBus from "../../lib/events";
import { useKvpSettings } from "../../lib/hooks/useKvpSettings";
import { useMessage } from "../../lib/hooks/useMessage";
import Notification from "./components/Notification";
import { Placements } from "./placement";

interface NotificationsProps {}

const Notifications: React.FunctionComponent<NotificationsProps> = ({}) => {
  const [notifications, setNotifications] = React.useState<NotificationType[]>([]);

  // Used for KVP Settings
  // State is used for on the fly setting changes
  const [placement, setPlacement] = React.useState<string>("left-center");
  const { settings, updateSettings } = useKvpSettings<{ placement: string }>(
    "notifications"
  );

  // Processes settings, sets or creates them
  React.useEffect(() => {
    if (isEmpty(settings)) {
      setPlacement("left-center");
      updateSettings({ placement: "left-center" });
    } else {
      setPlacement(settings.placement);
    }
  }, []);

  // Listens for setting changes
  React.useEffect(() => {
    const { unregister } = EventBus.getInstance().register(
      "notifications:settings",
      (data: any) => {
        setPlacement(data.placement);
      }
    );

    return () => unregister();
  }, []);

  // Listens for adding notifications
  // Called from client-side
  useMessage(
    "notifications:add",
    (data: NotificationType) => {
      setNotifications([...notifications, { ...data, isActive: true }]);
    },
    [notifications]
  );

  // Remove notification from the stack
  const removeNotification = (id: number) => {
    setNotifications(notifications.filter((n) => n.id !== id));
  };

  const placementCss =
    Placements[placement] && Placements[placement].css
      ? Placements[placement].css
      : {};

  return (
    <Flex pos='absolute' justify={"center"} align='center' {...placementCss}>
      {notifications.map((n, i) => (
        <Notification
          placement={
            Placements[placement] && Placements[placement].transition
              ? Placements[placement].transition
              : {}
          }
          removeNotification={removeNotification}
          key={i}
          notification={n}
        />
      ))}
    </Flex>
  );
};

export default Notifications;
