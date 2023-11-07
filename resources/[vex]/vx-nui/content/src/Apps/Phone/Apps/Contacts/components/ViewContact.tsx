import {
  Button,
  Flex,
  Grid,
  Icon,
  Input,
  InputGroup,
  InputLeftElement,
  Textarea,
} from "@chakra-ui/react";
import * as React from "react";
import SidePage from "../../../components/App/SidePage";
import { BiRename } from "react-icons/bi";
import { AiFillMessage, AiOutlineNumber } from "react-icons/ai";
import { MdEmail, MdMail } from "react-icons/md";
import { Form, Formik } from "formik";
import * as yup from "yup";
import { fetcher } from "../../../../../lib/swr";
import { BsPersonFill } from "react-icons/bs";
import ReactInputMask from "react-input-mask";
import { PhoneIcon } from "@chakra-ui/icons";
import EventBus from "../../../../../lib/events";

const contactSchema = yup.object().shape({
  contactName: yup.string().required("Contact Name is required."),
  contactNumber: yup.string().required("Contact Number is required."),
  contactEmail: yup.string(),
  contactNotes: yup.string(),
});

interface ViewContactProps {
  contactViewing: Contact | null;
  onClose: () => void;
}

const ViewContact: React.FunctionComponent<ViewContactProps> = ({
  onClose,
  contactViewing,
}) => {
  const [isEditing, setIsEditing] = React.useState<boolean>(false);

  return (
    <SidePage
      isActive={Boolean(contactViewing)}
      onClose={onClose}
      title={(contactViewing && contactViewing.contactName) || ""}
    >
      <Formik
        validationSchema={contactSchema}
        initialValues={{
          contactName: (contactViewing && contactViewing.contactName) || "",
          contactNumber: (contactViewing && contactViewing.contactNumber) || "",
          contactEmail: (contactViewing && contactViewing?.contactEmail) || "",
          contactNotes: (contactViewing && contactViewing?.contactNotes) || "",
        }}
        onSubmit={async (values, props) => {
          props.setSubmitting(true);
          await fetcher("/phone/contact/edit", { ...values });
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
              <Grid w='full' templateColumns={"repeat(2, 1fr)"} gap={2}>
                <Button
                  leftIcon={<PhoneIcon />}
                  colorScheme={"blue"}
                  variant='ghost'
                >
                  Call
                </Button>
                <Button
                  colorScheme={"blue"}
                  variant='ghost'
                  leftIcon={<AiFillMessage />}
                  onClick={() =>
                    EventBus.getInstance().dispatch<any>("phone:test", {}, 2)
                  }
                >
                  Message
                </Button>
              </Grid>
              <InputGroup variant={"filled"}>
                <InputLeftElement children={<BiRename />} />
                <Input
                  placeholder='Name'
                  value={props.values.contactName}
                  isReadOnly={!isEditing}
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
                  isReadOnly={!isEditing}
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
                  isReadOnly={!isEditing}
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
                isReadOnly={!isEditing}
                resize='none'
                value={props.values.contactNotes}
                onChange={(e) => props.setFieldValue("contactNotes", e.target.value)}
                _focus={{ outline: "none" }}
              />
              {isEditing && (
                <Button
                  colorScheme={"green"}
                  w='full'
                  variant={"ghost"}
                  type='submit'
                >
                  Save
                </Button>
              )}
              <Button
                colorScheme={"blue"}
                w='full'
                variant={"ghost"}
                onClick={async () => {
                  if (isEditing) {
                    setIsEditing(false);
                    props.setValues({
                      contactName:
                        (contactViewing && contactViewing.contactName) || "",
                      contactNumber:
                        (contactViewing && contactViewing.contactNumber) || "",
                      contactEmail:
                        (contactViewing && contactViewing?.contactEmail) || "",
                      contactNotes:
                        (contactViewing && contactViewing?.contactNotes) || "",
                    });
                  } else {
                    setIsEditing(true);
                  }
                }}
              >
                {isEditing ? "Cancel" : "Edit"}
              </Button>
            </Flex>
          </Form>
        )}
      </Formik>
    </SidePage>
  );
};

export default ViewContact;
