import * as React from "react";
import { FaStopwatch } from "react-icons/fa";
import { useCountdown } from "../../../../../lib/hooks/useCountdown";
import HudCircle from "./HudCircle";

interface StopwatchProps {}

const Stopwatch: React.FunctionComponent<StopwatchProps> = ({}) => {
  const [isPlaying, setIsPlaying] = React.useState(false);
  const [duration, setDuration] = React.useState(0);

  const stopWatchTime = useCountdown(isPlaying, {
    duration,
    onComplete: (v) => {
      setTimeout(() => {
        setIsPlaying(false);
        setDuration(1);
      }, 750);
    },
  });

  return (
    <HudCircle
      hideValue={isPlaying}
      color='#A855F7'
      value={stopWatchTime}
      icon={FaStopwatch}
    />
  );
};

export default Stopwatch;
