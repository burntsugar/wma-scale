public class DBCrud {

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a sObject record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    record    sObject instance from which to create a record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void doInsert(SObject record) {
        insert(record);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Updates a sObject record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    record    sObject instance from which to update a record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void doUpdate(SObject record) {
        update(record);
    }

        /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Updates a list of sObject record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    records    List<sObject> instance records to update.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void doUpdate(List<SObject> records) {
        update(records);
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


 // /**
    // * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    // * Retrieves sObject records.
    // * ────────────────────────────────────────────────────────────────────────────────────────────────
    // * @param    sObjectName    String. Name of sObject.
    // * @param    fields    List<String>. List of fields to retrieve.
    // * @param    criteriaExpressions    List<CriteriaExpression>. List of WHERE criteria expressions.
    // * @return List<sObject> sObject records.
    // * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    // */
    // public static List<sObject> doSelect(String sObjectName, List<String> fields, List<CriteriaExpression> criteriaExpressions) {

    //     String flds = String.join(fields, ',');
    //     List<String> critExps = new List<String>();
    //     for (CriteriaExpression ce : criteriaExpressions){
    //         critExps.add(ce.getCriteriaExpression());
    //     }
    //     String exps = String.join(critExps, ' ');

    //     List<sObject> results = doSelect(sObjectName, flds, exps);

    //     return results;
    // }
