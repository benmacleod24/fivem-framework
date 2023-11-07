import { Flex, Text, IconButton } from "@chakra-ui/react";
import * as React from "react";
import { FaChevronRight } from "react-icons/fa";

interface ContactListProps {
  contacts: { [x: string]: { group: string; children: Contact[] } };
  onViewContact: (v: Contact) => void;
}

const ContactList: React.FunctionComponent<ContactListProps> = ({
  contacts,
  onViewContact,
}) => {
  return (
    <Flex mt='3' w='full' flexDir={"column"}>
      {Object.values(contacts)
        .sort((a, b) => a.group.localeCompare(b.group))
        .map((group, index) => (
          <Flex w='full' flexDir={"column"} key={group.group + index}>
            <Text
              w='full'
              color='blue.300'
              borderRadius={"sm"}
              bg='grey.800'
              px='3'
              my='0.5'
            >
              {group.group}
            </Text>
            {group.children.map((c, i) => (
              <Flex
                onClick={() => onViewContact(c)}
                alignItems={"center"}
                justifyContent='space-between'
                key={c.contactId + i}
                p='1.5'
                px='3'
                _even={{
                  borderTop: "1px solid",
                  borderTopColor: "grey.800",
                }}
                _odd={{
                  borderTop: "1px solid",
                  borderTopColor: "grey.800",
                }}
                _first={{ borderTop: "none" }}
                cursor='pointer'
                transition={"0.2s ease-in-out"}
                _hover={{
                  bg: "whiteAlpha.50",
                }}
              >
                <Text>{c.contactName}</Text>
                <IconButton
                  aria-label='view-contact'
                  icon={<FaChevronRight />}
                  colorScheme='blue'
                  variant='ghost'
                  rounded='full'
                  size='xs'
                />
              </Flex>
            ))}
          </Flex>
        ))}
    </Flex>
  );
};

export default ContactList;
