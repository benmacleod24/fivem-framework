import { Flex, Icon } from "@chakra-ui/react";
import * as React from "react";
import { statuses } from "../../../../../lib/configs/statuses";
import theme from "../../../../../styles/theme";
import { whiten } from "@chakra-ui/theme-tools";
import "./svg.css";
import { useKvpSettings } from "../../../../../lib/hooks/useKvpSettings";
import EventBus from "../../../../../lib/events";
import Fade from "../../../../../components/Transitions/Fade";
import { AnimatePresence } from "framer-motion";

interface CircleProps {
  value: number;
  _key: string;
  fade?: boolean;
}

const Circle: React.FunctionComponent<CircleProps> = ({
  value,
  _key: key,
  fade,
}) => {
  const [hideValue, setHideValue] = React.useState<number>(100);
  const circleRef = React.createRef<SVGCircleElement>();

  const { settings } = useKvpSettings<{ [x: string]: number }>("hud-status");
  const { color, icon } = statuses[key];

  // Set the hide value on mount of circle
  React.useEffect(() => {
    setHideValue(settings[key]);
  }, []);

  // Listen for event changes and store them in the state
  EventBus.getInstance().register(
    "hud-status:settings",
    (settings: { [x: string]: number }) => {
      setHideValue(settings[key]);
    }
  );

  // Calculate the circle value on mount/value change
  React.useEffect(() => calculateStrokePercentage(), [value, key, hideValue]);

  // Func to calculate and apply the value stroke to the circle
  const calculateStrokePercentage = () => {
    const svgCircle = circleRef.current;
    if (!svgCircle) return;

    const radius = svgCircle.r.baseVal.value;
    const circumfrence = radius * 2 * Math.PI;

    svgCircle.style.strokeDasharray = `${circumfrence} ${circumfrence}`;
    svgCircle.style.strokeDashoffset = circumfrence.toString();

    const offset = circumfrence - (value / 100) * circumfrence;
    svgCircle.style.strokeDashoffset = offset.toString();
  };

  const shoulFadeIn = (): boolean => {
    if (fade) return fade;
    if (!hideValue) return false;
    return value <= hideValue;
  };

  return (
    <AnimatePresence exitBeforeEnter>
      {shoulFadeIn() && (
        <Fade w='fit-content' pos='relative'>
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
          </svg>
          <Icon
            pos='absolute'
            top='50%'
            left='50%'
            transform='translate(-50%, -50%)'
            as={icon}
            fontSize='xl'
          />
        </Fade>
      )}
    </AnimatePresence>
  );
};

export default Circle;
