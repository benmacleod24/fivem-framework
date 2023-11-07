export interface Email {
    to: string;
    from: string;
    message: string;
    timestamp: number;
    read: boolean;
}

export const sortEmails = () => {

}

export const EmailsData: Email[] = [
    {
        to: "Test",
        from: "test.test@testing.com",
        message: "This is a random message like an email lol but eh who knwos what will happen",
        timestamp: 134134123,
        read: false
    },
    {
        to: "Test",
        from: "test.test@testing.com",
        message: "This is a random message like an email lol but eh who knwos what will happen",
        timestamp: 134134123,
        read: true
    },
    {
        to: "Test",
        from: "test.test@testing.com",
        message: "This is a random message like an email lol but eh who knwos what will happen",
        timestamp: 134134123,
        read: false
    },
    {
        to: "Test",
        from: "test.test@testing.com",
        message: "Dummy text be here and it be working. Dummy text be here and it be working. Dummy text be here and it be working. Dummy text be here and it be working. Dummy text be here and it be working. Dummy text be here and it be working. Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working. Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working.  Dummy text be here and it be working. ",
        timestamp: 134134123,
        read: true
    },
];