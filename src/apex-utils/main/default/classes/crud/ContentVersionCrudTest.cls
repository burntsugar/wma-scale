@isTest public class ContentVersionCrudTest {

    @TestSetup
    static void makeData(){
        
    } 

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a null object is passed, a NullPointerException is thrown.
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
    * When required attributes are omitted in passed object, a DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_SansRequiredAttributes_DMLexception(){

        ContentVersion cv = new ContentVersion();
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentVersionCrud.insertContentVersion(cv);
        } catch (DmlException dmle) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a valid object is passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_ValidObject_RecordCreated(){
        ContentVersion cv = new ContentVersion(Title='Test CV', PathOnClient='Test CV.csv', VersionData=Blob.valueOf('content'));

        Test.startTest();
        ContentVersionCrud.insertContentVersion(cv);
        Test.stopTest();

        System.Assert(cv.Id!=null, TestLog.makeTestErrorMessage('ContentVersion record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null parameters are passed, a DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_NullParameters_DMLException(){

        String nullString = null;
        Blob nullBlob = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentVersionCrud.insertContentVersion(nullString, nullString, nullString, nullBlob);
        } catch (DMLException dmle) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When valid parameters are passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentVersion_ValidParams_RecordCreated(){

        Test.startTest();
        ContentVersion cv =  ContentVersionCrud.insertContentVersion('S', 'Test CV', 'Test CV.csv', Blob.valueOf('content'));
        Test.stopTest();
        
        System.Assert(cv.Id != null, TestLog.makeTestErrorMessage('ContentVersion record Id', 'null'));
    }
}