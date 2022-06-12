public without sharing class ContentWorkSpaceCrud {

    private final static String CONTENTWORKSPACE_NAME = 'ContentWorkspace';

    public enum Selectors {
        ID,
        NAME,
        DEVELOPERNAME
    }

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
    * @param    fieldName    Selectors. Field name selector.
    * @param    fieldValue    String. Field value.
    * @return    List<ContentVersion> matching records.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<ContentWorkspace> getContentWorkspace(Selectors fieldName, String fieldValue) {
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
            when DEVELOPERNAME {
                slctor = 'DeveloperName';
            }
        }
        return slctor;
    }

    private static String makeExpression(Selectors selector, String value){
        String expression;
        switch on selector {
            when ID, NAME, DEVELOPERNAME {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
    
}



// public class ContentWorkSpaceCrud {

//     private final static String CONTENTWORKSPACE_NAME = 'ContentWorkspace';

//     public enum Selectors {
//         ID,
//         NAME,
//         DEVELOPERNAME
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates a ContentWorkspace record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    contentWorkspace    ContentWorkspace instance from which to create the record.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static void insertContentWorkspace(ContentWorkspace contentWorkspace){

//         DBCrud.doInsert(contentWorkspace);
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates a ContentWorkspace record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    name    String. Name of the workspace.
//     * @param    developerName    String. Developer name of the workspace.
//     * @return    ContentWorkspace sObject record.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static ContentWorkspace insertContentWorkspace(String name, String developerName){
//         ContentWorkspace cw = new ContentWorkspace();
//         cw.Name = name;
//         cw.DeveloperName = developerName;

//         DBCrud.doInsert(cw);

//         return cw;
//     }

//     /**
//      * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Retrieve ContentWorkspace records.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    fieldName    Selectors. Field name selector.
//     * @param    fieldValue    String. Field value.
//     * @return    List<ContentVersion> matching records.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static List<ContentWorkspace> getContentWorkspace(Selectors fieldName, String fieldValue) {
//         String sObjectName = CONTENTWORKSPACE_NAME;
//         String fields = 'Id, Name, Developername';
//         String whereCriteria = makeExpression(fieldName, fieldValue);
//         List<ContentWorkspace> results = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);

//         return results;
//     }

//      /**
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
//             when DEVELOPERNAME {
//                 slctor = 'DeveloperName';
//             }
//         }
//         return slctor;
//     }

//     private static String makeExpression(Selectors selector, String value){
//         String expression;
//         switch on selector {
//             when ID, NAME, DEVELOPERNAME {
//                 expression = getSelector(selector) + '=' + '\'' + value + '\'';
//             }
//         }
//         return expression;
//     }
    
// }
