@isTest
public class AccountControllerTest {
    @isTest
    public static void testGetRecentAccounts() {
        // Create test data (insert test accounts).
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        // Call the method to be tested.
        List<Account> recentAccounts = AccountController.getRecentAccounts();

        // Assert the result (modify this as needed based on your expected result).
        System.assertEquals(10, recentAccounts.size());
    }
}
