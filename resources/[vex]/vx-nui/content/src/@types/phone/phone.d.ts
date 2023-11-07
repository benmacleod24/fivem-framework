interface SettingCategory {
  id: number;
  name: string;
  pages: {
    [x: string]: {
      id: number;
      name: string;
      Icon: () => any;
      color: string;
      options: {
        [k: string]: {
          key: string;
          value: number | string | boolean;
        };
      };
    };
  };
}

interface Contact {
  contactId: number;
  contactName: string;
  contactNumber: string;
  contactEmail?: string;
  contactNotes?: string;
  createdAt?: Date;
}

interface PreDBContact {
  contactName: string;
  contactNumber: string;
  contactEmail?: string;
  contactNotes?: string;
}
