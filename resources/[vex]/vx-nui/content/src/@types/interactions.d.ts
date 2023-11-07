interface ContextMenuOption {
  id: number;
  title: string;
  icon?: string;
  description?: string;
  data?: any;
}

interface NotificationType {
  id: number;
  label: string;
  color: BackgroundProps["background"];
  isStatic?: boolean;
  timeout?: number;
  isActive?: boolean;
}
