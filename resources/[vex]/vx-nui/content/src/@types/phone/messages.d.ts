interface Conversation {
  id: number;
  conversationName?: string;
  participants: string[];
  createdAt?: Date;
}

interface PreDBConversation {
  conversationName?: string;
  participants: string[];
}

interface Message {
  id: number;
  message: string;
  conversationId: number;
  author: string;
  sentAt?: Date;
}

interface PreDBMessage {
  conversationId: number;
  targetPhoneNumber: string;
  authorPhoneNumber: string;
  message: string;
}
