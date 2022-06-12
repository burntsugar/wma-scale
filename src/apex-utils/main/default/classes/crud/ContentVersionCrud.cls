public without sharing class ContentVersionCrud implements IContentVersionCrud{
    
    private final static String CONTENTVERSION_NAME = 'ContentVersion';

     /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentVersion record.
    * The record's ContentLocation defaults to S (Salesforce) unless specified by the object attribute.  
    * See https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_contentversion.htm
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentVersion    ContentVersion instance from which to create the record.
    * @return Database.SaveResult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult insertContentVersion(ContentVersion contentVersion){
        Database.SaveResult sr = DBCrud.doInsert(contentVersion);
        return sr;
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentVersion records.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    ContentVersionFieldSelectors enum. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentVersion> getContentVersion(ContentVersionFieldSelectors fieldName, String fieldValue) {
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
    * @param    selector    ContentVersionFieldSelectors enum. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(ContentVersionFieldSelectors selector) {
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

    private static String makeExpression(ContentVersionFieldSelectors selector, String value){
        String expression;
        switch on selector {
            when ID, TITLE {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
}