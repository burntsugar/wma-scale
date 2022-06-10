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
    * When required attributes are omitted in passed object, a DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
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

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a valid object is passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentWorkspace_ValidObject_RecordCreated(){

        ContentWorkspace cw = new ContentWorkspace(Name='Testing Workspace', DeveloperName='Testing_Workspace');

        Test.startTest();
        ContentWorkSpaceCrud.insertContentWorkspace(cw);
        Test.stopTest();

        System.Assert(cw.Id != null, TestLog.makeTestErrorMessage('ContentWorkspace record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null parameters are passed, a DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentWorkspace_NullParameters_DMLException() {

        String nullString = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            ContentWorkSpaceCrud.insertContentWorkspace(nullString, nullString);
        } catch (DMLException dmle) {
            doesThrowExc = true;
        }
        Test.stopTest();

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, expected));
    }
    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When valid parameters are passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void insertContentWorkspace_ValidParameters_RecordCreated() {

        Test.startTest();
        ContentWorkspace cw = ContentWorkSpaceCrud.insertContentWorkspace('Testing Workspace', 'Testing_Workspace');
        Test.stopTest();

        System.Assert(cw.Id != null, TestLog.makeTestErrorMessage('ContentWorkspace record Id', 'null'));
    }
}