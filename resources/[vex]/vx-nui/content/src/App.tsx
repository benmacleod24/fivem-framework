import React from "react";
import { Flex, useToast } from "@chakra-ui/react";
import Phone from "./Apps/Phone";
import Tools from "./components/Tools";
import { useRootContext } from "./context/root";
import { useMessage } from "./lib/hooks/useMessage";
import Target from "./Apps/Target";
import CharacterSelect from "./Apps/CharacterSelect";
import SpawnSelection from "./Apps/SpawnSelection";
import { fetcher } from "./lib/swr";
import Panel from "./Apps/Panel";
import ContextMenu from "./Apps/ContextMenu";
import Clothing from "./Apps/Clothing";
import Inventory from "./Apps/Inventory";
import Notifications from "./Apps/Notifications";
import HUD from "./Apps/HUD";

function App() {
  const { state, dispatch } = useRootContext();
  const toast = useToast();

  // Handler for setting character.
  // Also sets the NUI application to a ready state.
  useMessage(
    "root/app-management/character/set",
    (data: Character) => {
      if (!data) {
        toast({
          title: "Root Error",
          description: "Could not set character data",
          status: "error",
          position: "top-right",
          variant: "solid",
        });
        return;
      }

      dispatch({
        type: "SET_CHARACTER",
        payload: data,
      });
    },
    [state.isAppReady, state.character]
  );

  useMessage(
    "root/app-management/reset",
    (data: Character) => {
      dispatch({ type: "RESET_NUI" });
    },
    [state.isAppReady]
  );

  // Handler for setting current application.
  useMessage(
    "root/app-management/set",
    ({ appName }: { appName: string }) => {
      if (!state.isAppReady) {
        toast({
          title: "Root Error",
          variant: "solid",
          description: "Application is not ready.",
          position: "top-right",
          status: "error",
        });
        return;
      }

      dispatch({
        type: "SET_APPLICATION",
        payload: {
          name: appName,
        },
      });
    },
    [state.isAppReady, state.character]
  );

  // Register global key events
  React.useEffect(() => {
    const keyupHandler = async (e: KeyboardEvent) => {
      if (e.which !== 27) return;

      if (!state.isAppReady || state.application === "spawn") return;
      if (state.application === "target") return await fetcher("target/close");
      return await fetcher("app/close");
    };

    window.addEventListener("keyup", keyupHandler);

    return () => {
      window.removeEventListener("keyup", keyupHandler);
    };
  }, [state.application]);

  return (
    <Flex
      w='100vw'
      h='100vh'
      bg={state.isAppDev ? "#9c9c9c" : "transparent"}
      overflow='hidden'
      // bgImage='https://i.imgur.com/icsF7yz.png'
    >
      {/* Applications that need the ui to be ready */}
      {state.isAppReady && <Phone />}
      {state.isAppReady && <Target />}
      {state.isAppReady && <Panel />}
      {state.isAppReady && <SpawnSelection />}
      {state.isAppReady && <ContextMenu />}
      {state.isAppReady && <Clothing />}
      {state.isAppReady && <Inventory />}
      {state.isAppReady && <HUD />}
      {state.isAppReady && <Notifications />}

      {state.isAppDev && <Tools />}
      {!state.isAppReady && <CharacterSelect />}
    </Flex>
  );
}

export default App;
