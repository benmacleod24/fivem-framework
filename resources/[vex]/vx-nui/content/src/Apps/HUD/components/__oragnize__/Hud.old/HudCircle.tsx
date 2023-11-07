import * as React from "react";
import { whiten, transparentize, darken } from "@chakra-ui/theme-tools";
import { BackgroundProps } from "@chakra-ui/styled-system";
import theme from "../../../../../styles/theme";
import "./svg.css";
import { Flex } from "@chakra-ui/layout";
import Icon from "@chakra-ui/icon";
import { Fade } from "@chakra-ui/react";

interface HudCircleProps {
  color: string;
  value: number;
  icon: any;
  hideValue: boolean;
}

const HudCircle: React.FunctionComponent<HudCircleProps> = ({
  color,
  value,
  icon,
  hideValue,
}) => {
  const circleRef = React.createRef<SVGCircleElement>();

  React.useEffect(() => {
    circleValue();
  }, [value]);

  const circleValue = () => {
    const svgCircle = circleRef.current;
    if (!svgCircle) return;

    const radius = svgCircle.r.baseVal.value;
    const circumfrence = radius * 2 * Math.PI;

    svgCircle.style.strokeDasharray = `${circumfrence} ${circumfrence}`;
    svgCircle.style.strokeDashoffset = circumfrence.toString();

    const offset = circumfrence - (value / 100) * circumfrence;
    svgCircle.style.strokeDashoffset = offset.toString();
  };

  return (
    <Fade in={hideValue} unmountOnExit>
      <Flex w='fit-content' mx='-0.5' pos='relative'>
        <svg width={60} height={60} xmlns='http://www.w3.org/2000/svg' version='2'>
          <circle
            fill='transparent'
            r='22.4'
            cx='30'
            cy='30'
            stroke={whiten(color, 5)(theme)}
            strokeOpacity={0.4}
            className='svgCirlceStyles'
            strokeWidth={7}
          />
          <circle
            fill='transparent'
            r='22.4'
            cx='30'
            cy='30'
            stroke={color}
            strokeWidth={7}
            className='svgCirlceStyles'
            ref={circleRef}
          />
          <circle fill='rgba(0, 0, 0, 0.85)' r='19' cx='30' cy='30' />
          {/* <image href={img} height='25' width='25' x='17.5' y='16' /> */}
        </svg>
        <Icon
          pos='absolute'
          top='50%'
          left='50%'
          transform='translate(-50%, -50%)'
          as={icon}
          fontSize='2xl'
        />
      </Flex>
    </Fade>
  );
};

export default HudCircle;
