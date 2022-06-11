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
    * When valid parameters are passed, record is updated.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void updateContentFolderMember_ValidParams_success() {

        ContentWorkspace cw = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceFolder = CrudTestingUtils.makeContentWorkspaceContentFolder(SETUP_WORKSPACE_NAME);
        ContentFolder folder = CrudTestingUtils.makeContentFolder(cw.Id, workspaceFolder.Id);

        Test.startTest();
        ContentFolderMemberCrud.updateContentFolderMember(workspaceFolder.Id, folder.Id);
        List<ContentFolderMember> results = [Select Id from ContentFolderMember where ParentContentFolderId =: folder.Id];
        Test.stopTest();

        Integer expectedSize = 1;
        System.Assert(results.size() == expectedSize, TestLog.makeTestErrorMessage(expectedSize, results.size()));
    }
}
