@isTest
public class CRUDTest {

    private final static String WORKSPACE_NAME = 'Test Workspace Friday';
    private final static String WORKSPACE_DEVELOPER_NAME = 'Test_Workspace_Friday';
    private final static String CONTENT_FOLDER_NAME = 'Test Content Folder';

    @testSetup static void createTestData() {
        ContentWorkspace testWorkspace = new ContentWorkspace(Name='cde', DeveloperName='cde');
        insert testWorkspace;
    }

    @isTest static void saveContentVersion(){
        String headers = 'header-one, header-two';
        String rows = 'col-one, col-two';
        String content = headers +  + '\n';
        content += rows;

        String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');

        String pathOnClient = documentTitle + '.csv';
        
        CRUD crud = new CRUD();
        ContentVersion actualCv = crud.saveContentVersion(pathOnClient, documentTitle, content);
        System.assert(!(actualCv.Id==null),'ContentVersion not created!');
    }

    @isTest static void getContentVersion() {
        String headers = 'header-one, header-two';
        String rows = 'col-one, col-two';
        String content = headers +  + '\n';
        content += rows;

        String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.Title = documentTitle; 
        cv.PathOnClient = documentTitle + '.csv';
        cv.VersionData = Blob.valueOf(content);

        insert cv;
    
        CRUD crud = new Crud();
        ContentVersion testContentVersion = crud.getContentVersion(cv.Id);
        System.assert(!(testContentVersion.Id==null),'ContentVersion not found!');
    }

    @isTest static void saveContentWorkspace() {
        CRUD crud = new Crud();
        ContentWorkspace cwsp = crud.saveContentWorkspace(WORKSPACE_NAME, WORKSPACE_DEVELOPER_NAME);
        System.assert(!(cwsp.Id==null),'ContentWorkspace not created!');
    }

    @isTest static void getContentWorkSpace() {
        ContentWorkspace cwsp = new ContentWorkspace();
        cwsp.Name = WORKSPACE_NAME;
        cwsp.DeveloperName = WORKSPACE_DEVELOPER_NAME;
        insert cwsp;

        CRUD crud = new Crud();
        sObject actualCwsp = crud.getContentWorkSpace(WORKSPACE_NAME);

        System.assert(!(actualCwsp.Id==null),'ContentWorkspace not found!');
    }

    @isTest static void getContentFolderForContentWorkspace() {

        ContentWorkspace cwsp = new ContentWorkspace();
        cwsp.Name = WORKSPACE_NAME;
        cwsp.DeveloperName = WORKSPACE_DEVELOPER_NAME;
        insert cwsp;

        CRUD crud = new Crud();
        ContentFolder actualLcf = crud.getContentFolder(cwsp.Id);
        System.assert(!(actualLcf.Id==null), 'LibraryContentFolder not found!');
    }

    @isTest static void saveContentDocumentLink(){

        String headers = 'header-one, header-two';
        String rows = 'col-one, col-two';
        String content = headers +  + '\n';
        content += rows;

        String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');

        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.Title = documentTitle; 
        cv.PathOnClient = documentTitle + '.csv';
        cv.VersionData = Blob.valueOf(content);
        insert cv;

        String workspaceName = 'cde';
        ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

        CRUD crud = new CRUD();
        ContentDocumentLink actualCdl = crud.saveContentDocumentLink(cv,cwsp);
        System.assert(!(actualCdl.Id==null),'ContentDocumentLink not created!');
    }

    @isTest static void saveContentFolder(){
        // get library
        String workspaceName = 'cde';
        ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

        // get library content folder
        ContentFolder workspaceFolder = [Select Id from ContentFolder where Name =: cwsp.Id];

        CRUD crud = new CRUD();
        ContentFolder actualFolder = CRUD.saveContentFolder('TEST FOLDER',workspaceFolder.Id);
        System.assert(!(actualFolder.Id==null), 'ContentFolder not created!');
    }

    @isTest static void saveContentFolderMember(){

        // get library
        String workspaceName = 'cde';
        ContentWorkspace cwsp = [SELECT Id FROM ContentWorkspace WHERE Name =: workspaceName];

        // get library content folder
        ContentFolder workspaceFolder = [Select Id from ContentFolder where Name =: cwsp.Id];

        // insert folder
        ContentFolder testFolderRecord = new ContentFolder(Name='TEST FOLDER', ParentContentFolderId=workspaceFolder.Id);
        insert testFolderRecord;

        // insert ContentVersion
        String headers = 'header-one, header-two';
        String rows = 'col-one, col-two';
        String content = headers +  + '\n';
        content += rows;

        String documentTitle = 'testContentVersion' + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');

        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.Title = documentTitle; 
        cv.PathOnClient = documentTitle + '.csv';
        cv.VersionData = Blob.valueOf(content);
        insert cv;

        // Insert ContentDocumentLink
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = conDoc;
        cdl.LinkedEntityId = cwsp.Id; 
        cdl.ShareType = 'I'; 
        insert cdl;

        CRUD crud = new CRUD();
        ContentFolderMember actualCfm = crud.saveContentFolderMember(workspaceFolder.Id, testFolderRecord.Id);
        System.assert(!(actualCfm.Id==null),'ContentFolder not created!');
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
