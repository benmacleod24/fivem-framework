import { Box, Flex, Grid, Tooltip } from "@chakra-ui/react";
import * as React from "react";
import { useEffect } from "react";
import { MdSettings } from "react-icons/md";
import { usePhoneContext } from "../../../context/phone";
import AppWrapper from "../components/App";
import Icon from "../components/Icons/Icon";
import Apps from "../config/apps";

import EventBus from "../../../lib/events";

interface HomeScreenProps {}

const HomeScreen: React.FunctionComponent<HomeScreenProps> = ({}) => {
  const { dispatch } = usePhoneContext();

  useEffect(() => {
    EventBus.getInstance().register("app", (id: number) => {
      dispatch({ type: "SET_APPLICATION", payload: { appId: id } });
    });
  }, []);

  return (
    <AppWrapper background={"transparent"} appName='home_screen'>
      <Grid
        mt='5'
        px='3'
        templateColumns={"repeat(4, 1fr)"}
        w='full'
        h='fit-content'
        justifyItems={"center"}
        rowGap={4}
      >
        {Object.values(Apps).map(
          (app, index) =>
            app.icon.render() && (
              <Tooltip
                label={app.name.replace("_", " ")}
                textTransform='capitalize'
                maxW='32'
                bg='grey.800'
                fontSize='xs'
                textAlign='center'
                key={index + app.name}
                color='white'
              >
                <Flex
                  w='14'
                  h='14'
                  borderRadius={"xl"}
                  justifyContent='center'
                  alignItems={"center"}
                  overflow='hidden'
                  boxShadow={"base"}
                  onClick={() =>
                    dispatch({ type: "SET_APPLICATION", payload: { appId: app.id } })
                  }
                >
                  {app.icon.render()}
                </Flex>
              </Tooltip>
            )
        )}
      </Grid>
    </AppWrapper>
  );
};

export default HomeScreen;
