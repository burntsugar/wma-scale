@isTest public class ContentFolderCrudTest {

    private final static String SETUP_WORKSPACE_NAME = 'Test Setup Workspace';
    private final static String SETUP_WORKSPACE_DEVELOPER_NAME = 'Test_Setup_Workspace';

    @TestSetup
    static void makeData(){
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=SETUP_WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;        
    } 

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a null object is passed, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentFolder_NullObject_NullPointerException() {

        ContentFolder contentFolder;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentFolderCrud.insertContentFolder(contentFolder);
        } catch (NullPointerException npe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

   /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object does not contain required fields, DMLException error is REQUIRED_FIELD_MISSING.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @istest static void insertContentFolder_InvalidObject_DMLException() {
        ContentFolder contentFolder = new ContentFolder();

        Test.startTest();
        
        Database.SaveResult sr = ContentFolderCrud.insertContentFolder(contentFolder);

        Test.stopTest();

        Integer expectedErrorListSize = 1;
        System.StatusCode expectedStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

        Integer actualErrorListSize = sr.getErrors().size();

        System.Assert(expectedErrorListSize == actualErrorListSize, TestLog.makeTestErrorMessage(expectedErrorListSize, actualErrorListSize));

        System.StatusCode actualStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

        System.Assert(expectedStatusCode == actualStatusCode);    
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object is valid, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @istest static void insertContentFolder_ValidObject_RecordCreated() {
        ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
        ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', ParentContentFolderId=workspaceContentFolder.Id);

        Test.startTest();

        Database.SaveResult sr = ContentFolderCrud.insertContentFolder(contentFolder);

        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Id passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentFolder_ValidId_RecordId() {

        ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
        ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', parentContentFolderId=workspaceContentFolder.Id);
        insert contentFolder;

        Test.startTest();
        List<ContentFolder> results = ContentFolderCrud.getContentFolder(ContentFolderFieldSelectors.ID, contentFolder.Id);
        Test.stopTest();

        Integer expectedSize = 1;
        System.Assert(results.size() == expectedSize, TestLog.makeTestErrorMessage(expectedSize, results.size()));
        System.Assert(results.get(0) != null, TestLog.makeTestErrorMessage('ContentFolder record', 'null'));
        System.Assert(results.get(0).Id == contentFolder.Id, TestLog.makeTestErrorMessage('ContentFolder record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Name passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentFolder_ValidName_RecordId() {

        ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
        ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', parentContentFolderId=workspaceContentFolder.Id);
        insert contentFolder;

        Test.startTest();
        List<ContentFolder> results = ContentFolderCrud.getContentFolder(ContentFolderFieldSelectors.Name, contentFolder.Name);
        Test.stopTest();

        ContentFolder actual = null;
        for (ContentFolder c : results) {
            if (c.Id == contentFolder.Id) {
                actual = c;
                break;
            }
        }

        System.Assert(actual != null, TestLog.makeTestErrorMessage('ContentFolder record', 'null'));
        System.Assert(actual.Id == contentFolder.Id, TestLog.makeTestErrorMessage('ContentFolder record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null Id is passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @istest static void getContentFolder_NullId_QueryException() {
        String nullString = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentFolderCrud.getContentFolder(ContentFolderFieldSelectors.Id, nullString);
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When invalid Id is passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @istest static void getContentFolder_InvalidId_QueryException() {
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentFolderCrud.getContentFolder(ContentFolderFieldSelectors.Id, 'invalidId');
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }
}





// @isTest public class ContentFolderCrudTest {

//     private final static String SETUP_WORKSPACE_NAME = 'Test Setup Workspace';
//     private final static String SETUP_WORKSPACE_DEVELOPER_NAME = 'Test_Setup_Workspace';

//     @TestSetup
//     static void makeData(){
//         ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=SETUP_WORKSPACE_DEVELOPER_NAME);
//         insert testWorkspace;        
//     } 

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When a null object is passed, a NullPointerException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void insertContentFolder_NullObject_NullPointerException() {

//         ContentFolder contentFolder;
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//             ContentFolderCrud.insertContentFolder(contentFolder);
//         } catch (NullPointerException npe) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//    /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When object does not contain required fields, DMLException error is REQUIRED_FIELD_MISSING.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void insertContentFolder_InvalidObject_DMLException() {
//         ContentFolder contentFolder = new ContentFolder();

//         Test.startTest();
        
//         Database.SaveResult sr = ContentFolderCrud.insertContentFolder(contentFolder);

//         Test.stopTest();

//         Integer expectedErrorListSize = 1;
//         System.StatusCode expectedStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

//         Integer actualErrorListSize = sr.getErrors().size();

//         System.Assert(expectedErrorListSize == actualErrorListSize, TestLog.makeTestErrorMessage(expectedErrorListSize, actualErrorListSize));

//         System.StatusCode actualStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

//         System.Assert(expectedStatusCode == actualStatusCode);    }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When a valid object is passed, a record is created.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void insertContentFolder_ValidObject_RecordCreated() {
//         ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
//         ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
//         ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', ParentContentFolderId=workspaceContentFolder.Id);

//         Test.startTest();

//         Database.SaveResult sr = ContentFolderCrud.insertContentFolder(contentFolder);

//         Test.stopTest();

//         System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When null parameters are passed, a DMLException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void insertContentFolder_NullParams_DMLException() {
//         String nullString = null;
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//             ContentFolder contentFolder = ContentFolderCrud.insertContentFolder(nullString, nullString);
//         } catch (DMLException dmle) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When valid parameters are passed, a record is created.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void insertContentFolder_ValidParams_RecordCreated() {
//         ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
//         ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];

//         Test.startTest();
//         ContentFolder contentFolder = ContentFolderCrud.insertContentFolder('Test insertContentFolder', workspaceContentFolder.Id);
//         Test.stopTest();

//         System.Assert(contentFolder.Id != null, TestLog.makeTestErrorMessage('ContentFolder record Id', 'null'));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When Id passed, record is retrieved.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void getContentFolder_ValidId_RecordId() {

//         ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
//         ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
//         ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', parentContentFolderId=workspaceContentFolder.Id);
//         insert contentFolder;

//         Test.startTest();
//         List<ContentFolder> results = ContentFolderCrud.getContentFolder(ContentFolderCrud.Selectors.ID, contentFolder.Id);
//         Test.stopTest();

//         Integer expectedSize = 1;
//         System.Assert(results.size() == expectedSize, TestLog.makeTestErrorMessage(expectedSize, results.size()));
//         System.Assert(results.get(0) != null, TestLog.makeTestErrorMessage('ContentFolder record', 'null'));
//         System.Assert(results.get(0).Id == contentFolder.Id, TestLog.makeTestErrorMessage('ContentFolder record Id', 'null'));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When Name passed, record is retrieved.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void getContentFolder_ValidName_RecordId() {

//         ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
//         ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
//         ContentFolder contentFolder = new ContentFolder(Name='Test insertContentFolder', parentContentFolderId=workspaceContentFolder.Id);
//         insert contentFolder;

//         Test.startTest();
//         List<ContentFolder> results = ContentFolderCrud.getContentFolder(ContentFolderCrud.Selectors.Name, contentFolder.Name);
//         Test.stopTest();

//         ContentFolder actual = null;
//         for (ContentFolder c : results) {
//             if (c.Id == contentFolder.Id) {
//                 actual = c;
//                 break;
//             }
//         }

//         System.Assert(actual != null, TestLog.makeTestErrorMessage('ContentFolder record', 'null'));
//         System.Assert(actual.Id == contentFolder.Id, TestLog.makeTestErrorMessage('ContentFolder record Id', 'null'));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When null Id is passed, QueryException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void getContentFolder_NullId_QueryException() {
//         String nullString = null;
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//             ContentFolderCrud.getContentFolder(ContentFolderCrud.Selectors.Id, nullString);
//         } catch (QueryException qe) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When invalid Id is passed, QueryException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @istest static void getContentFolder_InvalidId_QueryException() {
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//             ContentFolderCrud.getContentFolder(ContentFolderCrud.Selectors.Id, 'invalidId');
//         } catch (QueryException qe) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }
// }
