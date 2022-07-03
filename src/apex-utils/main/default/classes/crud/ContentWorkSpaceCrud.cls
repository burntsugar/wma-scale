public without sharing class ContentWorkSpaceCrud implements IContentWorkSpaceCrud{

    private final static String CONTENTWORKSPACE_NAME = 'ContentWorkspace';

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentWorkspace record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentWorkspace    ContentWorkspace instance from which to create the record.
    * @return Database.SaveResult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult insertContentWorkspace(ContentWorkspace contentWorkspace){
        Database.SaveResult sr = DBCrud.doInsert(contentWorkspace);

        return sr;
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve ContentWorkspace records.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    fieldName    ContentWorkSpaceFieldSelectors enum. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentWorkspace> getContentWorkspace(ContentWorkSpaceFieldSelectors fieldName, String fieldValue) {
        String sObjectName = CONTENTWORKSPACE_NAME;
        String fields = 'Id, Name, Developername';
        String whereCriteria = makeExpression(fieldName, fieldValue);
        List<ContentWorkspace> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

        return results;
    }

     /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given selector.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    selector    ContentWorkSpaceFieldSelectors enum. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(ContentWorkSpaceFieldSelectors selector) {
        String slctor;
        switch on selector {
            when ID {
                slctor = 'Id';
            }
            when NAME {
                slctor = 'Name';
            }
            when DEVELOPERNAME {
                slctor = 'DeveloperName';
            }
        }
        return slctor;
    }

    private static String makeExpression(ContentWorkSpaceFieldSelectors selector, String value){
        String expression;
        switch on selector {
            when ID, NAME, DEVELOPERNAME {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
}