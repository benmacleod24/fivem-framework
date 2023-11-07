import { Button, Flex, Input, InputGroup, InputLeftElement } from "@chakra-ui/react";
import * as React from "react";
import { MdWallpaper } from "react-icons/md";
import { usePhoneContext } from "../../../../../context/phone";
import { useKvpSettings } from "../../../../../lib/hooks/useKvpSettings";

interface WallpaperSettingProps {}

const WallpaperSetting: React.FunctionComponent<WallpaperSettingProps> = ({}) => {
  const { state, dispatch } = usePhoneContext();
  const [link, setLink] = React.useState<string>(state.settings.wallpaper_link);
  const { settings, updateSettings } = useKvpSettings<any>("phoneSettings");

  return (
    <Flex w='full' h='full' flexDir={"column"} alignItems={"center"}>
      <Flex
        mt='4'
        w='165px'
        h='317px'
        bg='red'
        background='linear-gradient(35deg, #d32f2f 10%, #e91e63 35%, #2196f3)'
        backgroundImage={`url(${link})`}
        borderRadius='md'
        backgroundPosition='center center'
        backgroundSize='cover'
        backgroundRepeat='no-repeat'
      />
      <Flex mt='4' flexDir={"column"}>
        <InputGroup variant={"filled"}>
          <InputLeftElement children={<MdWallpaper />} />
          <Input
            _focus={{ outline: "none" }}
            value={link}
            onChange={(e) => setLink(e.target.value)}
          />
        </InputGroup>
        <Button
          onClick={async () => {
            dispatch({
              type: "UPDATE_SETTING",
              payload: {
                setting: {
                  key: "wallpaper_link",
                  value: link,
                },
              },
            });
            updateSettings({
              ...state.settings,
              wallpaper_link: link,
            });
          }}
          mt='3'
          colorScheme={"green"}
          variant='ghost'
        >
          Save
        </Button>
      </Flex>
    </Flex>
  );
};

export default WallpaperSetting;
