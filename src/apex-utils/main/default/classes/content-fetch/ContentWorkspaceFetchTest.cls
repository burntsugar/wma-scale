@isTest public class ContentWorkspaceFetchTest {

    private static String SETUP_WORKSPACE_NAME = 'Fabulous Workspace';

    @testSetup static void createData() {
        ContentWorkspace cw = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME);
        insert cw;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter is invalid, ContentException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void fetch_InvalidParam_ContentException() {

        boolean doesThrow = false;

        Test.startTest();
        try {
            ContentWorkspaceFetch cwfetch = new ContentWorkspaceFetch();
            ContentWorkspace cw = cwfetch.fetch('Not exist');
        } catch (ContentException ce) {
            doesThrow = true;
        }
        Test.stopTest();

        System.Assert(doesThrow);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter is blank, ContentException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void fetch_BlankParam_ContentException() {

        boolean doesThrow = false;

        Test.startTest();
        try {
            ContentWorkspaceFetch cwfetch = new ContentWorkspaceFetch();
            ContentWorkspace cw = cwfetch.fetch('');
        } catch (ContentException ce) {
            doesThrow = true;
        }
        Test.stopTest();

        System.Assert(doesThrow);
    }

       /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter is valid, Record is returned.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void fetch_ValidParam_RecordRetrieved() {

        Test.startTest();
        
        ContentWorkspaceFetch cwfetch = new ContentWorkspaceFetch();
        ContentWorkspace cw = cwfetch.fetch(SETUP_WORKSPACE_NAME);
        
        Test.stopTest();

        String expectedName = SETUP_WORKSPACE_NAME;
        String actualName = cw.Name;
        System.Assert(actualName == expectedName, TestLog.makeTestErrorMessage(expectedName,actualName));
    }
}
