public class ContactTriggerHandler {
    public static void handleContacts(List<Contact> newContacts, Map<Id, Contact> oldMap) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        
        // Collect Account IDs related to Contacts
        for (Contact contact : newContacts) {
            if (contact.AccountId != null) {
                accountIdsToUpdate.add(contact.AccountId);
            }
            
            // Check if this is an update and AccountId changed
            if (oldMap != null && oldMap.get(contact.Id).AccountId != contact.AccountId) {
                accountIdsToUpdate.add(oldMap.get(contact.Id).AccountId);
            }
        }
        
        // Query and update Account records
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Id accountId : accountIdsToUpdate) {
            // Query to count related Contacts
            Integer numberOfContacts = [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
            
            // Retrieve the Account record and update the field
            Account acc = new Account(Id = accountId, Number_of_Contacts__c = numberOfContacts);
            accountsToUpdate.add(acc);
        }
        
        // Update Account records
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
