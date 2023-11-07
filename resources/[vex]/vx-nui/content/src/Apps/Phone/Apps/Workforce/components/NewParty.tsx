import { Button, Flex, Input, InputGroup, Switch, Text } from "@chakra-ui/react";
import { Form, Formik } from "formik";
import * as React from "react";
import post from "../../../../../lib/post";
import MenuList from "../../../components/App/Menulist";
import MenuItem from "../../../components/App/Menulist/MenuItem";
import SidePage from "../../../components/App/SidePage";

interface NewPartyProps {
  isCreating: boolean;
  onClose: (v: boolean) => void;
}

const NewParty: React.FunctionComponent<NewPartyProps> = ({
  isCreating,
  onClose,
}) => {
  return (
    <SidePage
      isActive={isCreating}
      onClose={() => onClose(false)}
      title='New Party'
      direction='up'
    >
      <Formik
        initialValues={{ name: "", isInviteOnly: false }}
        onSubmit={async (values, props) => {
          props.setSubmitting(true);

          const res = await post("/phone/workforce/party/new", values);

          if (res) {
            props.setSubmitting(false);
            setTimeout(() => onClose(false), 250);
          }
        }}
      >
        {(props) => (
          <Flex as={Form} w='full' flexDir={"column"} mt='1'>
            <InputGroup variant={"filled"} my='3'>
              <Input
                placeholder='Party Name'
                _focus={{ outline: "none" }}
                value={props.values.name}
                onChange={(e) => props.setFieldValue("name", e.target.value)}
              />
            </InputGroup>
            <MenuList>
              <MenuItem
                rightButton={
                  <Switch
                    isChecked={props.values.isInviteOnly}
                    onChange={(e) =>
                      props.setFieldValue("isInviteOnly", !props.values.isInviteOnly)
                    }
                  />
                }
              >
                <Flex justify={"space-between"}>
                  <Text>Invite Only</Text>
                </Flex>
              </MenuItem>
            </MenuList>
            <Button
              colorScheme={"purple"}
              size='sm'
              mt='6'
              type='submit'
              isLoading={props.isSubmitting}
            >
              Create
            </Button>
          </Flex>
        )}
      </Formik>
    </SidePage>
  );
};

export default NewParty;
