import * as React from "react";
import { BackgroundProps, Flex, PositionProps } from "@chakra-ui/react";
import StatusBar from "../StatusBar";
import { usePhoneContext } from "../../../../context/phone";
import { AnimatePresence } from "framer-motion";
import Apps from "../../config/apps";
import Scale from "../../../../components/Transitions/Scale";

interface AppProps {
  isHeaderMounted?: boolean;
  background?: BackgroundProps["bg"];
  safeBoundary?: boolean;
  pos?: PositionProps["pos"];
  Transition?: any;
  appName: string;
}

const App: React.FunctionComponent<React.PropsWithChildren<AppProps>> = ({
  isHeaderMounted = true,
  background,
  children,
  safeBoundary = false,
  pos = "relative",
  appName,
  Transition = Scale,
}) => {
  const { dispatch, state } = usePhoneContext();

  return (
    <AnimatePresence exitBeforeEnter initial={false}>
      {Apps[state.application].name === appName && (
        <Transition>
          <Flex
            flexDir={"column"}
            w='full'
            h='full'
            pos='relative'
            bg={background || "grey.900"}
            py='3.3%'
            mx='3.3%'
          >
            {isHeaderMounted && <StatusBar />}
            <Flex
              w='full'
              h={isHeaderMounted ? "calc(100% - 4.2%)" : "100%"}
              pt={safeBoundary && !isHeaderMounted ? "8.3%" : "0"}
              pos={pos}
            >
              {children}
            </Flex>
            <Flex
              mx='auto'
              w='50%'
              h='6'
              opacity={state.settings["hide_home_button"] ? 0.0 : 1.0}
              _hover={{ opacity: 1.0 }}
              transition='0.2s ease-in-out'
            >
              <Flex
                w='28'
                h='1.5'
                bg='white'
                borderRadius={"full"}
                pos='absolute'
                bottom='5'
                left='50%'
                transform='translateX(-50%)'
                transition='0.2s ease-in-out'
                boxShadow='0px 1px 5px 1px rgba(0, 0, 0, 0.2)'
                cursor='pointer'
                _hover={{
                  w: "32",
                }}
                onClick={() =>
                  dispatch({ type: "SET_APPLICATION", payload: { appId: 0 } })
                }
              />
            </Flex>
          </Flex>
        </Transition>
      )}
    </AnimatePresence>
  );
};

export default App;
