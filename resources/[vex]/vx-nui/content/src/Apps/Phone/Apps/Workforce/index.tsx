import * as React from "react";
import { Flex } from "@chakra-ui/react";
import AppWrapper from "../../components/App";
import { usePhoneContext } from "../../../../context/phone";
import useSWR from "swr";
import AppLauncher from "../../components/App/Launcher";
import NewParty from "./components/NewParty";
import Home from "./Pages/Home";
import ActiveJob from "./Pages/ActiveJob";

interface WorkforceProps {}

const Workforce: React.FunctionComponent<WorkforceProps> = ({}) => {
  const { state } = usePhoneContext();
  const [isCreating, setIsCreating] = React.useState<boolean>(false);
  // const { data: job, error } = useSWR<Job>(
  //   state.application === 12 ? `/phone/workforce/current-job` : null,
  //   {
  //     refreshInterval: 1750,
  //   }
  // );

  const job: Job = {
    display_name: "Garbage",
    id: 1,
    is_party_enabled: true,
    is_private: false,
    max_member_limit: 3,
    name: "garbage",
    parties: {
      1: {
        isInviteOnly: false,
        partyId: 1,
        partyMembers: [
          {
            characterId: 1,
            netId: 1,
          },
          {
            characterId: 2,
            netId: 2,
          },
        ],
        partyName: "Gang Bitch",
        partyOwner: 1,
      },
    },
  };

  return (
    <AppWrapper appName={"workforce"}>
      <AppLauncher data={{ job }} errors={[]}>
        {({ job }) => (
          <Flex px='3' w='full' flexDir={"column"}>
            {/* <Home setIsCreating={setIsCreating} job={job} /> */}
            <ActiveJob job={job} />
          </Flex>
        )}
      </AppLauncher>
      <NewParty isCreating={isCreating} onClose={setIsCreating} />
    </AppWrapper>
  );
};

export default Workforce;
