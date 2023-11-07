import { Flex, Text } from "@chakra-ui/react";
import { AnimatePresence } from "framer-motion";
import * as React from "react";
import TransitionBase from "../../../components/Transitions/TransitionBase";
import { useMessage } from "../../../lib/hooks/useMessage";

interface NotificationProps {
  placement: any;
  notification: NotificationType;
  removeNotification: (id: number) => void;
}

const Notification: React.FunctionComponent<NotificationProps> = ({
  placement,
  notification: n,
  removeNotification,
}) => {
  const [notify, setNotify] = React.useState<NotificationType>(n);
  const [visible, setVisible] = React.useState<boolean>(false);

  React.useEffect(() => {
    // Always wanna set true, for animation to run properly
    setVisible(true);

    // Set the timer to timeout the notification
    // Also double check all required params are there
    if (!notify.isStatic && notify.timeout) {
      setTimeout(() => setVisible(false), notify.timeout * 1000);
    }
  }, []);

  // Listener is used for static notfications
  // Removes them on client-side callback
  useMessage(`notification:remove:${notify.id}`, () => {
    setVisible(false);
  });

  // Listener to update a notification
  // Updates them on client-side callback
  useMessage(`notification:update:${notify.id}`, (notify: NotificationType) => {
    setNotify(notify);
  });

  return (
    <AnimatePresence
      initial={false}
      exitBeforeEnter
      onExitComplete={() => removeNotification(notify.id)}
    >
      {visible && (
        <TransitionBase
          py='2'
          alignItems={"center"}
          justifyContent='flex-start'
          maxW='56'
          px='3'
          bg={notify.color}
          rounded='md'
          fontWeight={"semibold"}
          outline='inset 1px 1px white'
          borderStyle='solid'
          borderWidth='1px'
          boxShadow='0px 5px 10px rgba(0, 0, 0, 0.2)'
          borderColor='whiteAlpha.400'
          variants={placement}
          initial='hidden'
          exit='exit'
          animate='visible'
        >
          <Text noOfLines={3}>{notify.label}</Text>
        </TransitionBase>
      )}
    </AnimatePresence>
  );
};

export default Notification;
