@isTest public class DBCrudTest {

    private final static String ACCOUNT_NAME = 'Sabrina Albright';

    @TestSetup
    static void makeData(){
        Account account = new Account(Name=ACCOUNT_NAME);
        insert account;
    }

    @isTest static void doInsert_NullObject_NullPointerException(){
        sObject o = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
        DBCrud.doInsert(o);
        } catch (NullPointerException npe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        System.Assert(doesThrowExc, makeTestErrorMessage('true', 'false'));
    }

    @isTest static void doSelect() {
        String sObjectName = 'Account';
        List<String> fields = new List<String> {'Id', 'Name'};
        List<CriteriaExpression> criteriaExpressions = new List<CriteriaExpression>();
        CriteriaExpression ce = new CriteriaExpressionBuilder()
        .setFieldName('Name')
        .setFieldOperator(CriteriaExpression.FieldOperator.EQUALS_FIELD)
        .setfieldValue(ACCOUNT_NAME)
        .build();
        criteriaExpressions.add(ce);

        Test.startTest();
        List<sObject> results = DBCrud.doSelect(sObjectName, fields, criteriaExpressions);
        Test.stopTest();

        System.Assert(results != null);
        System.Assert(results.get(0) != null);
        System.Assert(results.get(0).Id != null);
    }

    public static String makeTestErrorMessage(String expected, String actual){
        return 'Expected ' + expected + ' but got ' + actual;
    }  
}
