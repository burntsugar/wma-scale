@isTest public class ContentDocumentlinkCreationTest {

    private static String SETUP_WORKSPACE_NAME = 'Amazing Gammaray Workspace';

    @testSetup static void createData() {
        ContentWorkspace cw = new ContentWorkspace(Name=SETUP_WORKSPACE_NAME);
        insert cw;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter list contains all blanks, ContentException is thrown on first blank paramter (ContentVersion).
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_BlankParams_ContentException_on_ContentVersion(){
        
        ContentVersion nullContentVersion;
        ContentWorkspace nullContentWorkspace;

        boolean doesThrow = false;
        
        Test.startTest();

        String actualErrorMessage;
        ContentDocumentlinkCreation contentDocumentLinkCreation = new ContentDocumentlinkCreation();
        try {
            contentDocumentLinkCreation.create(nullContentVersion,nullContentWorkspace);
        } catch (ContentException ce) {
            doesThrow = true;
            actualErrorMessage = ce.getMessage();
        }
        
        Test.stopTest();

        System.Assert(doesThrow);

        String expectedErrorMessage = ContentException.getErrorMessage(ContentException.errorMsg.QUERY_EX_MSG_INVALID_PARAMETERS);
        System.Assert(expectedErrorMessage == actualErrorMessage,TestLog.makeTestErrorMessage(actualErrorMessage, expectedErrorMessage));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter list contains blank ContentWorkspace, ContentException is thrown on second blank paramter (ContentWorkspace).
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_BlankContentWorkspace_ContentException_on_ContentWorkspace(){
        
        ContentVersion contentVersion = new ContentVersion(Title='CDL CV', PathOnClient='CDL CV.csv', VersionData=Blob.valueOf('CDL content'));
        Database.insert(contentVersion);

        ContentWorkspace nullContentWorkspace;

        boolean doesThrow = false;
        
        Test.startTest();

        String actualErrorMessage;
        ContentDocumentlinkCreation contentDocumentLinkCreation = new ContentDocumentlinkCreation();
        try {
            contentDocumentLinkCreation.create(contentVersion,nullContentWorkspace);
        } catch (ContentException ce) {
            doesThrow = true;
            actualErrorMessage = ce.getMessage();
        }
        
        Test.stopTest();

        System.Assert(doesThrow);

        String expectedErrorMessage = ContentException.getErrorMessage(ContentException.errorMsg.PARAMETERS_MSG_CONTENTWORKSPACE);
        System.Assert(expectedErrorMessage == actualErrorMessage,TestLog.makeTestErrorMessage(actualErrorMessage, expectedErrorMessage));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When ContentVersion does not exist, ContentException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_ContentVersionDoesNotExist_ContentException_on_ContenVersion(){
        
        ContentVersion contentVersion = new ContentVersion(Title='CDL CV', PathOnClient='CDL CV.csv', VersionData=Blob.valueOf('CDL content'));

        ContentWorkspace contentWorkSpace = [SELECT Id, Name FROM ContentWorkspace WHERE Name=:SETUP_WORKSPACE_NAME];

        boolean doesThrow = false;
        
        Test.startTest();

        String actualErrorMessage;
        ContentDocumentlinkCreation contentDocumentLinkCreation = new ContentDocumentlinkCreation();
        try {
            contentDocumentLinkCreation.create(contentVersion, contentWorkSpace );
        } catch (ContentException ce) {
            doesThrow = true;
            actualErrorMessage = ce.getMessage();
        }
        
        Test.stopTest();

        System.Assert(doesThrow);

        String expectedErrorMessage = ContentException.getErrorMessage(ContentException.errorMsg.QUERY_EX_MSG_INVALID_PARAMETERS);
        System.Assert(expectedErrorMessage == actualErrorMessage,TestLog.makeTestErrorMessage(actualErrorMessage, expectedErrorMessage));
    }
    

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When ContentWorkspace does not exist, ContentException is thrown.
    * Permission required to test this.
    ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameters are valid, ContentDocumentLink record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_ValidParams_RecordCreated() {

        ContentVersion contentVersion = new ContentVersion(Title='CDL CV', PathOnClient='CDL CV.csv', VersionData=Blob.valueOf('CDL content'));
        Database.insert(contentVersion);

        ContentWorkspace contentWorkSpace = [SELECT Id, Name FROM ContentWorkspace WHERE Name=:SETUP_WORKSPACE_NAME];

        Test.startTest();
        ContentDocumentlinkCreation contentDocumentLinkCreation = new ContentDocumentlinkCreation();

        contentDocumentLinkCreation.create(contentVersion, contentWorkSpace);

        Test.stopTest();

        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion.Id].ContentDocumentId;

        List<ContentDocumentLink> result = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId =:conDoc AND LinkedEntityId =: contentWorkSpace.Id];

        Integer expectedSize = 1;
        Integer actualSize = result.size();
        System.assert(expectedSize == actualSize,TestLog.makeTestErrorMessage(actualSize, expectedSize));
    }
}
