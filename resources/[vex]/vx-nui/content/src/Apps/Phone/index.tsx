import isEmpty from "is-empty";
import * as React from "react";
import { usePhoneContext } from "../../context/phone";
import { useKvpSettings } from "../../lib/hooks/useKvpSettings";
import Contacts from "./Apps/Contacts";
import HomeScreen from "./Apps/HomeScreen";
import Settings from "./Apps/Settings";
import Workforce from "./Apps/Workforce";
import Frame from "./components/Frame";
import PhoneSlide from "./components/Frame/PhoneSlide";
import Apps from "./config/apps";
import { GetKvPOptions } from "./config/settings";

interface PhoneProps {}

const Phone: React.FunctionComponent<PhoneProps> = ({}) => {
  const { state, dispatch } = usePhoneContext();
  const [loadingPhone, setLoadingPhone] = React.useState(false);
  const { settings, updateSettings } = useKvpSettings<any>("phoneSettings");

  React.useEffect(() => {
    setLoadingPhone(true);

    if (isEmpty(settings)) {
      updateSettings(GetKvPOptions());
    }

    dispatch({
      type: "SET_SETTINGS",
      payload: {
        settings,
      },
    });

    setLoadingPhone(false);
  }, [settings]);

  return (
    <PhoneSlide>
      <Frame>
        <HomeScreen />
        <Contacts />
        <Settings />
        <Workforce />
      </Frame>
    </PhoneSlide>
  );
};

export default Phone;
