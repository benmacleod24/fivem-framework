export const Placements: { [x: string]: { css: any; transition: any } } = {
  "left-center": {
    css: {
      left: 2.5,
      top: "50%",
      transform: "translatY(-50%)",
    },
    transition: {
      hidden: {
        x: "-120%",
        transition: {
          duration: 0.4,
        },
      },
      visible: {
        x: "0%",
        transition: {
          duration: 0.4,
        },
      },
      exit: {
        x: "-120%",
        transition: {
          duration: 0.4,
        },
      },
    },
  },
  "right-center": {
    css: {
      right: 2.5,
      top: "50%",
      transform: "translatY(-50%)",
    },
    transition: {
      hidden: {
        x: "120%",
        transition: {
          duration: 0.4,
        },
      },
      visible: {
        x: "0%",
        transition: {
          duration: 0.4,
        },
      },
      exit: {
        x: "120%",
        transition: {
          duration: 0.4,
        },
      },
    },
  },
  "right-top": {
    css: { right: 2.5, top: 2.5 },
    transition: {
      hidden: {
        x: "120%",
        transition: {
          duration: 0.4,
        },
      },
      visible: {
        x: "0%",
        transition: {
          duration: 0.4,
        },
      },
      exit: {
        x: "120%",
        transition: {
          duration: 0.4,
        },
      },
    },
  },
  "top-center": {
    css: {
      left: "50%",
      top: 2.5,
      transform: "translateX(-50%)",
    },
    transition: {
      hidden: {
        y: "-120%",
        transition: {
          duration: 0.4,
        },
      },
      visible: {
        y: "0%",
        transition: {
          duration: 0.4,
        },
      },
      exit: {
        y: "-120%",
        transition: {
          duration: 0.4,
        },
      },
    },
  },
  "bottom-center": {
    css: {
      left: "50%",
      bottom: 2.5,
      transform: "translateX(-50%)",
    },
    transition: {
      hidden: {
        y: "120%",
        transition: {
          duration: 0.4,
        },
      },
      visible: {
        y: "0%",
        transition: {
          duration: 0.4,
        },
      },
      exit: {
        y: "120%",
        transition: {
          duration: 0.4,
        },
      },
    },
  },
};
