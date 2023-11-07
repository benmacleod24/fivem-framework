import { CalendarIcon, CheckIcon } from "@chakra-ui/icons";
import {
  Button,
  Heading,
  Input,
  InputGroup,
  InputLeftAddon,
  Modal,
  ModalBody,
  ModalContent,
  ModalOverlay,
  Select,
  useToast,
} from "@chakra-ui/react";
import { Formik, Form as FForm } from "formik";
import InputMask from "react-input-mask";
import * as React from "react";
import { fetcher } from "../../lib/swr";

interface CharacterModalProps {
  isCreating: boolean;
  setCreating: (v: boolean) => void;
  characters: Character[];
  mutate: any;
}

const CharacterModal: React.FunctionComponent<CharacterModalProps> = ({
  isCreating,
  setCreating,
  characters: data,
  mutate,
}) => {
  const toast = useToast();

  return (
    <Modal isCentered isOpen={isCreating} onClose={() => setCreating(false)}>
      <ModalOverlay background='rgba(0,0,0,0.3)' />
      <ModalContent background='gray.800' boxShadow='lg' borderRadius={"md"}>
        <Formik
          initialValues={{
            firstName: "",
            lastName: "",
            dateOfBirth: "",
            gender: "male",
          }}
          onSubmit={async (values, helps) => {
            const { dateOfBirth, firstName, gender, lastName } = values;
            if (!dateOfBirth || !firstName || !gender || !lastName) {
              toast({
                title: "Creation Error",
                description: "You have provided empty fields.",
                position: "top-right",
                status: "error",
                variant: "subtle",
              });
              helps.setSubmitting(false);
              return;
            }

            const character = {
              firstName: values.firstName,
              lastName: values.lastName,
              dateOfBirth: values.dateOfBirth,
              gender: values.gender,
            };

            const res = await fetcher<number>("characters/post", character);

            let _data: Character[] = [];
            if (data) _data = [...data];

            await mutate([{ ...character, characterId: res }, ..._data]);
            helps.setSubmitting(false);
            setCreating(false);
          }}
        >
          {(props) => (
            <FForm>
              <ModalBody p='5'>
                <Heading size='md'>Create your Character</Heading>
                <InputGroup variant='filled' my='3'>
                  <Input
                    placeholder='First Name'
                    _focus={{ boxShadow: "none" }}
                    value={props.values.firstName}
                    onChange={(e) =>
                      props.setFieldValue("firstName", e.target.value)
                    }
                  />
                </InputGroup>
                <InputGroup variant='filled' my='3'>
                  <Input
                    placeholder='Last Name'
                    _focus={{ boxShadow: "none" }}
                    value={props.values.lastName}
                    onChange={(e) => props.setFieldValue("lastName", e.target.value)}
                  />
                </InputGroup>
                <InputGroup variant='filled' my='3'>
                  <InputLeftAddon children={<CalendarIcon />} />
                  <Input
                    as={InputMask}
                    mask='99/99/9999'
                    placeholder='Date of Birth'
                    _focus={{ boxShadow: "none" }}
                    value={props.values.dateOfBirth}
                    onChange={(e) =>
                      props.setFieldValue("dateOfBirth", e.target.value)
                    }
                  />
                </InputGroup>
                <Select
                  value={props.values.gender}
                  onChange={(e) => props.setFieldValue("gender", e.target.value)}
                  name='gender'
                  variant='filled'
                  _focus={{ boxShadow: "none" }}
                >
                  <option value='male'>Male</option>
                  <option value='female'>Female</option>
                </Select>
                <Button
                  leftIcon={<CheckIcon />}
                  isFullWidth
                  size='md'
                  colorScheme='green'
                  mt='3'
                  type='submit'
                  isLoading={props.isSubmitting}
                >
                  Create
                </Button>
              </ModalBody>
            </FForm>
          )}
        </Formik>
      </ModalContent>
    </Modal>
  );
};

export default CharacterModal;
