@isTest public class ContentVersionCrudTest {

    @TestSetup
    static void makeData(){
        
    } 

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object is null, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_NullObject_NullPointerException(){

        ContentVersion cv;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentVersionCrud.insertContentVersion(cv);
        } catch (NullPointerException npe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object attribute for required field is blank, DMLException errors are 
    * REQUIRED_FIELD_MISSING and INVALID_ARGUMENT_TYPE
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_BlankRequiredField_DMLExceptionErrors(){

        ContentVersion cv = new ContentVersion();

        Test.startTest();

        Database.SaveResult sr = ContentVersionCrud.insertContentVersion(cv);

        Test.stopTest();

        Integer expectedErrorListSize = 2;
        Set<System.StatusCode> expectedStatusCodes = new Set<System.StatusCode>();
        expectedStatusCodes.add(System.StatusCode.REQUIRED_FIELD_MISSING);
        expectedStatusCodes.add(System.StatusCode.INVALID_ARGUMENT_TYPE);

        Integer actualErrorListSize = sr.getErrors().size();
        System.Assert(expectedErrorListSize == actualErrorListSize, TestLog.makeTestErrorMessage(expectedErrorListSize, actualErrorListSize));

        Set<System.StatusCode> actualStatusCodes = new Set<System.StatusCode>();
        actualStatusCodes.add(sr.getErrors().get(0).getStatusCode());
        actualStatusCodes.add(sr.getErrors().get(1).getStatusCode());
        System.Assert(expectedStatusCodes == actualStatusCodes);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object is valid, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_ValidObject_RecordCreated(){
        ContentVersion cv = new ContentVersion(Title='Test CV', PathOnClient='Test CV.csv', VersionData=Blob.valueOf('content'));

        Test.startTest();
        Database.SaveResult sr = ContentVersionCrud.insertContentVersion(cv);
        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Id passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentVersion_ValidId_RecordId() {

        String title = 'Take me down to the paradise city';
        String pathOnClient = title + '.csv';
        String versionData = 'where the grass is green and the girls are pretty';
        ContentVersion cv = new ContentVersion(Title=title, PathOnClient=pathOnClient, VersionData=Blob.valueOf(versionData));
        insert cv;

        Test.startTest();
        List<ContentVersion> actualCvs = ContentVersionCrud.getContentVersion(ContentVersionFieldSelectors.ID, cv.Id);
        Test.stopTest();

        Integer expectedSize = 1;
        System.Assert( actualCvs.size() == 1, TestLog.makeTestErrorMessage(expectedSize, actualCvs.size()));
        System.Assert( actualCvs.get(0).Id != null, TestLog.makeTestErrorMessage('ContentVersion record Id', 'null'));
        System.Assert( actualCvs.get(0).Title == title, TestLog.makeTestErrorMessage(title, actualCvs.get(0).Title));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Title is passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentVersion_ValidTitle_RecordId() {

        String title = 'Take me down to the paradise city';
        String pathOnClient = title + '.csv';
        String versionData = 'where the grass is green and the girls are pretty';
        ContentVersion cv = new ContentVersion(Title=title, PathOnClient=pathOnClient, VersionData=Blob.valueOf(versionData));
        insert cv;

        Test.startTest();
        List<ContentVersion> results = ContentVersionCrud.getContentVersion(ContentVersionFieldSelectors.TITLE, cv.Title);
        Test.stopTest();

        ContentVersion actualContentVersion = null;
        for (ContentVersion c : results) {
            if (c.Id == cv.Id) {
                actualContentVersion = c;
                break;
            }
        }

        System.Assert( actualContentVersion != null, TestLog.makeTestErrorMessage('ContentVersion record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null Id is passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentVersion_NullId_QueryException() {

        String nullId = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentVersionCrud.getContentVersion(ContentVersionFieldSelectors.ID, nullId);
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert( doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When invalid Id is passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentVersion_InvalidId_QueryException() {

        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentVersionCrud.getContentVersion(ContentVersionFieldSelectors.ID, 'invalidId');
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert( doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }
}