public without sharing class ContentDocumentLinkCrud implements IContentDocumentLinkCrud{
    
    private final static String CONTENTDOCUMENTLINK_NAME = 'ContentDocumentLink';

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentDocumentLink record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentFolder    ContentFolder instance from which to create the record.
    * @return Database.Saveresult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.Saveresult insertContentDocumentLink(ContentDocumentLink contentDocumentLink){
        Database.Saveresult sr = DBCrud.doInsert(contentDocumentLink);
        return sr;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentDocumentLink records.
    * REQUIRES 'Query all files' permission.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    ContentDocumentLinkFieldSelectors enum. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentDocumentLink> getContentDocumentLink(ContentDocumentLinkFieldSelectors fieldName, String fieldValue) {
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
    * @param    selector    ContentDocumentLinkFieldSelectors enum. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(ContentDocumentLinkFieldSelectors selector) {
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

    private static String makeExpression(ContentDocumentLinkFieldSelectors selector, String value){
        String expression;
        switch on selector {
            when ID, LINKEDENTITYID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
}