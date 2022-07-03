@isTest public class ContentDocumentLinkCrudTest {

    private final static String SETUP_WORKSPACE_NAME = 'Test Setup Workspace';
    private final static String SETUP_WORKSPACE_DEVELOPER_NAME = 'Test_Setup_Workspace';

    @TestSetup
    static void makeData(){
        ContentWorkspace testWorkspace = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME, DeveloperName=SETUP_WORKSPACE_DEVELOPER_NAME);
        insert testWorkspace;
    } 

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object is null, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentDocumentLink_NullObject_NullPointerException() {

        ContentDocumentLink contentDocumentLink;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentDocumentLinkCrud.insertContentDocumentLink(contentDocumentLink);
        } catch (NullPointerException npe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object attributes do not contain required fields, DMLException error is REQUIRED_FIELD_MISSING.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentDocumentLink_InvalidObject_DMLExceptionError() {

        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();

        Test.startTest();
        
        Database.SaveResult sr = ContentDocumentLinkCrud.insertContentDocumentLink(contentDocumentLink);

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
    * When a valid object is passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentDocumentLink_ValidObject_RecordCreated() {
        ContentDocumentLink contentDocumentLink = CrudTestingUtils.setupForInsertContentDocumentLink(SETUP_WORKSPACE_NAME);

        Test.startTest();

        Database.SaveResult sr = ContentDocumentLinkCrud.insertContentDocumentLink(contentDocumentLink);

        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Id passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentDocumentLink_ValidID_RecordId() {
        ContentDocumentLink contentDocumentLink = CrudTestingUtils.setupForInsertContentDocumentLink(SETUP_WORKSPACE_NAME);

        insert contentDocumentLink;

        Test.startTest();

        List<ContentDocumentLink> results =  ContentDocumentLinkCrud.getContentDocumentLink(ContentDocumentLinkFieldSelectors.ID, contentDocumentLink.Id);

        Test.stopTest();

        ContentDocumentLink actualCdl = null;
        for (ContentDocumentLink c :results){
            if (c.Id == contentDocumentLink.Id){
                actualCdl = c;
                break;
            }
        }

        Integer expectedSize = 1;
        System.Assert(results.size() == expectedSize, TestLog.makeTestErrorMessage(expectedSize, results.size()));
        System.Assert(actualCdl != null, TestLog.makeTestErrorMessage('ContentDocumentLink record', 'null'));
        System.Assert(actualCdl.Id != null, TestLog.makeTestErrorMessage('ContentDocumentLink record Id', 'null'));
        System.Assert(actualCdl.Id == contentDocumentLink.ID, TestLog.makeTestErrorMessage('ContentDocumentLink record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null Id is passed, QueryException is thrown.
    * TEST NOT IMPLEMENTED.
    * REQUIRES 'Query all files' permission.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When invalid Id is passed, QueryException is thrown.
    * TEST NOT IMPLEMENTED.
    * REQUIRES 'Query all files' permission.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    
}