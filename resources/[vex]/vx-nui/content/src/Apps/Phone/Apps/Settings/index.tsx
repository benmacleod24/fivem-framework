import { ArrowRightIcon, ChevronRightIcon, SettingsIcon } from "@chakra-ui/icons";
import { Flex, Heading, Icon, IconButton, Text } from "@chakra-ui/react";
import * as React from "react";
import { BsChevronRight } from "react-icons/bs";
import { MdWallpaper } from "react-icons/md";
import AppWrapper from "../../components/App";
import SidePage from "../../components/App/SidePage";
import { SettingsData } from "../../config/settings";
import General from "./Pages/General";
import WallpaperSetting from "./Pages/Wallpaper";

interface SettingsProps {}

const Settings: React.FunctionComponent<SettingsProps> = ({}) => {
  const [sidePage, setSidePage] = React.useState<{
    category: string;
    page: string;
  } | null>(null);

  const settings = Object.values(SettingsData);

  return (
    <AppWrapper appName='settings'>
      <Flex w='full' h='full' px='3' pt='3' flexDir={"column"}>
        <Flex flexDir={"column"} mb='2'>
          <Heading fontSize={"24"}>Settings</Heading>
        </Flex>
        <Flex w='full' flexDir={"column"}>
          {settings.map((s) => (
            <Flex
              key={s.id + s.name}
              w='full'
              flexDir={"column"}
              bg='grey.800'
              borderRadius={"md"}
              overflow='hidden'
            >
              {Object.values(s.pages).map((p) => (
                <Flex
                  key={p.id + p.name}
                  w='full'
                  alignItems={"center"}
                  p='2.5'
                  cursor={"pointer"}
                  transition='0.2s ease-in-out'
                  onClick={() =>
                    setSidePage({
                      category: s.name,
                      page: p.name,
                    })
                  }
                  _hover={{
                    bg: "whiteAlpha.200",
                  }}
                >
                  <Flex
                    mr='2.5'
                    borderRadius={"md"}
                    justifyContent='center'
                    alignItems={"center"}
                    overflow='hidden'
                    bg={p.color}
                    p='1'
                    fontSize={"lg"}
                  >
                    <Icon as={p.Icon()} />
                  </Flex>
                  <Text flex={1} textTransform='capitalize'>
                    {p.name}
                  </Text>
                  <IconButton
                    aria-label='go-to-setting'
                    icon={<BsChevronRight />}
                    size='xs'
                    fontSize={"lg"}
                    variant='unstyled'
                  />
                </Flex>
              ))}
            </Flex>
          ))}
        </Flex>
      </Flex>
      <SidePage
        isActive={sidePage !== null}
        onClose={() => setSidePage(null)}
        title={(sidePage && sidePage.page) || ""}
      >
        {sidePage && sidePage?.page === "general" && (
          <General
            category={(sidePage && sidePage.page) || ""}
            options={
              sidePage &&
              SettingsData[sidePage.category].pages[sidePage.page].options
            }
          />
        )}
        {sidePage && sidePage?.page === "notifications" && (
          <General
            category={(sidePage && sidePage.page) || ""}
            options={
              sidePage &&
              SettingsData[sidePage.category].pages[sidePage.page].options
            }
          />
        )}
        {sidePage && sidePage.page === "wallpaper" && <WallpaperSetting />}
      </SidePage>
    </AppWrapper>
  );
};

export default Settings;
