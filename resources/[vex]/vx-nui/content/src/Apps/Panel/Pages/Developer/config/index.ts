export interface DeveloperOption {
  id: number;
  name: string;
  interface: SwitchOption | InputOption;
}

interface SwitchOption {
  type: "SWITCH";
  defaultValue: boolean;
  endpoint: string;
}

interface InputOption {
  type: "INPUT";
  options?: { label: string; value: any }[] | string;
  showOptionsOnClick?: boolean;
  onSubmit?: boolean;
  endpoint: string;
  placeholder?: string;
}

export const options: DeveloperOption[] = [
  {
    id: 1,
    name: "Show Entities",
    interface: {
      type: "SWITCH",
      defaultValue: false,
      endpoint: "show-entities",
    },
  },
  {
    id: 2,
    name: "Show Coords",
    interface: {
      type: "SWITCH",
      defaultValue: false,
      endpoint: "show-coords",
    },
  },
  {
    id: 3,
    name: "Spawn Vehicle",
    interface: {
      endpoint: "/dev/spawn/vehicle",
      type: "INPUT",
      onSubmit: true,
      showOptionsOnClick: true,
      options: [
        {
          label: "porsche",
          value: "boxter617",
        },
        {
          label: "ferrari",
          value: "ferrari488gt",
        },
        {
          label: "Lamborgini",
          value: "aventador322",
        },
      ],
    },
  },
  {
    id: 4,
    name: "Revive Character",
    interface: {
      endpoint: "/dev/characters/revive",
      type: "INPUT",
      showOptionsOnClick: true,
      options: "/dev/kvp/characters",
    },
  },
  {
    id: 5,
    name: "Set Weather",
    interface: {
      endpoint: "/dev/weather/set",
      type: "INPUT",
      showOptionsOnClick: true,
      options: [
        {
          label: "Extra Sunny",
          value: "EXTRASUNNY",
        },
        {
          label: "Clear",
          value: "CLEAR",
        },
        {
          label: "Noraml",
          value: "NEUTRAL",
        },
        {
          label: "Rain",
          value: "RAIN",
        },
        {
          label: "Foggy",
          value: "FOGGY",
        },
        {
          label: "Cloudy",
          value: "CLOUDS",
        },
        {
          label: "Overcast",
          value: "OVERCAST",
        },
      ],
    },
  },
  {
    id: 6,
    name: "Freeze Weather",
    interface: {
      type: "SWITCH",
      defaultValue: false,
      endpoint: "freeze-weather",
    },
  },
];
