import { Flex } from "@chakra-ui/react";
import * as React from "react";
import { usePhoneContext } from "../../../../context/phone";

interface FrameProps {}

const Frame: React.FunctionComponent<React.PropsWithChildren<FrameProps>> = ({
  children,
}) => {
  const { state } = usePhoneContext();

  return (
    <Flex
      w='330px'
      pos='relative'
      h='634px'
      borderRadius='2.5rem'
      overflow='hidden'
      bg='grey.800'
    >
      {/* First Frame */}
      <Flex
        w='100%'
        h='full'
        pos='relative'
        borderRadius='2.5rem'
        overflow='hidden'
        boxShadow='inset 0rem 0rem 0rem 0.7rem #101214'
        zIndex={9}
        pointerEvents='none'
        background='transparent !important'
      />

      {/* Frame Highlight */}
      <Flex
        w='full'
        h='full'
        borderRadius='2.5rem'
        boxShadow='inset 0rem 0rem 0.5rem 0.1rem rgba(116, 116, 116, 0.301);'
        overflow='hidden'
        zIndex={10}
        pos='absolute'
        top='0'
        left='0'
        pointerEvents='none'
        background='transparent !important'
      />

      {/* Notch */}
      <Flex
        w='41%'
        h='4%'
        bg='black'
        pos='absolute'
        top='11px'
        left='50%'
        borderRadius='0px 0px 15px 15px'
        zIndex={10}
        overflow='hidden'
        transform='translateX(-50%)'
      >
        <Flex
          w='110%'
          h='110%'
          overflow='hidden'
          pos='absolute'
          top='-50%'
          left='-50%'
          transform='translate(40%, 45%)'
          boxShadow='inset 0rem -1rem 2rem 0.3rem rgba(128, 128, 128, 0.2)'
        />
        <Flex
          w='30%'
          h='25%'
          background='#242424'
          borderRadius='1rem'
          pos='absolute'
          top='50%'
          left='50%'
          transform='translate(-50%, -50%)'
        />
        <Flex
          w='0.8rem'
          h='0.8rem'
          borderRadius='full'
          overflow='hidden'
          zIndex={9}
          pos='absolute'
          top='50%'
          transform='translateY(-50%)'
          left='15%'
          background='#242424'
        >
          <Flex
            w='50%'
            h='50%'
            borderRadius='full'
            pos='absolute'
            top='50%'
            left='50%'
            transform='translate(-50%, -50%)'
            background='#303030'
          />
        </Flex>
      </Flex>

      {/* Main Screen */}
      <Flex
        background='linear-gradient(35deg, #d32f2f 10%, #e91e63 35%, #2196f3)'
        backgroundImage={`url(${state.settings.wallpaper_link})`}
        borderRadius='3rem'
        backgroundPosition='center center'
        backgroundSize='cover'
        backgroundRepeat='no-repeat'
        w='full'
        h='full'
        pos='absolute'
      >
        {children}
      </Flex>
    </Flex>
  );
};

export default Frame;
