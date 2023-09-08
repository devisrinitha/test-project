trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            ContactTriggerHandler.handleContacts(Trigger.new, Trigger.oldMap);
        } else if (Trigger.isDelete) {
            ContactTriggerHandler.handleContacts(Trigger.old, null);
        }
    }
}
