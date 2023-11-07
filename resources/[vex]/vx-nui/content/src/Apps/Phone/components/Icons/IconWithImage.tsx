import { Flex } from "@chakra-ui/react";
import * as React from "react";

interface IconWithImageProps {
  url?: string;
}

const IconWithImage: React.FunctionComponent<IconWithImageProps> = ({ url }) => {
  return (
    <Flex
      h='full'
      w='full'
      backgroundSize={"cover"}
      backgroundPosition='center center'
      backgroundRepeat={"no-repeat"}
      backgroundImage={`url(${url})`}
      cursor={"pointer"}
    />
  );
};

export default IconWithImage;
