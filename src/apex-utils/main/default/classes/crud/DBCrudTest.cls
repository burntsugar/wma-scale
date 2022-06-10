@isTest public class DBCrudTest {

    private final static String ACCOUNT_NAME = 'Sabrina Albright ' + 'XYZ';
    private final static String ACCOUNT_DESCRIPTION = 'Sabrina has a RAD account';
    private final static Integer ACCOUNT_NUMBER_OF_EMPLOYEES = 1500;

    @TestSetup
    static void makeData(){
        Account account = new Account(Name=ACCOUNT_NAME,Description=ACCOUNT_DESCRIPTION,NumberOfEmployees=ACCOUNT_NUMBER_OF_EMPLOYEES);
        insert account;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a null object is passed, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
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

        boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a valid object is passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_ValidObject_RecordId(){
        Account account = new Account(Name='Test Account');

        Test.startTest();
        DBCrud.doInsert(account);
        Test.stopTest();

        System.Assert(account.Id != null, TestLog.makeTestErrorMessage('Record Id', 'null'));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * For records, when null parts are passed, QueryException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doSelect_NullParts_QueryException() {
        String sObjectName = null;
        String fields = null;
        String whereCriteria = null;
        boolean doesThrowExc = false;

        Test.startTest();
        try {
            List<Account> result = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);
        } catch (QueryException qe) {
            doesThrowExc = true;
        }
        Test.stopTest();

        Boolean expected = true;
        System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
    }


    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * For a matching record, when WHERE criteria is passed, the matching record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doSelect_WhereCriteria_1MatchingRecord() {
        String sObjectName = 'Account';
        String fields = 'Id, Name, Description, NumberOfEmployees';
        String whereCriteria = 'Name=\'' + ACCOUNT_NAME + '\' AND NumberOfEmployees=' + ACCOUNT_NUMBER_OF_EMPLOYEES;

        Test.startTest();
        List<Account> result = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);
        Test.stopTest();

        Integer expectedSizeOfResult = 1;
        String expectedAccountName = ACCOUNT_NAME;
        Integer expectedNumberOfEmployees = ACCOUNT_NUMBER_OF_EMPLOYEES;
        System.Assert(result.size() == expectedSizeOfResult, TestLog.makeTestErrorMessage(expectedSizeOfResult, result.size()));
        System.Assert(result.get(0).Name == expectedAccountName, TestLog.makeTestErrorMessage(expectedAccountName, result.get(0).Name));
        System.Assert(result.get(0).NumberOfEmployees == expectedNumberOfEmployees, TestLog.makeTestErrorMessage(expectedNumberOfEmployees, result.get(0).NumberOfEmployees));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * For records, when LIMIT criteria is passed, 1 record is retrieved.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doSelect_Limit_1() {
        String sObjectName = 'Account';
        String fields = 'Id, Name, Description';
        String additionalCriteria = 'LIMIT 1';

        Test.startTest();
        List<Account> result = DBCrud.doSelect(sObjectName, fields, null, additionalCriteria);
        Test.stopTest();

        Integer expectedSizeOfResult = 1;
        System.Assert(result.size() == expectedSizeOfResult, TestLog.makeTestErrorMessage(expectedSizeOfResult, result.size()));
    }
}