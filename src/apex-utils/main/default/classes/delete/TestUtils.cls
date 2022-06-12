@isTest public class TestUtils {

    public static ContentVersion insertContentVersion(String location, String title, String versionData, String fileExtension){
        ContentVersion cv = createContentVersionObject(location, title, versionData, fileExtension);
        insert cv;

        return cv;
    }

    public static ContentDocumentLink insertContentDocumentLink(String contentDocumentId, String linkedEntityId, String shareType) {

        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = contentDocumentId;
        cdl.LinkedEntityId = linkedEntityId; 
        cdl.ShareType = shareType; 
        insert cdl;

        return cdl;
    }

    public static ContentVersion createContentVersionObject(String location, String title, String versionData, String fileExtension){
        String documentTitle = title + '-' + Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');

        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = location; 
        cv.Title = documentTitle; 
        cv.PathOnClient = documentTitle + fileExtension;
        cv.VersionData = Blob.valueOf(versionData);

        return cv;
    }

    public static String makeTestErrorMessage(String expected, String actual){
        return 'Expected ' + expected + ' but got ' + actual;
    }
    
}
