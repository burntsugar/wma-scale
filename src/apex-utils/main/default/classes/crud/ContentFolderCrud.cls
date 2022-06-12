public without sharing class ContentFolderCrud {
    
    private final static String CONTENTFOLDER_NAME = 'ContentFolder';

    public enum Selectors {
        ID,
        NAME
    }

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
    * @param    fieldName    Selectors. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentFolder> getContentFolder(Selectors fieldName, String fieldValue) {
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
            when NAME {
                slctor = 'Name';
            }
        }
        return slctor;
    }

    private static String makeExpression(Selectors selector, String value){
        String expression;
        switch on selector {
            when ID, NAME {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
}


// public class ContentFolderCrud {
    
//     private final static String CONTENTFOLDER_NAME = 'ContentFolder';

//     public enum Selectors {
//         ID,
//         NAME
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates a ContentFolder record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    contentFolder    ContentFolder instance from which to create the record.
//     * @return Database.SaveResult
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static Database.SaveResult insertContentFolder(ContentFolder contentFolder){
//         Database.SaveResult sr = DBCrud.doInsert(contentFolder);
//         return sr;
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates a ContentFolder record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    name    String. Name of the ContentFolder.
//     * @param    parentContentFolderId    String. Id of the parent ContentFolder - which may be a workspace.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static ContentFolder insertContentFolder(String contentFolderName, String parentContentFolderId){
//         ContentFolder contentFolder = new ContentFolder(Name=contentFolderName, ParentContentFolderId=parentContentFolderId);
//         DBCrud.doInsert(contentFolder);

//         return contentFolder;
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Retrieve ContentFolder records.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    fieldName    Selectors. Field name selector.
//     * @param    fieldValue    String. Field value.
//     * @return    List<ContentVersion> matching records.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static List<ContentFolder> getContentFolder(Selectors fieldName, String fieldValue) {
//         String sObjectName = CONTENTFOLDER_NAME;
//         String fields = 'Id, Name';
//         String whereCriteria = makeExpression(fieldName, fieldValue);
//         List<ContentFolder> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

//         return results;
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Get string value for a given selector.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    selector    Selectors. Field name selector.
//     * @return    String value for selector.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static String getSelector(Selectors selector) {
//         String slctor;
//         switch on selector {
//             when ID {
//                 slctor = 'Id';
//             }
//             when NAME {
//                 slctor = 'Name';
//             }
//         }
//         return slctor;
//     }

//     private static String makeExpression(Selectors selector, String value){
//         String expression;
//         switch on selector {
//             when ID, NAME {
//                 expression = getSelector(selector) + '=' + '\'' + value + '\'';
//             }
//         }
//         return expression;
//     }
// }
