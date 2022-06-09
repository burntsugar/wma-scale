@isTest public class ContentVersionCrudTest {

    @TestSetup
    static void makeData(){
        
    } 

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
        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

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
        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void insertContentVersion_ValidObject_RecordCreated(){
        ContentVersion cv = new ContentVersion(Title='Test CV', PathOnClient='Test CV.csv', VersionData=Blob.valueOf('content'));

        Test.startTest();
        ContentVersionCrud.insertContentVersion(cv);
        Test.stopTest();

        System.Assert(cv.Id!=null, makeTestErrorMessage('ContentVersion record Id', 'null'));
    }

    @isTest static void insertContentVersion_NullParameters_NullPointerException(){

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

        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void insertContentVersion_ValidParams_RecordCreated(){

        Test.startTest();
        ContentVersion cv =  ContentVersionCrud.insertContentVersion('S', 'Test CV', 'Test CV.csv', Blob.valueOf('content'));
        Test.stopTest();
        
        System.Assert(cv.Id != null, makeTestErrorMessage('ContentVersion record Id', 'null'));
    }

    public static String makeTestErrorMessage(String expected, String actual){
        return 'Expected ' + expected + ' but got ' + actual;
    }
    
}
