import { Flex, Icon, Text } from "@chakra-ui/react";
import * as React from "react";
import AnimateApp from "../../components/Transitions/AnimateApp";
import { useMessage } from "../../lib/hooks/useMessage";
import { fetcher } from "../../lib/swr";
import { ReactComponent as EyeIcon } from "../../styles/assets/icons/target_eye.svg";

interface TargetProps {}

const Target: React.FunctionComponent<TargetProps> = ({}) => {
  const { data } = useMessage<TargetEntry[]>("target:entries:set");

  const handleOnClick = async (evt: any) => {
    await fetcher("/target/select", { ...evt });
  };

  return (
    <AnimateApp
      appName='target'
      transitionProps={{
        speed: 0.1,
        pos: "absolute",
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -50%)",
        flexDir: "column",
        userSelect: "none",
      }}
    >
      <Icon
        as={EyeIcon}
        fontSize='5xl'
        fill={data && data.length >= 1 ? "orange.500" : "white"}
        filter='drop-shadow(1px 1px 0px rgb(0 0 0 / 0.4));'
      />
      <Flex flexDir={"column"} pos='absolute' w='sm' top='100%' left='3'>
        {data &&
          data.map((d) => (
            <Flex alignItems={"center"} onClick={() => handleOnClick(d)}>
              <i
                className={d.icon}
                style={{
                  color: "#DD6B20",
                  textShadow: "1px 1px 0px rgb(0 0 0 / 0.4)",
                  fontSize: "1.25rem",
                }}
              ></i>
              <Text
                ml='2'
                fontWeight='bold'
                filter='drop-shadow(1px 1px 0px rgb(0 0 0 / 0.4));'
                fontSize='lg'
                _hover={{ color: "orange.100" }}
                cursor='pointer'
                transition='0.2s ease-in-out'
              >
                {d.label}
              </Text>
            </Flex>
          ))}
      </Flex>
    </AnimateApp>
  );
};

export default Target;
