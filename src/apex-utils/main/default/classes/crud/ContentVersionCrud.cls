public class ContentVersionCrud {
    
    private final static String CONTENTVERSION_NAME = 'ContentVersion';

    public enum Selectors {
        ID,
        TITLE
    }

    public enum ContentLocations {
        S,
        E,
        L
    }

     /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentVersion record.
    * The record's ContentLocation defaults to S (Salesforce) unless specified by the object attribute.  
    * See https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_contentversion.htm
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentVersion    ContentVersion instance from which to create the record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void insertContentVersion(ContentVersion contentVersion){
        DBCrud.doInsert(contentVersion);
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentVersion record.
    * The record's ContentLocation defaults to S (Salesforce) unless specified by the object attribute.  
    * See https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_contentversion.htm
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentLocation    ContentLocations enum. Origin of the document. 'S' (Salesforce) default, 'E' (External) or 'L' (Social network).
    * @param    title    String. Title of the document.
    * @param    pathOnClient    String. The complete path of the document including the file extension.
    * @param    versionData    Blob. Content or body.
    * @return    ContentVersion sObject record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static ContentVersion insertContentVersion(ContentLocations contentLocation, String title, String pathOnClient, Blob versionData){
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = getContentLocation(contentLocation); 
        cv.Title = title; 
        cv.PathOnClient = pathOnClient;
        cv.VersionData = versionData;

        DBCrud.doInsert(cv);

        return cv;
    } 

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentVersion records.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    Selectors. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentVersion> getContentVersion(Selectors fieldName, String fieldValue) {
        String sObjectName = CONTENTVERSION_NAME;
        String fields = 'Id, Title, ContentDocumentId, PathOnClient, ContentLocation';
        String whereCriteria = makeExpression(fieldName, fieldValue);
        List<ContentVersion> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

        return results;
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given selector.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    selector    Selectors. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(Selectors selector) {
        String slctor;
        switch on selector {
            when ID {
                slctor = 'Id';
            }
            when TITLE {
                slctor = 'Title';
            }
        }
        return slctor;
    }

    private static String makeExpression(Selectors selector, String value){
        String expression;
        switch on selector {
            when ID, TITLE {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given contentLocation.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentLocation    ContentLocations enum. Field name selector.
    * @return    String value for contentLocation.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getContentLocation(ContentLocations contentLocation) {
        String cntLocation;
        switch on contentLocation{
            when S {
                cntLocation = 'S';
            }
            when E {
                cntLocation = 'E';
            }
            when L {
                cntLocation = 'L';
            }
        }
        return cntLocation;
    }
}
