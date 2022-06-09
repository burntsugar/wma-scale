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

    private static List<sObject> doSelect(String sObjectName, String fields, String criteria) {

        String strSOQL = 'SELECT ' + fields + ' FROM ' + sObjectName + ' WHERE ' + criteria;
        List<sObject> results = Database.Query(strSOQL);
        return results;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Retrieves sObject records.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    sObjectName    String. Name of sObject.
    * @param    fields    List<String>. List of fields to retrieve.
    * @param    criteriaExpressions    List<CriteriaExpression>. List of WHERE criteria expressions.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static List<sObject> doSelect(String sObjectName, List<String> fields, List<CriteriaExpression> criteriaExpressions) {

        String flds = String.join(fields, ',');
        List<String> critExps = new List<String>();
        for (CriteriaExpression ce : criteriaExpressions){
            critExps.add(ce.getCriteriaExpression());
        }
        String exps = String.join(critExps, ' ');

        List<sObject> results = doSelect(sObjectName, flds, exps);
        
        return results;
    }


}
