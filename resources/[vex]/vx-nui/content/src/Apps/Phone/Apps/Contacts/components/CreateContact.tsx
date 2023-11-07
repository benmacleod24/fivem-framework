import {
  Button,
  Flex,
  Icon,
  Input,
  InputGroup,
  InputLeftElement,
  Textarea,
} from "@chakra-ui/react";
import * as React from "react";
import SidePage from "../../../components/App/SidePage";
import { BiRename } from "react-icons/bi";
import { AiOutlineNumber } from "react-icons/ai";
import { MdEmail } from "react-icons/md";
import { Form, Formik } from "formik";
import * as yup from "yup";
import { fetcher } from "../../../../../lib/swr";
import { BsPersonFill } from "react-icons/bs";
import ReactInputMask from "react-input-mask";

interface CreateContactProps {
  isCreating: boolean;
  onClose: () => void;
}

const contactSchema = yup.object().shape({
  contactName: yup.string().required("Contact Name is required."),
  contactNumber: yup.string().required("Contact Number is required."),
  contactEmail: yup.string(),
  contactNotes: yup.string(),
});

const CreateContact: React.FunctionComponent<CreateContactProps> = ({
  isCreating,
  onClose,
}) => {
  return (
    <SidePage isActive={isCreating} onClose={onClose} title='Create Contact'>
      <Formik
        validationSchema={contactSchema}
        initialValues={{
          contactName: "",
          contactNumber: "",
          contactEmail: "",
          contactNotes: "",
        }}
        onSubmit={async (values, props) => {
          props.setSubmitting(true);
          await fetcher("/phone/contact/add", { ...values });
          props.setSubmitting(false);
          onClose();
        }}
      >
        {(props) => (
          <Form style={{ width: "100%" }}>
            <Flex flexDir={"column"} w='full' gap={2} alignItems='center' mt='3'>
              <Flex
                w='20'
                h='20'
                bg='grey.600'
                rounded='full'
                alignItems={"center"}
                justifyContent='center'
                fontSize={"2xl"}
                fontWeight='medium'
                mb='3'
              >
                {props.values.contactName
                  .split(" ")
                  .map((v) => (v ? v[0].toLocaleUpperCase() : ""))}
                {!props.values.contactName && (
                  <Icon as={BsPersonFill} fontSize='5xl' />
                )}
              </Flex>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<BiRename />} />
                <Input
                  placeholder='Name'
                  value={props.values.contactName}
                  onChange={(e) =>
                    props.setFieldValue("contactName", e.target.value)
                  }
                  _focus={{ outline: "none" }}
                />
              </InputGroup>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<AiOutlineNumber />} />
                <Input
                  placeholder='Phone Number'
                  value={props.values.contactNumber}
                  as={ReactInputMask}
                  mask='(999) 999-9999'
                  onChange={(e) =>
                    props.setFieldValue("contactNumber", e.target.value)
                  }
                  _focus={{ outline: "none" }}
                />
              </InputGroup>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<MdEmail />} />
                <Input
                  placeholder='Email'
                  value={props.values.contactEmail}
                  onChange={(e) =>
                    props.setFieldValue("contactEmail", e.target.value)
                  }
                  _focus={{ outline: "none" }}
                />
              </InputGroup>
              <Textarea
                placeholder='Notes'
                variant={"filled"}
                resize='none'
                value={props.values.contactNotes}
                onChange={(e) => props.setFieldValue("contactNotes", e.target.value)}
                _focus={{ outline: "none" }}
              />
              <Button
                isDisabled={
                  !props.values.contactName ||
                  props.values.contactNumber.length !== 10
                }
                w='full'
                colorScheme={"blue"}
                variant='ghost'
                type='submit'
                isLoading={props.isSubmitting}
              >
                Save
              </Button>
            </Flex>
          </Form>
        )}
      </Formik>
    </SidePage>
  );
};

export default CreateContact;
