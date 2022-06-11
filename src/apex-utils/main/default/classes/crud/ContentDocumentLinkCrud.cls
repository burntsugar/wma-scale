public class ContentDocumentLinkCrud {
    
    private final static String CONTENTDOCUMENTLINK_NAME = 'ContentDocumentLink';

    public enum Selectors {
        ID,
        LINKEDENTITYID
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentDocumentLink record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentFolder    ContentFolder instance from which to create the record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void insertContentDocumentLink(ContentDocumentLink contentDocumentLink){
        DBCrud.doInsert(contentDocumentLink);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentDocumentLink record.
    *
    * See https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_contentdocumentlink.htm
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentDocumentId    String. contentDocumentId belonging to the related document - such as a ContentVersion.
    * @param    linkedEntityId    String. Id of the linked record - such as a ContentWorkspace.
    * @param    shareType    String. The permission granted to the user of the shared file in a 
    * library. V (Viewer permission), C (Collaborator permission), I (Inferred Permission).
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static ContentDocumentLink insertContentDocumentLink(String contentDocumentId, String linkedEntityId, String shareType){
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = contentDocumentId;
        cdl.LinkedEntityId = linkedEntityId; 
        cdl.ShareType = shareType; 

        DBCrud.doInsert(cdl);

        return cdl;
    }

        /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentDocumentLink records.
    * REQUIRES 'Query all files' permission.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    Selectors. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentDocumentLink> getContentDocumentLink(Selectors fieldName, String fieldValue) {
        String sObjectName = CONTENTDOCUMENTLINK_NAME;
        String fields = 'Id, ContentDocumentId, LinkedEntityId, ShareType';
        String whereCriteria = makeExpression(fieldName, fieldValue);
        List<ContentDocumentLink> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

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
            when LINKEDENTITYID {
                slctor = 'LinkedEntityId';
            }
        }
        return slctor;
    }

    private static String makeExpression(Selectors selector, String value){
        String expression;
        switch on selector {
            when ID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
            when LINKEDENTITYID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
    
}
