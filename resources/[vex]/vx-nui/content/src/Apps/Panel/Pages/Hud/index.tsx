import {
  Button,
  Flex,
  Icon,
  Input,
  InputGroup,
  InputLeftElement,
  propNames,
  Select,
} from "@chakra-ui/react";
import { Form, Formik } from "formik";
import * as React from "react";
import { statuses } from "../../../../lib/configs/statuses";
import { useKvpSettings } from "../../../../lib/hooks/useKvpSettings";
import { Placements } from "../../../Notifications/placement";

interface HudSettingsProps {}

const HudSettings: React.FunctionComponent<HudSettingsProps> = ({}) => {
  const { updateSettings, settings } = useKvpSettings<any>("notifications");
  const { updateSettings: updateHud, settings: hud_settings } =
    useKvpSettings<any>("hud-status");
  const [value, setValue] = React.useState(settings.placement);
  const [armor, setArmor] = React.useState(hud_settings.armor);

  return (
    <Flex flexGrow={1} h='full' p='4' flexDir={"column"}>
      <Formik
        initialValues={{
          notify_placement: settings.placement,
          status_values: {
            armor: hud_settings.armor,
            hunger: hud_settings.hunger,
            health: hud_settings.health,
            thirst: hud_settings.thirst,
          },
        }}
        onSubmit={(values) => {
          updateSettings({ placement: values.notify_placement });
          updateHud({ ...values.status_values });
        }}
      >
        {(props) => (
          <Flex as={Form} flexDir='column'>
            <Select
              variant={"filled"}
              _focus={{ outline: "none" }}
              onChange={(e) =>
                props.setFieldValue("notify_placement", e.target.value)
              }
              value={props.values.notify_placement}
            >
              {Object.keys(Placements).map((k) => (
                <option value={k}>{k}</option>
              ))}
            </Select>
            <Flex gap={3} my='3'>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<Icon as={statuses["health"].icon} />} />
                <Input
                  placeholder='Health Value'
                  value={props.values.status_values.health}
                  _focus={{ outline: "none" }}
                  onChange={(e) =>
                    props.setFieldValue("status_values", {
                      ...props.values.status_values,
                      health: e.target.value,
                    })
                  }
                />
              </InputGroup>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<Icon as={statuses["armor"].icon} />} />
                <Input
                  placeholder='Armor Value'
                  value={props.values.status_values.armor}
                  _focus={{ outline: "none" }}
                  onChange={(e) =>
                    props.setFieldValue("status_values", {
                      ...props.values.status_values,
                      armor: e.target.value,
                    })
                  }
                />
              </InputGroup>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<Icon as={statuses["hunger"].icon} />} />
                <Input
                  placeholder='Hunger Value'
                  value={props.values.status_values.hunger}
                  _focus={{ outline: "none" }}
                  onChange={(e) =>
                    props.setFieldValue("status_values", {
                      ...props.values.status_values,
                      hunger: e.target.value,
                    })
                  }
                />
              </InputGroup>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<Icon as={statuses["thirst"].icon} />} />
                <Input
                  placeholder='Thirst Value'
                  value={props.values.status_values.thirst}
                  _focus={{ outline: "none" }}
                  onChange={(e) =>
                    props.setFieldValue("status_values", {
                      ...props.values.status_values,
                      thirst: e.target.value,
                    })
                  }
                />
              </InputGroup>
            </Flex>
            <Button colorScheme={"blue"} type='submit'>
              Save Settings
            </Button>
          </Flex>
        )}
      </Formik>
    </Flex>
  );
};

export default HudSettings;
