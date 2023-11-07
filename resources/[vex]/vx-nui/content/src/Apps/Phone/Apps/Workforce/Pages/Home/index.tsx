import { Button, Flex } from "@chakra-ui/react";
import * as React from "react";
import { MdGroupAdd } from "react-icons/md";
import Header from "../../components/Header";
import Parties from "./components/Parties";

interface HomeProps {
  job: Job;
  setIsCreating: (v: boolean) => void;
}

const Home: React.FunctionComponent<HomeProps> = ({ job, setIsCreating }) => {
  return (
    <Flex w='full' h='full' flexDir={"column"}>
      <Header />
      <Parties job={job} />
      <Flex w='full' flexGrow={1} align='flex-end' pb='2'>
        <Button
          leftIcon={<MdGroupAdd />}
          w='full'
          onClick={() => setIsCreating(true)}
        >
          New Party
        </Button>
      </Flex>
    </Flex>
  );
};

export default Home;
