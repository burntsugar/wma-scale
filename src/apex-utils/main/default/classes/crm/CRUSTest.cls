@isTest
public class CRUSTest {

    private final static String WORKSPACE_NAME = 'Test Workspacex';
    private final static String WORKSPACE_DEVELOPER_NAME = 'Test_Workspacex';

    private final static String CONTENT_FOLDER_NAME = 'Test Content Folder';

    //ContentWorkspace testWorkspace;


    @testSetup static void createTestData() {
        // INSERT WORKSPACE
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);
        //testWorkspace = new ContentWorkspace(Name=WORKSPACE_NAME, DeveloperName=WORKSPACE_DEVELOPER_NAME);

        insert testWorkspace;

        // ContentFolder contentFolder = new ContentFolder(Name=WORKSPACE_NAME);
        // insert(contentFolder);

        // ContentFolderMember cfm = new ContentFolderMember();
        // cfm.ParentContentFolderId = contentFolder.Id;

        // ContentDocumentLink cdl = new ContentDocumentLink();
        // cdl.ContentDocumentId = cv.ContentDocumentId;
        // cdl.LinkedEntityId = testWorkspace.Id;   
        // cdl.Sharetype = 'I';

    }

    @isTest static void doInsertOfContentVersion() {

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
    
        CRUD crud = new Crud();
        crud.doInsert(cv);

        System.assert(!(cv.Id==null),'ContentVersion not created!');
    }

    @isTest static void getContentVersion() {

        CRUD crud = new Crud();

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
    
        crud.doInsert(cv);

        ContentVersion retrievedCv = crud.getContentVersion(cv.Id);

        System.assert(!(retrievedCv.Id==null),'ContentVersion not found!');
    }

    @isTest static void getContentWorkSpace() {

        CRUD crud = new Crud();
        sObject cwsp = crud.getContentWorkSpace(WORKSPACE_NAME);

        System.assert(!(cwsp.Id==null),'ContentWorkspace not found!');
    }

    @isTest static void getLibraryContentFolder() {

        CRUD crud = new Crud();
        sObject cwsp = crud.getContentWorkSpace(WORKSPACE_NAME);

        sObject lcf = crud.getLibraryContentFolder(cwsp.Id);
        System.assert(!(lcf.Id==null),'LibraryContentFolder not found!');
    }
}
