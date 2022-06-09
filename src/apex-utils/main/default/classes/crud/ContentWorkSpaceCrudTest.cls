@isTest public class ContentWorkSpaceCrudTest {
    
    @TestSetup
    static void makeData(){
        
    } 

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

        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void insertContentWorkspace_SansRequiredAttributes_DMLexception(){

        ContentWorkspace cw = new ContentWorkspace();
        boolean doesThrowExc = false;

        Test.startTest();
        try {
        ContentWorkSpaceCrud.insertContentWorkspace(cw);
        } catch (DMLException dmle) {
            doesThrowExc = true;
        }
        Test.stopTest();

        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void insertContentWorkspace_ValidObject_RecordCreated(){

        ContentWorkspace cw = new ContentWorkspace(Name='Testing Workspace', DeveloperName='Testing_Workspace');

        Test.startTest();
        ContentWorkSpaceCrud.insertContentWorkspace(cw);
        Test.stopTest();

        System.Assert(cw.Id != null, makeTestErrorMessage('ContentWorkspace record Id', 'null'));
    }

    @isTest static void insertContentWorkspace_NullParameters_NullPointerException() {

        String nullString = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
        ContentWorkSpaceCrud.insertContentWorkspace(nullString, nullString);
        } catch (DMLException dmle) {
            doesThrowExc = true;
        }
        Test.stopTest();

        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void insertContentWorkspace_ValidParameters_RecordCreated() {

        Test.startTest();
        ContentWorkspace cw = ContentWorkSpaceCrud.insertContentWorkspace('Testing Workspace', 'Testing_Workspace');
        Test.stopTest();

        System.Assert(cw.Id != null, makeTestErrorMessage('ContentWorkspace record Id', 'null'));
    }

    public static String makeTestErrorMessage(String expected, String actual){
        return 'Expected ' + expected + ' but got ' + actual;
    }
}
