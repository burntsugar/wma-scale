@isTest public class ContentFolderFetchTest {

    private static String SETUP_WORKSPACE_NAME = 'ScaryShark Workspace';

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
            ContentFolderFetch cffetch = new ContentFolderFetch();
            ContentFolder cf = cffetch.fetch('Not exist');
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
            ContentFolderFetch cffetch = new ContentFolderFetch();
            ContentFolder cf = cffetch.fetch('');
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

        String cfName = 'Folder of d00m';

        ContentFolder cf = new ContentFolder(Name=cfName);

        Database.insert(cf);

        Test.startTest();
        
        ContentFolderFetch cffetch = new ContentFolderFetch();
        ContentFolder actualCf = cffetch.fetch(cfName);
        
        Test.stopTest();

        String expectedName = cfName;
        String actualName = actualCf.Name;
        System.Assert(actualName == expectedName, TestLog.makeTestErrorMessage(expectedName,actualName));
    }
    
}
