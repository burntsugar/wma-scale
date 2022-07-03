@isTest
public class CRUDTest {

    private final static String WORKSPACE_NAME = 'Testing Workspace';
    private final static String WORKSPACE_DEVELOPER_NAME = 'Testing_Workspace';

    private final static String SETUP_WORKSPACE_NAME = 'Setup Workspace';
    private final static String SETUP_WORKSPACE_DEVELOPER_NAME = 'Setup_Workspace';
    private static String SETUP_WORKSPACE_ID;

    @testSetup static void createTestData() {
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=SETUP_WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;
    }

    @isTest static void saveContentVersion(){
        String title = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        String pathOnClient = title + '.csv';
        String content = 'content content content';

        Test.startTest();
        CRUD crud = new CRUD();
        ContentVersion contentVersion = crud.saveContentVersion(pathOnClient, title, content);
        Test.stopTest();

        System.assert(!(contentVersion.Id==null), 'ContentVersion not created!');
    }

    @isTest static void getContentVersion_with_valid_contentversion_expect_new_record() {
        ContentVersion cv = TestUtils.insertContentVersion('S', 'testContentVersion', 'content content content', '.csv');

        Test.startTest();
        CRUD crud = new Crud();
        ContentVersion contentVersion = crud.getContentVersion(cv.Id);
        Test.stopTest();

        System.assert((contentVersion.Id!=null), 'ContentVersion not found!');
    }

    @isTest static void getContentVersion_with_invalid_expect_null() {
        Test.startTest();
        CRUD crud = new Crud();
        ContentVersion contentVersion = crud.getContentVersion('invalid');
        Test.stopTest();

        System.assert((contentVersion==null));
    }

    @isTest static void saveContentWorkspace_valid_params_expect_new_record() {
        Test.startTest();
        CRUD crud = new Crud();
        ContentWorkspace contentWorkspace = crud.saveContentWorkspace(WORKSPACE_NAME, WORKSPACE_DEVELOPER_NAME);
        Test.stopTest();

        System.assert((contentWorkspace.Id!=null),'ContentWorkspace not created!');
    }

    @isTest static void saveContentWorkspace_already_exists_expect_ContentException() {
        Type expectedType = ContentException.class;
        Type actualtype;
        String expectedErrorMessage = ContentException.getErrorMessage(ContentException.errorMsg.DML_DUPLICATE_MSG_CONTENTWORKSPACE);
        String actualErrorMessage;

        Test.startTest();
        CRUD crud = new Crud();
        try {
            ContentWorkspace contentWorkspace = crud.saveContentWorkspace(SETUP_WORKSPACE_NAME, SETUP_WORKSPACE_DEVELOPER_NAME);
        } catch (ContentException ce) {
            actualErrorMessage = ce.getMessage();
            actualtype = ContentException.class;
        } catch (Exception e) {
            actualErrorMessage = e.getMessage();
            actualtype = Exception.class;

        }
        Test.stopTest();

        System.assert((actualType==expectedType), TestUtils.makeTestErrorMessage(expectedType.getName(), actualType != null? actualType.getName() : 'other'));
        System.assert((actualErrorMessage==expectedErrorMessage), TestUtils.makeTestErrorMessage(expectedErrorMessage, actualErrorMessage));
    }

    @isTest static void getContentWorkSpace() {
        Test.startTest();
        CRUD crud = new Crud();
        sObject contentWorkspace = crud.getContentWorkSpace(SETUP_WORKSPACE_NAME);
        Test.stopTest();

        System.assert((contentWorkspace.Id!=null),'ContentWorkspace not found!');
    }

    @isTest static void getContentFolderForContentWorkspace() {
        ContentWorkSpace setupContentWorkspace = [select Id from ContentWorkSpace where Name =:SETUP_WORKSPACE_NAME];

        Test.startTest();
        CRUD crud = new Crud();
        ContentFolder actualContentFolder = crud.getContentFolder(setupContentWorkspace.Id);
        Test.stopTest();

        System.assert(!(actualContentFolder.Id==null), 'LibraryContentFolder not found!');
    }

    @isTest static void saveContentDocumentLink(){
        String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        String pathOnClient = documentTitle + '.csv';
        ContentVersion cv = TestUtils.insertContentVersion('S', documentTitle, pathOnClient, 'content content content');
        ContentWorkspace setupContentWorkspace = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];

        Test.startTest();
        CRUD crud = new CRUD();
        ContentDocumentLink contentDocumentLink = crud.saveContentDocumentLink(cv, setupContentWorkspace);
        Test.stopTest();

        System.assert((contentDocumentLink.Id!=null),'ContentDocumentLink not created!');
    }

    @isTest static void saveContentFolder(){
        ContentWorkspace setupContentWorkspace = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [SELECT Id FROM ContentFolder WHERE Name =: setupContentWorkspace.Id];

        Test.startTest();
        CRUD crud = new CRUD();
        ContentFolder contentFolder = CRUD.saveContentFolder('TEST FOLDER', workspaceContentFolder.Id);
        Test.stopTest();

        System.assert((contentFolder.Id!=null), 'ContentFolder not created!');
    }

    @isTest static void saveContentFolderMember(){
        ContentWorkspace setupContentWorkspace = [SELECT Id FROM ContentWorkspace WHERE Name =:SETUP_WORKSPACE_NAME];
        ContentFolder workspaceContentFolder = [SELECT Id FROM ContentFolder WHERE Name =:setupContentWorkspace.Id];
        ContentFolder testFolderRecord = new ContentFolder(Name='TEST FOLDER', ParentContentFolderId=workspaceContentFolder.Id);
        insert testFolderRecord;

        ContentVersion cv = TestUtils.insertContentVersion('S', 'testContentVersion', 'content content content', '.csv');

        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        ContentDocumentLink cdl = TestUtils.insertContentDocumentLink(conDoc, setupContentWorkspace.Id,'I');

        Test.startTest();
        CRUD crud = new CRUD();
        ContentFolderMember contentFolderMember = crud.saveContentFolderMember(workspaceContentFolder.Id, testFolderRecord.Id);
        Test.stopTest();

        System.assert(!(contentFolderMember.Id==null),'ContentFolder not created!');
    }

}

    // @isTest static void makeContentFolderInLibraryFolder(){

    //     // get library
    //     String workspaceName = 'cde';
    //     ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

    //     // make library folder
    //     ContentFolder libContentFolder = new ContentFolder();
    //     libContentFolder.Name = 'cde';
    //     libContentFolder.ParentContentFolderId = cwsp.Id;

    //     insert libContentFolder;

    //     String parentId = cwsp.Id;
    //     String childId = libContentFolder.Id;

    //     CRUD crud = new CRUD();
    //     ContentFolderMember actualCfm = crud.makeContentFolderMember(parentId, ChildId);

    //     System.assert(!(actualCfm.Id==null),'ContentFolder not created!');


    //     // String contentFolderName = 'poo';
    //     // CRUD crud = new CRUD();
    //     // ContentFolder actualCf = crud.makeContentFolder(contentFolderName,libContentFolder.Id);
    //     // System.assert(!(actualCf.Id==null),'ContentFolder not created!');
    // }

    // @isTest static void makeContentFolderMember(){

    //     // get library
    //     String workspaceName = 'cde';
    //     ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

    //     // get library content folder
    //     ContentFolder workspaceFolder = [Select Id from ContentFolder where Name =: cwsp.Id];

    //     // make library folder
    //     ContentFolder testFolderRecord = new ContentFolder(Name='TEST FOLDER', ParentContentFolderId=workspaceFolder.Id);
    //     insert testFolderRecord;

    //     CRUD crud = new CRUD();
    //     ContentFolderMember actualCfm = crud.makeContentFolderMember(workspaceFolder.Id, testFolderRecord.Id);
    //     System.assert(!(actualCfm.Id==null),'ContentFolder not created!');




        

    //     //ContentFolder libraryContentFolderId = [Select Id from ContentFolder where Name =: workspaceName];


    //     //makeContentFolder(String contentFolderName, String libraryContentFolderId)

    //     // CRUD crud = new CRUD();
    //     // ContentFolder actualCf = crud.makeContentFolder(contentFolderName,libContentFolder.Id);
    //     // System.assert(!(actualCf.Id==null),'ContentFolder not created!');
    // }

    // @isTest static void makeContentDocumentLink(){
    //     //public ContentDocumentLink makeContentDocumentLink(ContentVersion contentVersion,ContentWorkSpace contentWorkspace) {

    //     //DBFutures.insertContentWorkspace(WORKSPACE_NAME,WORKSPACE_DEVELOPER_NAME);

    //     // ContentWorkspace cwsp = new ContentWorkspace();
    //     // cwsp.Name = WORKSPACE_NAME;
    //     // cwsp.DeveloperName = WORKSPACE_DEVELOPER_NAME;
    //     // insert cwsp;

    //     // ContentFolder contentFolder = new ContentFolder(Name='cde');
    //     // insert(contentFolder);


    //     String headers = 'header-one, header-two';
    //     String rows = 'col-one, col-two';
    //     String content = headers +  + '\n';
    //     content += rows;

    //     String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        
    //     // ContentVersion cv = new ContentVersion();
    //     // cv.ContentLocation = 'S'; 
    //     // cv.Title = documentTitle; 
    //     // cv.PathOnClient = documentTitle + '.csv';
    //     // cv.VersionData = Blob.valueOf(content);

    //     ContentVersion cv = new ContentVersion();
    //     cv.ContentLocation = 'S'; 
    //     cv.Title = documentTitle; 
    //     cv.PathOnClient = documentTitle + '.csv';
    //     cv.VersionData = Blob.valueOf(content);
    //     //cv.ContentDocumentId = contentFolder.Id;

    //     //Test.startTest();

    //     insert cv;

    //     // ContentWorkspace cwsp = new ContentWorkspace();
    //     // cwsp.Name = WORKSPACE_NAME;
    //     // cwsp.DeveloperName = WORKSPACE_DEVELOPER_NAME;
    //     // insert cwsp;

    //     // list<sobject> sObjList = new list<sObject>();
    //     // sObjList.add(cv);
    //     // sObjList.add(cwsp);
    //     // insert sObjList;

    //     // Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
    //     //     cv.ContentDocumentId = conDoc;

    //     String workspaceName = 'cde';
    //     ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

    //     //ContentWorkspace cwsp = testWorkspace;
    //     CRUD crud = new CRUD();
    //     ContentDocumentLink actualCdl = crud.makeContentDocumentLink(cv,cwsp);
    //    // Test.stopTest();

    //     System.assert(!(actualCdl.Id==null),'ContentDocumentLink not created!');
    // }

    //@isTest static void make

   
    // @isTest static void getContentFolder() {

    //     ContentWorkspace cwsp1 = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);

    //     insert cwsp1;

    //     CRUD crud = new Crud();

    //     // ContentFolder cf = crud.getLibraryContentFolder(cwsp1.Id);
    //     ContentFolder cf = crud.getContentFolder(cwsp1.Id);


    //     System.assert(!(cf.Id==null),'ContentFolder not created!');

    // }

    // @isTest static void makeContentFolder() {

    //     ContentWorkspace testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);

    //     insert testWorkspace;

    //     CRUD crud = new Crud();

    //     String headers = 'header-one, header-two';
    //     String rows = 'col-one, col-two';
    //     String content = headers +  + '\n';
    //     content += rows;

    //     String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        
    //     ContentVersion cv = new ContentVersion();
    //     cv.ContentLocation = 'S'; 
    //     cv.Title = documentTitle; 
    //     cv.PathOnClient = documentTitle + '.csv';
    //     cv.VersionData = Blob.valueOf(content);

    //     crud.doInsert(cv);

    //     ContentWorkspace cwsp = crud.getContentWorkSpace(WORKSPACE_NAME);

    //     ContentDocumentLink cdl = crud.makeContentDocumentLink(cv,cwsp);

    //     ContentFolder cf = crud.getLibraryContentFolder(cwsp.Id);

    //     // Query on ContentFolderMember Where ChildRecordId is your ContentVersion file Id and ParentContentFolderId is the RootContentFolderId of library(ContentWorkspace).

    //     ContentFolderMember cfm = crud.getContentFolderMember(cf);


    //     ContentFolderMember updateFolderMember = new ContentFolderMember(
    //                                     Id = cfm.Id,
    //                                     ChildRecordId = cv.Id,
    //                                     ParentContentFolderId = cf.Id
    //                                );
    //     update updateFolderMember;



    //     ContentFolder cff = crud.makeContentFolder(cv,'xxx',cwsp);
    //     System.assert(!(cf.Id==null),'ContentFolder not created!');
    // }

    // @isTest static void getContentFolderMember() {

    //     CRUD crud = new Crud();
    //     // Get content folder for workspace
    //     sObject cfm = crud.getContentFolderMember(WORKSPACE_NAME);


    //     sObject lcf = crud.getLibraryContentFolder(cwsp.Id);
    //     System.assert(!(lcf.Id==null),'LibraryContentFolder not found!');
    // }


        // @testSetup static void createTestData() {
    //     // INSERT WORKSPACE
    //     // ContentWorkspace testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);
    //     // //testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);

    //     // insert testWorkspace;

    //     // ContentFolder contentFolder = new ContentFolder(Name=WORKSPACE_NAME);
    //     // insert(contentFolder);

    //     // ContentFolderMember cfm = new ContentFolderMember();
    //     // cfm.ParentContentFolderId = contentFolder.Id;

    //     // ContentDocumentLink cdl = new ContentDocumentLink();
    //     // cdl.ContentDocumentId = cv.ContentDocumentId;
    //     // cdl.LinkedEntityId = testWorkspace.Id;   
    //     // cdl.Sharetype = 'I';

    // }
