@isTest
private class SaveToSalesforceTest {

    @isTest static void save_with_blank_params_expect_contentexception() {
    //save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

        boolean expected = true;
        boolean actual = false;
        String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION);
        String actualErrorMessage;
        try {
            SaveToSalesforce.save(' ',' ', ' ',' ');
        } catch (ContentException ce) {
            actual = true;
            actualErrorMessage = ce.getMessage();
        }

        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
        System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
    }

    @isTest static void save_with_unknown_workspace_name_expect_contentexception() {
        //save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {
    
            boolean expected = true;
            boolean actual = false;
            String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE);
            String actualErrorMessage;

            try {
                SaveToSalesforce.save('unknown', 'unknown', 'none', 'none');
            } catch (ContentException ce) {
                actual = true;
                actualErrorMessage = ce.getMessage();
            }
    
            System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
            System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
        }
}
