import { Flex, Text } from "@chakra-ui/layout";
import * as React from "react";
import { numberWithCommas } from "../../../lib";
import { useMessage } from "../../../lib/hooks/useMessage";

interface CashProps {}

const Cash: React.FunctionComponent<CashProps> = ({}) => {
  const [flash, setFlash] = React.useState(false);
  const [amount, setAmount] = React.useState(0);

  useMessage<{ amount: number }>(
    "nui:cash:flash",
    (data) => {
      setAmount(data.amount);
      setFlash(true);

      setTimeout(() => {
        setFlash(false);
      }, 5000);
    },
    []
  );

  return (
    <Flex
      opacity={flash ? 1.0 : 0.0}
      transition='0.3s ease-in-out'
      pos='absolute'
      right='5'
      top='16'
    >
      <Flex>
        <Text
          fontFamily="'PricedownBl-Regular', sans-serif"
          color='green.600'
          mr='1'
          fontSize='4xl'
          textShadow='1px 1px black'
        >
          $
        </Text>
        <Text
          fontFamily="'PricedownBl-Regular', sans-serif"
          color='white'
          fontSize='4xl'
          textShadow='1px 1px black'
        >
          {numberWithCommas(amount)}
        </Text>
      </Flex>
    </Flex>
  );
};

export default Cash;
