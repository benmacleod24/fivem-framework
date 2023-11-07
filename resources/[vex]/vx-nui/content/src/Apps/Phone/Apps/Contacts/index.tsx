import { AddIcon, ChevronRightIcon, SearchIcon } from "@chakra-ui/icons";
import {
  Button,
  Flex,
  Heading,
  IconButton,
  Image,
  Input,
  InputGroup,
  InputLeftElement,
  Text,
} from "@chakra-ui/react";
import * as React from "react";
import { useEffect } from "react";
import ViewContact from "./components/ViewContact";
import { FaChevronRight } from "react-icons/fa";
import Fade from "../../../../components/Transitions/Fade";
import { ContactsData } from "../../../../lib/data/phone/contacts";
import AppWrapper from "../../components/App";
import SidePage from "../../components/App/SidePage";
import ContactList from "./components/ContactList";
import CreateContact from "./components/CreateContact";
import MyCard from "./components/MyCard";
import SearchBar from "./components/SearchBar";
import Scale from "../../../../components/Transitions/Scale";

import { Email } from "../../../../lib/data/phone/emails";
import EventBus from "../../../../lib/events";

interface ContactsProps {}

const Contacts: React.FunctionComponent<ContactsProps> = ({}) => {
  const [isCreating, setIsCreating] = React.useState<boolean>(false);
  const [contactViewing, setContactViewing] = React.useState<Contact | null>(null);
  const [searchString, setSearchString] = React.useState<string>("");

  // Needs to be made into an SWR fetch
  const contacts = ContactsData.reduce(
    (sorted: { [x: string]: { group: string; children: Contact[] } }, contact) => {
      let group = contact.contactName[0].toLocaleUpperCase();

      if (
        !contact.contactName
          .toLocaleUpperCase()
          .includes(searchString.toLocaleUpperCase())
      )
        return sorted;

      if (!sorted[group]) sorted[group] = { group, children: [contact] };
      else sorted[group].children.push(contact);

      return sorted;
    },
    {}
  );

  useEffect(() => {
    EventBus.getInstance().register("phone:test", (email: Email) => {
      console.log(email.from);
    });
  }, []);

  return (
    <AppWrapper appName='contacts' Transition={Scale}>
      <Flex w='full' h='full' flexDir={"column"}>
        <SearchBar
          value={searchString}
          onChange={(v) => setSearchString(v)}
          onClick={() => setIsCreating(true)}
        />
        <MyCard />
        <ContactList contacts={contacts} onViewContact={setContactViewing} />
      </Flex>
      <ViewContact
        contactViewing={contactViewing}
        onClose={() => setContactViewing(null)}
      />
      <CreateContact isCreating={isCreating} onClose={() => setIsCreating(false)} />
    </AppWrapper>
  );
};

export default Contacts;
