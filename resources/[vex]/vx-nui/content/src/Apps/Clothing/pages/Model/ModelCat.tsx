import { Button, Flex, Heading } from "@chakra-ui/react";
import * as React from "react";
import { fetcher } from "../../../../lib/swr";

interface ModelCatProps {
  name: string;
  values: string[];
}

const ModelCat: React.FunctionComponent<ModelCatProps> = ({ name, values }) => {
  const [loading, setLoading] = React.useState<boolean>(false);

  const onModelSelect = async (modelString: string) => {
    setLoading(true);
    await fetcher("/clothing/model/set", { modelString });
    setLoading(false);
  };

  return (
    <Flex flexDir={"column"} my='1.5'>
      <Heading size='md' textTransform={"capitalize"} color='orange.200'>
        {name}
      </Heading>
      {values.map((v) => (
        <Button
          isDisabled={loading}
          onClick={() => onModelSelect(v)}
          borderRadius={"sm"}
          key={v}
          variant={"ghost"}
          my='0.5'
        >
          {v}
        </Button>
      ))}
    </Flex>
  );
};

export default ModelCat;
