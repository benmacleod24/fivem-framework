import * as React from "react";
import { useElapsedTime } from "use-elapsed-time";

const isPlaying = true;
const duration = 10;
const options = { isPlaying, duration };
const start = 0;
const end = 100;

interface Options {
  duration?: number;
  start?: number;
  end?: number;
  delay?: number;
  onComplete?: (v: number) => void;
}

const easing = (t: number, b?: number, c?: number, d?: number): number => {
  return b! + c! * (t / d!);
};

const CountdownOptions: Options = {
  duration: 1,
  end: 100,
  start: 0,
  delay: 0,
  onComplete: (v) => {},
};

export const useCountdown = (
  isPlaying: boolean,
  options = CountdownOptions
): number => {
  const [isReady, setIsReady] = React.useState<boolean>(false);
  const __options = { ...CountdownOptions, ...options };

  React.useEffect(() => {
    if (!__options.delay && isPlaying) return setIsReady(true);

    if (__options.delay) {
      setTimeout(() => setIsReady(true), __options.delay * 1000);
    }
  }, [__options.delay, isPlaying]);

  const { elapsedTime } = useElapsedTime({
    isPlaying: isReady,
    duration: __options.duration,
    onComplete: __options.onComplete,
  });

  // Calculate time left from time elapsed
  const timeLeft = Math.ceil(
    easing(
      elapsedTime,
      __options.start,
      __options.end! - __options.start!,
      __options.duration
    )
  );

  return timeLeft;
};
