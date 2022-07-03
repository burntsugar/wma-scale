@isTest public class ContentFolderMemberCrudTest {
    
    private final static String SETUP_WORKSPACE_NAME = 'Test Setup Workspace';
    private final static String SETUP_WORKSPACE_DEVELOPER_NAME = 'Test_Setup_Workspace';

    @TestSetup
    static void makeData(){
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=SETUP_WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameters are valid, record is updated.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void updateContentFolderMember_ValidParams_success() {

        ContentWorkspace cw = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceFolder = CrudTestingUtils.makeContentWorkspaceContentFolder(SETUP_WORKSPACE_NAME);
        ContentFolder folder = CrudTestingUtils.makeContentFolder(cw.Id, workspaceFolder.Id);

        Test.startTest();

        Database.SaveResult[] sr = ContentFolderMemberCrud.updateContentFolderMember(workspaceFolder.Id, folder.Id);

        Test.stopTest();

        boolean isSuccess = true;
        for (Database.SaveResult s :sr){
            if(s.getErrors().size() > 0) {
                isSuccess = false;
                break;
            }
        }

        System.Assert(isSuccess, TestLog.makeTestErrorMessage(sr));
    }
}