@isTest
private class ContentVersionCreatorTest {

    private final static String SETUP_WORKSPACE_NAME = 'banana';
    private final static String WORKSPACE_DEVELOPER_NAME = 'banana';
    private final static String CONTENT_FOLDER_NAME = 'banana Folder';

    @testSetup static void createTestData() {
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;
    }

    @isTest static void saveContentVersion_with_params_expect_record_created() {
        ContentWorkspace setupContentWorkspace = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder where Name =: setupContentWorkspace.Id];
        ContentFolder contentFolder = new ContentFolder(Name=CONTENT_FOLDER_NAME,ParentContentFolderId=workspaceContentFolder.Id);
        insert contentFolder;

        Test.startTest();
        ContentVersion contentVersion = ContentVersionCreator.saveContentVersion(SETUP_WORKSPACE_NAME, CONTENT_FOLDER_NAME, 'bananatitle','banana, banana, banana content');

        System.assert(contentVersion.Id != null, 'ContentVersion record not created.');
    }

    @isTest static void saveContentVersion_with_blank_params_expect_contentexception() {    
            boolean expected = true;
            boolean actual = false;
            String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTVERSION);
            String actualErrorMessage;

            Test.startTest();
            try {
                ContentVersionCreator.saveContentVersion(' ',' ', ' ',' ');
            } catch (ContentException ce) {
                actual = true;
                actualErrorMessage = ce.getMessage();
            }
            Test.stopTest();
    
            System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
            System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
        }

    @isTest static void saveContentVersion_with_unknown_workspace_name_expect_contentexception() {    
            boolean expected = true;
            boolean actual = false;
            String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTWORKSPACE);
            String actualErrorMessage;

            Test.startTest();
            try {
                ContentVersionCreator.saveContentVersion('unknown', CONTENT_FOLDER_NAME, 'bananatitle', 'banana, banana, banana content');
            } catch (ContentException ce) {
                actual = true;
                actualErrorMessage = ce.getMessage();
            }
            Test.stopTest();
    
            System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
            System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
        }

        @isTest static void saveContentVersion_with_unknown_contentfolder_name_expect_contentexception() {        
                boolean expected = true;
                boolean actual = false;
                String expectedErrMsg = ContentException.getErrorMessage(ContentException.errorMsg.NULL_MSG_CONTENTFOLDER);
                String actualErrorMessage;
    
                Test.startTest();
                try {
                    ContentVersionCreator.saveContentVersion(SETUP_WORKSPACE_NAME, 'unknown', 'bananatitle', 'banana, banana, banana content');
                } catch (ContentException ce) {
                    actual = true;
                    actualErrorMessage = ce.getMessage();
                }
                Test.stopTest();
        
                System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
                System.assert(actualErrorMessage == expectedErrMsg, 'expected was ' + expectedErrMsg + ' but was ' + actualErrorMessage);
            }
}
