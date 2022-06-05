@isTest
private class SaveToSalesforceTest {

    private final static String WORKSPACE_NAME = 'banana';
    private final static String WORKSPACE_DEVELOPER_NAME = 'banana';
    private final static String CONTENT_FOLDER_NAME = 'banana Folder';

    @testSetup static void createTestData() {
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;
    }

    @isTest static void save_with_params_expect_record_created() {
    //save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {

        // get library
        String workspaceName = WORKSPACE_NAME;
        ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

        // get library content folder
        ContentFolder workspaceFolder = [Select Id from ContentFolder where Name =: cwsp.Id];

        // insert content folder.
        ContentFolder contentFolder = new ContentFolder(Name=CONTENT_FOLDER_NAME,ParentContentFolderId=workspaceFolder.Id);
        insert contentFolder;

        ContentVersion contentVersion = SaveToSalesforce.save(WORKSPACE_NAME, CONTENT_FOLDER_NAME, 'bananatitle','banana, banana, banana content');

        System.assert(contentVersion.Id != null, 'ContentVersion record not created.');
    }

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
                SaveToSalesforce.save('unknown', CONTENT_FOLDER_NAME, 'bananatitle', 'banana, banana, banana content');
            } catch (ContentException ce) {
                actual = true;
                actualErrorMessage = ce.getMessage();
            }
    
            System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
            System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
        }

        @isTest static void save_with_unknown_contentfolder_name_expect_contentexception() {
            //save(String contentWorkspaceName, String contentFolderName, String contentVersionTitle, String content) {
        
                boolean expected = true;
                boolean actual = false;
                String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER);
                String actualErrorMessage;
    
                try {
                    SaveToSalesforce.save(WORKSPACE_NAME, 'unknown', 'bananatitle', 'banana, banana, banana content');
                } catch (ContentException ce) {
                    actual = true;
                    actualErrorMessage = ce.getMessage();
                }
        
                System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
                System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
            }
}
