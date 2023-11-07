export interface Registry {
    unregister: () => void;
}
  
export interface Callable {
    [key: string]: Function;
}
  
export interface Subscriber {
    [key: string]: Callable;
}
  
export interface IEventBus {
    dispatch<T>(event: string, arg?: T): void;
    register(event: string, callback: Function): Registry;
}

class EventBus implements IEventBus {
    private static instance?: EventBus = undefined;

    private subscribers: Subscriber;
    private static nextId = 0;
  
    constructor() {
      this.subscribers = {};
    }
  
    public static getInstance(): EventBus {
        if (this.instance === undefined) {
          this.instance = new EventBus();
        }
    
        return this.instance;
    }

    public dispatch<T>(event: string, arg?: T, appId?: number): void {
      const subscriber = this.subscribers[event];
  
      if (subscriber === undefined) {
        return;
      }

      if (appId != undefined) {
        this.dispatch<number>("app", appId);
      }
  
      Object.keys(subscriber).forEach((key) => subscriber[key](arg));
    }
  
    public register(event: string, callback: Function): Registry {
      const id = this.getNextId();
      if (!this.subscribers[event]) this.subscribers[event] = {};
  
      this.subscribers[event][id] = callback;
  
      return {
        unregister: () => {
          delete this.subscribers[event][id];
          if (Object.keys(this.subscribers[event]).length === 0)
            delete this.subscribers[event];
        },
      };
    }
  
    private getNextId(): number {
      return EventBus.nextId++;
    }
}

export default EventBus;