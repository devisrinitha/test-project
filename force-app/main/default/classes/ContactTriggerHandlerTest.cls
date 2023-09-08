@isTest
public class ContactTriggerHandlerTest {
    
    @isTest
    static void testHandleContacts() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create a list of test Contacts related to the Account
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                AccountId = testAccount.Id,
                FirstName = 'Contact',
                LastName = 'Test' + i
            ));
        }
        insert testContacts;
        
        // Check that the Account's "Number_of_Contacts__c" field is updated correctly
        testAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(5, testAccount.Number_of_Contacts__c);
        
        // Update one Contact's AccountId to a different Account
        testContacts[0].AccountId = null; // Remove association with the testAccount
        insert testContacts[0]; // Re-insert to simulate an update
        
        // Check that the Account's "Number_of_Contacts__c" field is updated after the Contact is moved
        testAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(4, testAccount.Number_of_Contacts__c);
        
        // Delete one Contact
        delete testContacts[1];
        
        // Check that the Account's "Number_of_Contacts__c" field is updated after the Contact is deleted
        testAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(3, testAccount.Number_of_Contacts__c);
        
        // Undelete the deleted Contact
        undelete testContacts[1];
        
        // Check that the Account's "Number_of_Contacts__c" field is updated after the Contact is undeleted
        testAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(4, testAccount.Number_of_Contacts__c);
    }
}
