import { Flex, Text } from "@chakra-ui/react";
import { toNumber } from "lodash";
import * as React from "react";
import { IconType } from "react-icons";
import { BsBatteryFull, BsBatteryHalf, BsBattery, BsWifi } from "react-icons/bs"
import { MdEmail } from "react-icons/md"

interface StatusBarProps {}

const BatteryCharge: number = 60;
const BatteryIcons: { [charge: number]: IconType } = {
  100: BsBatteryFull,
  70: BsBatteryHalf,
  10: BsBattery
}

const StatusBar: React.FunctionComponent<StatusBarProps> = ({}) => {
  const batteryIcon = () => {
    for (let key in BatteryIcons) {
      if (BatteryCharge <= toNumber(key)) {
        let Icon = BatteryIcons[key];
        return <Icon size={20}/>
      }
    }

    return <BsBatteryFull size={20}/>
  }
  
  return (
    <Flex w='full' h='4.2%' bg='transparent'>
      <Flex w='full' justifyContent={"space-between"}>
        <Flex pl='4' w='24.8%' h='full' alignItems={"center"}>
          <Text fontWeight={"bold"} fontSize='sm'>
            8:52
          </Text>
          <Flex pl='2'>
            <MdEmail size={16}/>
          </Flex>
        </Flex>
        <Flex pr='4' w='24.8%' h='full'>
          <Flex w='full' h='full' alignItems={"end"} flexDirection={"column"}>
            <Flex h='full' alignItems={"center"}>
              <BsWifi size={16}/>
            </Flex>
          </Flex>
          <Flex w='full' h='full' alignItems={"end"} flexDirection={"column"}>
            <Flex h='full' alignItems={"center"}>
              {batteryIcon()}
            </Flex>
          </Flex>
        </Flex>
      </Flex>
    </Flex>
  );
};

export default StatusBar;
