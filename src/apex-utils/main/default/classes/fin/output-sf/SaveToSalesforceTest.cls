@isTest
private class SaveToSalesforceTest {

    @isTest static void save() {

        //    public static ContentVersion save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

        boolean expected = true;
        boolean actual = false;
        try {
            SaveToSalesforce.save(' ',' ', ' ',' ');
        } catch (ContentException ce) {
            actual = true;
        }

        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }
}
