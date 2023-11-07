import * as React from "react";
import { useCountdown } from "../../../../../lib/hooks/useCountdown";
import Circle from "./Circle";

interface StopwatchProps {}

const Stopwatch: React.FunctionComponent<StopwatchProps> = ({}) => {
  const [isPlaying, setIsPlaying] = React.useState(false);
  const [duration, setDuration] = React.useState(10);

  const stopwatchValue = useCountdown(isPlaying, {
    duration: duration,
    onComplete: () => {
      setTimeout(() => {
        setIsPlaying(false);
        setDuration(0);
      }, 750);
    },
  });

  React.useEffect(() => {
    setTimeout(() => setIsPlaying(true), 2000);
  }, []);

  return <Circle _key='stopwatch' value={stopwatchValue} fade={isPlaying} />;
};

export default Stopwatch;
