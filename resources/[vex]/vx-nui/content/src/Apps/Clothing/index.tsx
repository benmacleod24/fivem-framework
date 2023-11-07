import { Flex, useOutsideClick } from "@chakra-ui/react";
import * as React from "react";
import AnimateApp from "../../components/Transitions/AnimateApp";
import Slide from "../../components/Transitions/Slide";
import Menu from "./components/Menu";
import Accessories from "./pages/Accessories";
import Clothes from "./pages/Clothes";
import Model from "./pages/Model";
import post from "../../lib/post";

interface ClothingProps {}

const Clothing: React.FunctionComponent<ClothingProps> = ({}) => {
  const ref: React.LegacyRef<HTMLDivElement> = React.createRef();
  const [menuType, setMenuType] = React.useState<"clothing" | "barber">("clothing");
  const [page, setPage] = React.useState<string>("");

  React.useEffect(() => {
    if (menuType === "barber") setPage("parents");
    if (menuType === "clothing") setPage("model");
  }, [menuType]);

  return (
    <AnimateApp
      appName='clothing'
      Transition={Slide}
      transitionProps={{ h: "full", w: "md", pos: "absolute", right: 0, speed: 0.5 }}
    >
      <Flex w='full' ref={ref} h='full' bg='gray.700' flexDir={"column"}>
        <Menu page={page} setPage={setPage} menuType={menuType} />
        {page === "model" && <Model />}
        {page === "clothes" && <Clothes />}
        {page === "accessories" && <Accessories />}
      </Flex>
      <Flex
        pos='fixed'
        w='329%'
        h='full'
        left='-329%'
        onContextMenu={async (e) => await post("/clothing/focus/toggle")}
      />
    </AnimateApp>
  );
};

export default Clothing;
