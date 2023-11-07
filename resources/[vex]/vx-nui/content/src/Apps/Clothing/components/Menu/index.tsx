import { Button, Grid } from "@chakra-ui/react";
import menuData from "./data.json";
import * as React from "react";

interface MenuProps {
  page: string;
  setPage: (v: string) => void;
  menuType: "clothing" | "barber";
}

const Menu: React.FunctionComponent<MenuProps> = ({ page, setPage, menuType }) => {
  return (
    <Grid templateColumns={"repeat(3, 1fr)"}>
      {menuData
        .filter((d) => d.storeType === menuType)
        .map((d) => (
          <Button
            key={d.id + d.name}
            onClick={() => setPage(d.name)}
            colorScheme={(page === d.name && "orange") || "gray"}
            borderRadius={"none"}
            textTransform='capitalize'
            py='6'
          >
            {d.name}
          </Button>
        ))}
    </Grid>
  );
};

export default Menu;
