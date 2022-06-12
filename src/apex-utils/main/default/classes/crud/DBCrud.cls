public class DBCrud {

     /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a sObject record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    record    sObject instance from which to create a record.
    * @return   Database.SaveResult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult doInsert(SObject record) {
        Database.SaveResult sr = Database.insert(record);
        return sr;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates sObject records from a list.
    * Allows partial insert to succeed.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    records    List<SObject> containing instances from which to create records.
    * @return   Database.SaveResult[]
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult[] doInsert(List<SObject> records) {
        Database.SaveResult[] sr = Database.insert(records, false);
        return sr;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Updates a sObject record.
    * Allows partial update to succeed.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    record    sObject instance from which to update a record.
    * @return   Database.SaveResult
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult doUpdate(SObject record) {
        Database.SaveResult sr = Database.update(record, false);
        return sr;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Updates a list of sObject record.
    * Allows partial update to succeed.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    records    List<sObject> instance records to update.
    * @return   Database.SaveResult[]
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static Database.SaveResult[] doUpdate(List<SObject> records) {
        Database.SaveResult[] sr = Database.update(records, false);
        return sr;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieve a sObject record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    sObjectName    String. The sObject name to query.
    * @param    fields    String. Comma-separated field names to return in results.
    * @param    whereCriteria    String. WHERE criteria. 
    * @param    additionalCriteria    String. Additional ORDERBY, LIMIT criteria. 
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<sObject> doSelect(String sObjectName, String fields, String whereCriteria, String additionalCriteria) {
        String strSOQL = 'SELECT ' + fields + ' FROM ' + sObjectName;
        if ( !String.isBlank(whereCriteria) ) strSOQL += ' WHERE ' + whereCriteria;
        if ( !String.isBlank(additionalCriteria) ) strSOQL += ' ' + additionalCriteria;
        return doSelect(strSOQL);
    }

    private static List<sObject> doSelect(String soqlQuery) {
        List<sObject> results = Database.Query(soqlQuery);
        return results;
    }
}


// public class DBCrud {

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates a sObject record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    record    sObject instance from which to create a record.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static void doInsert(SObject record) {
//         insert(record);
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Creates sObject records from a list.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    records    List<SObject> containing instances from which to create records.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static void doInsert(List<SObject> records) {
//         insert(records);
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Updates a sObject record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    record    sObject instance from which to update a record.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static void doUpdate(SObject record) {
//         update(record);
//     }

//         /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Updates a list of sObject record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    records    List<sObject> instance records to update.
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static void doUpdate(List<SObject> records) {
//         update(records);
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * Retrieve a sObject record.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     * @param    sObjectName    String. The sObject name to query.
//     * @param    fields    String. Comma-separated field names to return in results.
//     * @param    whereCriteria    String. WHERE criteria. 
//     * @param    additionalCriteria    String. Additional ORDERBY, LIMIT criteria. 
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
//     */
//     public static List<sObject> doSelect(String sObjectName, String fields, String whereCriteria, String additionalCriteria) {
//         String strSOQL = 'SELECT ' + fields + ' FROM ' + sObjectName;
//         if ( !String.isBlank(whereCriteria) ) strSOQL += ' WHERE ' + whereCriteria;
//         if ( !String.isBlank(additionalCriteria) ) strSOQL += ' ' + additionalCriteria;
//         return doSelect(strSOQL);
//     }

//     private static List<sObject> doSelect(String soqlQuery) {
//         List<sObject> results = Database.Query(soqlQuery);
//         return results;
//     }
// }
