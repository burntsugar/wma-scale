@isTest public class ContentWorkSpaceCrudTest {
    
    @TestSetup
    static void makeData(){
        
    } 

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a null object is passed, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentWorkspace_NullObject_NullPointerException() {

        ContentWorkspace cw;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentWorkSpaceCrud.insertContentWorkspace(cw);
        } catch (NullPointerException npe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When object attributes do not contain required fields, DMLException error is * REQUIRED_FIELD_MISSING.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentWorkspace_SansRequiredAttributes_DMLexceptionError(){

        ContentWorkspace cw = new ContentWorkspace();

        Test.startTest();
        
        Database.SaveResult sr = ContentWorkSpaceCrud.insertContentWorkspace(cw);

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
    @isTest static void insertContentWorkspace_ValidObject_RecordCreated(){

        ContentWorkspace cw = new ContentWorkspace(Name='Testing Workspace', DeveloperName='Testing_Workspace');

        Test.startTest();
        Database.SaveResult sr = ContentWorkSpaceCrud.insertContentWorkspace(cw);
        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Id passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentWorkspace_ValidId_RecordId() {

        String name = 'Synchronicity';
        String developerName = 'Synchronicity';
        ContentWorkspace cw = new ContentWorkspace(Name=name, DeveloperName=developerName);
        insert cw;

        Test.startTest();
        List<ContentWorkspace> results = ContentWorkSpaceCrud.getContentWorkspace(ContentWorkSpaceFieldSelectors.ID, cw.Id);
        Test.stopTest();

        Integer expectedSize = 1;
        System.Assert( results.size() == 1, TestLog.makeTestErrorMessage(expectedSize, results.size()));
        System.Assert( results.get(0).Id != null, TestLog.makeTestErrorMessage('ContentWorkspace record Id', 'null'));
        System.Assert( results.get(0).Name == name, TestLog.makeTestErrorMessage(name, results.get(0).Name));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When Name is passed, record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentWorkspace_ValidName_RecordId() {

        String name = 'Synchronicity';
        String developerName = 'Synchronicity';
        ContentWorkspace cw = new ContentWorkspace(Name=name, DeveloperName=developerName);
        insert cw;

        Test.startTest();
        List<ContentWorkspace> results = ContentWorkSpaceCrud.getContentWorkspace(ContentWorkSpaceFieldSelectors.NAME, cw.Name);
        Test.stopTest();

        ContentWorkspace actualCw = null;
        for(ContentWorkspace c : results){
            if (c.Id == cw.Id) {
                actualCw = c;
                break;
            }
        }
        System.Assert( actualCw != null, TestLog.makeTestErrorMessage('ContentWorkspace record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null Id is passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void getContentWorkspace_NullId_QueryException() {

        String nullId = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentWorkSpaceCrud.getContentWorkspace(ContentWorkSpaceFieldSelectors.ID, nullId);
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
    @isTest static void getContentWorkspace_InvalidId_QueryException() {

        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentWorkSpaceCrud.getContentWorkspace(ContentWorkSpaceFieldSelectors.ID, 'invalid');
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert( doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }
}