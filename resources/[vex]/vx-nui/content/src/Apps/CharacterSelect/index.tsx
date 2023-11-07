import * as React from "react";
import {
  Box,
  Button,
  Flex,
  Grid,
  Heading,
  IconButton,
  Text,
} from "@chakra-ui/react";
import LoadableContentSafe from "../../components/LoadableContent";
import { AddIcon } from "@chakra-ui/icons";
import CharacterModal from "./Modal";
import useSWR from "swr";

interface CharacterSelectProps {}

const CharacterSelect: React.FunctionComponent<CharacterSelectProps> = ({}) => {
  const [isCreating, setCreating] = React.useState<boolean>(false);
  let { data: characters, mutate } = useSWR<Character[]>(`/characters/get`);

  const onCharacterSelect = async (characterId: number) => {
    await fetch("https://vx-nui/characters/selected", {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify({ characterId }),
    });
  };

  return (
    <Box
      pos='absolute'
      left='50%'
      top='50%'
      transform={"translate(-50%, -50%)"}
      w='4xl'
    >
      <LoadableContentSafe data={{ characters }} errors={[]}>
        {({ characters }) => {
          return (
            <Grid templateColumns={"repeat(3, 1fr)"} gap={4} justifyItems={"center"}>
              {characters.map((c, i) => (
                <Flex
                  w='full'
                  p='3'
                  key={i}
                  bg='gray.700'
                  borderRadius={"md"}
                  flexDir={"column"}
                  boxShadow={"dark-lg"}
                >
                  <Heading size='md' textTransform='capitalize'>
                    {c.firstName} {c.lastName}
                  </Heading>
                  <Text color='gray.400' fontSize='sm'>
                    Date of Birth: {c.dateOfBirth}
                  </Text>
                  <Flex w='full'>
                    <Button
                      mr='1'
                      isFullWidth
                      size='sm'
                      mt='3'
                      colorScheme='orange'
                      onClick={() => {
                        onCharacterSelect(c.characterId);
                      }}
                    >
                      Select
                    </Button>
                    <Button ml='1' isFullWidth size='sm' mt='3' colorScheme='red'>
                      Delete
                    </Button>
                  </Flex>
                </Flex>
              ))}
              {characters.length <= 6 && (
                <Flex
                  w='full'
                  h='full'
                  borderRadius='sm'
                  background='gray.700'
                  alignItems='center'
                  justifyContent='center'
                >
                  <IconButton
                    aria-label='new-character'
                    icon={<AddIcon />}
                    borderRadius='full'
                    variant='ghost'
                    size='lg'
                    onClick={() => setCreating(true)}
                  />
                </Flex>
              )}
            </Grid>
          );
        }}
      </LoadableContentSafe>
      <CharacterModal
        isCreating={isCreating}
        setCreating={setCreating}
        characters={characters!}
        mutate={mutate}
      />
    </Box>
  );
};

export default CharacterSelect;
