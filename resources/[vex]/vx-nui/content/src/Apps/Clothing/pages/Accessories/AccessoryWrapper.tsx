import { ArrowLeftIcon, ChevronLeftIcon, ChevronRightIcon } from "@chakra-ui/icons";
import { Button, Flex, Grid, IconButton, Input, Text } from "@chakra-ui/react";
import * as React from "react";
import { BiArrowToLeft } from "react-icons/bi";
import { fetcher } from "../../../../lib/swr";
import { AccessoriesType } from "./accessories";

interface AccessoryWrapperProps {
  data: AccessoriesType;
}

const AccessoryWrapper: React.FunctionComponent<AccessoryWrapperProps> = ({
  data,
}) => {
  const [loading, setLoading] = React.useState<boolean>(false);
  const [drawable, setDrawable] = React.useState<number>(0);
  const [maxDrawable, setMaxDrawable] = React.useState<number>(10);
  const [texture, setTexture] = React.useState<number>(0);
  const [maxTexture, setMaxTexture] = React.useState<number>(0);

  // Runs when component is mounted and drawable is updated
  // Gathers all the data for the new drawable
  // Also restricts moving forward until client updates new drawable
  React.useEffect(() => {
    const asyncWrapper = async () => {
      setLoading(true);

      const res = await fetcher<any>("/clothing/acessories/component/current", {
        componentId: data.componentId,
      });

      // Drawable
      setDrawable(res.drawableId);
      setMaxDrawable(res.drawableMax);

      // Texture
      setTexture(res.textureId);
      setMaxTexture(res.textureMax);

      setLoading(false);
    };

    asyncWrapper();
  }, [drawable, texture]);

  const onNextDrawable = async (value: number) => {
    let newDrawableId: number = value;

    if (newDrawableId >= maxDrawable) {
      newDrawableId = 0;
    } else if (newDrawableId <= -1) {
      newDrawableId = maxDrawable - 1;
    }

    await fetcher("/clothing/acessories/component/drawable/set", {
      componentId: data.componentId,
      drawableId: newDrawableId,
    });

    setDrawable(newDrawableId);
  };

  const onNextTexture = async (value: number) => {
    let newTextureId: number = value;

    if (newTextureId >= maxTexture) {
      newTextureId = 0;
    } else if (newTextureId <= 0) {
      newTextureId = maxTexture - 1;
    }

    await fetcher("/clothing/acessories/component/drawable/set", {
      componentId: data.componentId,
      drawableId: drawable,
      textureId: newTextureId,
    });

    setTexture(newTextureId);
  };

  return (
    <Flex
      borderRadius={"md"}
      flexDir={"column"}
      w='full'
      bg='gray.600'
      my='1.5'
      p='1'
      px='2'
      transition={"0.25s ease-in-out"}
      _hover={{
        boxShadow: "base",
      }}
    >
      <Flex flexDir={"column"}>
        <Text fontWeight={"semibold"} color='orange.200'>
          {data.name}
        </Text>
        <Grid p='3' templateColumns={"repeat(2, 1fr)"} gap={7}>
          <Flex flexDir={"column"}>
            <Text fontSize={"sm"} mb='1' color='whiteAlpha.600'>
              Drawable: {drawable}/{maxDrawable - 1}
            </Text>
            <Flex>
              <IconButton
                aria-label='arrow-left'
                onClick={() => onNextDrawable(drawable - 1)}
                icon={<ChevronLeftIcon />}
              />
              <Input
                mx='2'
                textAlign={"center"}
                variant={"filled"}
                type='number'
                value={drawable}
                onChange={(e) => onNextDrawable(Number(e.target.value))}
              />
              <IconButton
                aria-label='arrow-right'
                onClick={() => onNextDrawable(drawable + 1)}
                icon={<ChevronRightIcon />}
              />
            </Flex>
          </Flex>
          <Flex flexDir={"column"}>
            <Text fontSize={"sm"} mb='1' color='whiteAlpha.600'>
              Texture: {texture}/{maxTexture - 1}
            </Text>
            <Flex>
              <IconButton
                aria-label='arrow-left'
                onClick={() => onNextTexture(texture - 1)}
                icon={<ChevronLeftIcon />}
              />
              <Input
                mx='2'
                textAlign={"center"}
                variant={"filled"}
                type='number'
                value={texture}
                onChange={(e) => onNextTexture(Number(e.target.value))}
              />
              <IconButton
                aria-label='arrow-right'
                onClick={() => onNextTexture(texture + 1)}
                icon={<ChevronRightIcon />}
              />
            </Flex>
          </Flex>
        </Grid>
      </Flex>
    </Flex>
  );
};

export default AccessoryWrapper;
