@isTest public class ContentVersionCreationTest {
    
    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter list contains all blanks, ContentException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_BlankParams_ContentException(){
        
        boolean doesThrow = false;
        
        Test.startTest();

        ContentVersionCreation cvc = new ContentVersionCreation();
        try {
            cvc.create('','');
        } catch (ContentException ce) {
            doesThrow = true;
        }
        
        Test.stopTest();
       
        System.Assert(doesThrow);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameter list contains 1 blanks, ContentException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_1BlankParams_ContentException(){
        
        boolean doesThrow = false;
        
        Test.startTest();

        ContentVersionCreation cvc = new ContentVersionCreation();
        try {
            cvc.create('test','');
        } catch (ContentException ce) {
            doesThrow = true;
        }
        
        Test.stopTest();
       
        System.Assert(doesThrow);
    }

   /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When parameters are valid, ContentVersion record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void create_ValidParams_RecordCreated(){
        
        boolean doesThrow = false;

        String title = 'test title';
        String content = 'test content';
        
        Test.startTest();

        ContentVersionCreation cvc = new ContentVersionCreation();
        ContentVersion cv = cvc.create(title, content);
        
        Test.stopTest();

        String actualTitle = cv.Title;
        String actualContent = cv.VersionData.toString();
       
        System.Assert(cv.Id != null,TestLog.makeTestErrorMessage('Record Id','null'));
        System.Assert(actualTitle.startsWith(title),TestLog.makeTestErrorMessage(title, actualTitle));
        System.Assert(content == actualContent,TestLog.makeTestErrorMessage(content, actualContent));
    }
}
