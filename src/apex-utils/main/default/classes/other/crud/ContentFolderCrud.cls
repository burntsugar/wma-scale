public without sharing class ContentFolderCrud implements IContentFolderCrud{
    
    private final static String CONTENTFOLDER_NAME = 'ContentFolder';

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentFolder record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentFolder    ContentFolder instance from which to create the record.
    * @return Database.SaveResult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult insertContentFolder(ContentFolder contentFolder){
        Database.SaveResult sr = DBCrud.doInsert(contentFolder);
        return sr;
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentFolder records.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    ContentFolderFieldSelectors enum. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentFolder> getContentFolder(ContentFolderFieldSelectors fieldName, String fieldValue) {
        String sObjectName = CONTENTFOLDER_NAME;
        String fields = 'Id, Name';
        String whereCriteria = makeExpression(fieldName, fieldValue);
        List<ContentFolder> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

        return results;
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given selector.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    selector    ContentFolderFieldSelectors enum. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(ContentFolderFieldSelectors selector) {
        String slctor;
        switch on selector {
            when ID {
                slctor = 'Id';
            }
            when NAME {
                slctor = 'Name';
            }
        }
        return slctor;
    }

    private static String makeExpression(ContentFolderFieldSelectors selector, String value){
        String expression;
        switch on selector {
            when ID, NAME {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
}