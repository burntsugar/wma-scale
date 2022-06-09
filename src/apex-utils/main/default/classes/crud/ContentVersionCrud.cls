public class ContentVersionCrud {

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
    * @param    contentLocation    String. Origin of the document. 'S' (Salesforce), 'E' (External) or 'L' (Social network).
    * @param    title    String. Title of the document.
    * @param    pathOnClient    String. The complete path of the document including the file extension.
    * @param    versionData    Blob. Content or body.
    * @return    ContentVersion sObject record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static ContentVersion insertContentVersion(String contentLocation, String title, String pathOnClient, Blob versionData){
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = contentLocation; 
        cv.Title = title; 
        cv.PathOnClient = pathOnClient;
        cv.VersionData = versionData;

        DBCrud.doInsert(cv);

        return cv;
    }

    // private List<sObject> getSobject(String sObjectName, List<String> fields, List<CriteriaExpression> criteriaExpressions) {

    //     // doSelect(String sObjectName, String fields, String criteria
    //     List<String> critexp = String.join(criteriaExpressions, ',');
    //     List<sObject> results = DBCrud.doSelect(sObjectName, fields, critexp);
    //     return results;
    // }

        // public static List<sObject> doSelect(String sObjectName, List<String> fields, Map<String,String> criteria) {
    //     String flds = String.join(fields,',');
    //     String crit = String.join(criteria,',');
    //     List<sObject> results = [SELECT :flds FROM :sObjectName WHERE :]
    // }



    // public static ContentVersion getContentVersion(List<String> criteria) {
    //     ContentVersion cv = [SELECT ];
    //     return null;
    // }
    
}
