@isTest public class DBCrudTest {

    private final static String ACCOUNT_NAME = 'Sabrina Albright ' + 'XYZ';
    private final static String ACCOUNT_DESCRIPTION = 'Sabrina has a RAD account';
    private final static Integer ACCOUNT_NUMBER_OF_EMPLOYEES = 1500;

    @TestSetup
    static void makeData(){
        Account account = new Account(Name=ACCOUNT_NAME, Description=ACCOUNT_DESCRIPTION, NumberOfEmployees=ACCOUNT_NUMBER_OF_EMPLOYEES);
        insert account;
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a null object is passed, a NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_NullObject_NullPointerException(){

        sObject o = null;
        String expectedType = NullPointerException.class.getName();
        boolean doesThrow;

        Test.startTest();

        try {
            DBCrud.doInsert(o);
            doesThrow = false;
        } catch (NullPointerException npe) {
            doesThrow = true;
        }

        Test.stopTest();

        System.Assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When a valid object is passed, a record is created.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_ValidObject_RecordId(){
        Account account = new Account(Name='Test Account');

        Test.startTest();

        Database.SaveResult sr = DBCrud.doInsert(account);
        
        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
     * When null object list is passed, NullPointerException is thrown.
     * ────────────────────────────────────────────────────────────────────────────────────────────────
     */
    @isTest static void doInsert_NullList_NullPointerException() {

        List<Account> accountList;
        String expectedType = NullPointerException.class.getName();
        boolean doesThrow;

        Test.startTest();

        try {
            DBCrud.doInsert(accountList);
            doesThrow = false;
        } catch (NullPointerException npe) {
            doesThrow = true;
        }
        
        Test.stopTest();

        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null object in list is passed, ListException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_NullObjectInList_ListException() {

        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Dhamitha Ramachandran'));
        accountList.add(null);
        boolean doesThrow;

        Test.startTest();

        try {
            DBCrud.doInsert(accountList);
            doesThrow = false;
        } catch (ListException le) {
            doesThrow = true;
        }
        
        Test.stopTest();

        String expectedType = ListException.class.getName();
        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When required value is blank in object in list, SaveResult contains DMLException error code 
    * System.StatusCode.REQUIRED_FIELD_MISSING.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_NullRequiredAttributeInObjectInList_DMLException() {

        String nullString = null;
        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name=nullString));

        Test.startTest();

        Database.SaveResult[] sr = DBCrud.doInsert(accountList);
        
        Test.stopTest();

        Integer expectedErrorListSize = 1;
        System.StatusCode expectedStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

        Integer actualErrorListSize = sr.get(0).getErrors().size();
        System.StatusCode actualStatusCode = sr.get(0).getErrors().get(0).getStatusCode();

        System.assert( expectedErrorListSize == actualErrorListSize, TestLog.makeTestErrorMessage('error list size', expectedErrorListSize, actualErrorListSize) );
        System.assert( expectedStatusCode == actualStatusCode, TestLog.makeTestErrorMessage(sr) );
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When valid object list is passed, Record is updated.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doInsert_ValidObjectRecordList_RecordsCreated() {

        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Dhamitha Ramachandran'));
        accountList.add(new Account(Name='Nancy Botwin'));

        Test.startTest();

        Database.SaveResult[] sr = DBCrud.doInsert(accountList);

        Boolean isSuccess = true;
        for (Database.SaveResult s: sr) {
            if(!s.isSuccess()) {
                isSuccess = false;
                break;
            }
        }

        Test.stopTest();

        System.assert(isSuccess, TestLog.makeTestErrorMessage(sr));
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
        boolean doesThrow = false;

        Test.startTest();

        try {
            List<Account> result = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);
        } catch (QueryException qe) {
            doesThrow = true;
        }

        Test.stopTest();

        String expectedType = QueryException.class.getName();
        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
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

        Integer actualSizeOfResult = result.size();
        String actualAccountName = result.get(0).Name;
        Integer actualNumberOfEmployees = result.get(0).NumberOfEmployees;


        System.Assert(expectedSizeOfResult == actualSizeOfResult, TestLog.makeTestErrorMessage(expectedSizeOfResult, actualSizeOfResult));
        System.Assert(expectedAccountName == actualAccountName, TestLog.makeTestErrorMessage(expectedAccountName, actualAccountName));
        System.Assert(expectedNumberOfEmployees == actualNumberOfEmployees, TestLog.makeTestErrorMessage(expectedNumberOfEmployees, actualNumberOfEmployees));
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

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When valid object is passed, Record is updated.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_ValidObjectRecord_RecordUpdated() {
        String accountName = 'Dhamitha Ramachandran';
        Account account = new Account(Name=accountName);
        insert account;

        String expectedAccountName = 'Damitha Ramachandran';
        account.Name = expectedAccountName;

        Test.startTest();

        Database.SaveResult sr = DBCrud.doUpdate(account);

        Test.stopTest();

        System.Assert(sr.isSuccess(), TestLog.makeTestErrorMessage(sr));
   }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null object is passed, NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_NullObjectRecord_NullPointerException() {
        Account account;
        boolean doesThrow = false;

        Test.startTest();

        try {
            DBCrud.doUpdate(account);
        } catch (NullPointerException npe) {
            doesThrow = true;
        }
        
        Test.stopTest();

        String expectedType = NullPointerException.class.getName();
        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When required field is blank, DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_RequiredFieldBlank_DMLException() {
        String nullString = null;
        Account account = new Account(Name='Dhamitha Ramachandran');
        insert(account);

        account.Name = nullString;

        Test.startTest();

        Database.SaveResult sr = DBCrud.doUpdate(account);
        
        Test.stopTest();

        System.assert(sr.isSuccess() == false);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null object list is passed, NullPointerException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_NullList_NullPointerException() {

        List<Account> accountList;
        boolean doesThrow = false;

        Test.startTest();

        try {
            DBCrud.doUpdate(accountList);
        } catch (NullPointerException npe) {
            doesThrow = true;
        }
        
        Test.stopTest();

        String expectedType = NullPointerException.class.getName();
        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When null object in list is passed, ListException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_NullObjectInList_ListException() {

        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Dhamitha Ramachandran'));
        insert(accountList);

        accountList.add(null);
        boolean doesThrow = false;

        Test.startTest();

        try {
            DBCrud.doUpdate(accountList);
        } catch (ListException le) {
            doesThrow = true;
        }
        
        Test.stopTest();

        String expectedType = NullPointerException.class.getName();
        System.assert(doesThrow, TestLog.makeTestErrorMessage(expectedType));
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When required value is null in object in list, DMLException is thrown.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_NullRequiredAttributeInObjectInList_DMLException() {

        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Dhamitha Ramachandran'));
        insert(accountList);

        String nullString = null;
        accountList.get(0).Name = nullString;

        Test.startTest();

        Database.SaveResult[] sr = DBCrud.doUpdate(accountList);
        
        Test.stopTest();

        Integer expectedErrorListSize = 1;
        System.StatusCode expectedStatusCode = System.StatusCode.REQUIRED_FIELD_MISSING;

        Integer actualErrorListSize = sr.get(0).getErrors().size();
        System.StatusCode actualStatusCode = sr.get(0).getErrors().get(0).getStatusCode();

        System.assert( expectedErrorListSize == actualErrorListSize, TestLog.makeTestErrorMessage('error list size', expectedErrorListSize, actualErrorListSize) );
        System.assert( expectedStatusCode == actualStatusCode, TestLog.makeTestErrorMessage(sr) );
    }


    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * When valid object list is passed, Record is updated.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    */
    @isTest static void doUpdate_ValidObjectRecordList_RecordsUpdated() {

        List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='Dhamitha Ramachandran'));
        accountList.add(new Account(Name='Nancy Botwin'));
        insert(accountList);

        for (Account a :accountList){
            a.name += 'x';
        }

        Test.startTest();

        Database.SaveResult[] sr = DBCrud.doUpdate(accountList);

        Test.stopTest();

        Boolean isSuccess = true;
        for (Database.SaveResult s: sr) {
            if(!s.isSuccess()) {
                isSuccess = false;
                break;
            }
        }
        System.assert(isSuccess, TestLog.makeTestErrorMessage(sr));
    }
}

// @isTest public class DBCrudTest {

//     private final static String ACCOUNT_NAME = 'Sabrina Albright ' + 'XYZ';
//     private final static String ACCOUNT_DESCRIPTION = 'Sabrina has a RAD account';
//     private final static Integer ACCOUNT_NUMBER_OF_EMPLOYEES = 1500;

//     @TestSetup
//     static void makeData(){
//         Account account = new Account(Name=ACCOUNT_NAME,Description=ACCOUNT_DESCRIPTION,NumberOfEmployees=ACCOUNT_NUMBER_OF_EMPLOYEES);
//         insert account;
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When a null object is passed, a NullPointerException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doInsert_NullObject_NullPointerException(){
//         sObject o = null;
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//         DBCrud.doInsert(o);
//         } catch (NullPointerException npe) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When a valid object is passed, a record is created.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doInsert_ValidObject_RecordId(){
//         Account account = new Account(Name='Test Account');

//         Test.startTest();
//         DBCrud.doInsert(account);
//         Test.stopTest();

//         System.Assert(account.Id != null, TestLog.makeTestErrorMessage('Record Id', 'null'));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * For records, when null parts are passed, QueryException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doSelect_NullParts_QueryException() {
//         String sObjectName = null;
//         String fields = null;
//         String whereCriteria = null;
//         boolean doesThrowExc = false;

//         Test.startTest();
//         try {
//             List<Account> result = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);
//         } catch (QueryException qe) {
//             doesThrowExc = true;
//         }
//         Test.stopTest();

//         Boolean expected = true;
//         System.Assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }


//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * For a matching record, when WHERE criteria is passed, the matching record is retrieved.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doSelect_WhereCriteria_1MatchingRecord() {
//         String sObjectName = 'Account';
//         String fields = 'Id, Name, Description, NumberOfEmployees';
//         String whereCriteria = 'Name=\'' + ACCOUNT_NAME + '\' AND NumberOfEmployees=' + ACCOUNT_NUMBER_OF_EMPLOYEES;

//         Test.startTest();
//         List<Account> result = DBCrud.doSelect(sObjectName, fields, whereCriteria, null);
//         Test.stopTest();

//         Integer expectedSizeOfResult = 1;
//         String expectedAccountName = ACCOUNT_NAME;
//         Integer expectedNumberOfEmployees = ACCOUNT_NUMBER_OF_EMPLOYEES;
//         System.Assert(result.size() == expectedSizeOfResult, TestLog.makeTestErrorMessage(expectedSizeOfResult, result.size()));
//         System.Assert(result.get(0).Name == expectedAccountName, TestLog.makeTestErrorMessage(expectedAccountName, result.get(0).Name));
//         System.Assert(result.get(0).NumberOfEmployees == expectedNumberOfEmployees, TestLog.makeTestErrorMessage(expectedNumberOfEmployees, result.get(0).NumberOfEmployees));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * For records, when LIMIT criteria is passed, 1 record is retrieved.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doSelect_Limit_1() {
//         String sObjectName = 'Account';
//         String fields = 'Id, Name, Description';
//         String additionalCriteria = 'LIMIT 1';

//         Test.startTest();
//         List<Account> result = DBCrud.doSelect(sObjectName, fields, null, additionalCriteria);
//         Test.stopTest();

//         Integer expectedSizeOfResult = 1;
//         System.Assert(result.size() == expectedSizeOfResult, TestLog.makeTestErrorMessage(expectedSizeOfResult, result.size()));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When valid object is passed, Record is updated.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_ValidObjectRecord_RecordUpdated() {
//         String accountName = 'Dhamitha Ramachandran';
//         Account account = new Account(Name=accountName);
//         insert account;

//         String expectedAccountName = 'Damitha Ramachandran';
//         account.Name = expectedAccountName;

//         Test.startTest();

//         DBCrud.doUpdate(account);
//         Account actualAccount = [SELECT Id, Name FROM Account WHERE Id =:account.Id];

//         Test.stopTest();

//         System.assert(actualAccount.Name == expectedAccountName, TestLog.makeTestErrorMessage(expectedAccountName, actualAccount.Name));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When null object is passed, NullPointerException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_NullObjectRecord_NullPointerException() {
//         Account account;
//         boolean doesThrowExc = false;

//         Test.startTest();

//         try {
//             DBCrud.doUpdate(account);
//         } catch (NullPointerException npe) {
//             doesThrowExc = true;
//         }
        
//         Test.stopTest();

//         boolean expected = true;
//         System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When required field is blank, DMLException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_RequiredFieldBlank_DMLException() {
//         String nullString = null;
//         Account account = new Account(Name='Dhamitha Ramachandran');
//         insert(account);

//         account.Name = nullString;

//         boolean doesThrowExc = false;

//         Test.startTest();

//         try {
//             DBCrud.doUpdate(account);
//         } catch (DMLException dmle) {
//             doesThrowExc = true;
//         }
        
//         Test.stopTest();

//         boolean expected = true;
//         System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When null object list is passed, NullPointerException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_NullList_NullPointerException() {

//         List<Account> accountList;
//         boolean doesThrowExc = false;

//         Test.startTest();

//         try {
//             DBCrud.doUpdate(accountList);
//         } catch (NullPointerException npe) {
//             doesThrowExc = true;
//         }
        
//         Test.stopTest();

//         boolean expected = true;
//         System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When null object in list is passed, ListException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_NullObjectInList_ListException() {

//         List<Account> accountList = new List<Account>();
//         accountList.add(new Account(Name='Dhamitha Ramachandran'));
//         insert(accountList);

//         accountList.add(null);
//         boolean doesThrowExc = false;

//         Test.startTest();

//         try {
//             DBCrud.doUpdate(accountList);
//         } catch (ListException le) {
//             doesThrowExc = true;
//         }
        
//         Test.stopTest();

//         boolean expected = true;
//         System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }

//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When required value is null in object in list, DMLException is thrown.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_NullRequiredAttributeInObjectInList_DMLException() {

//         List<Account> accountList = new List<Account>();
//         accountList.add(new Account(Name='Dhamitha Ramachandran'));
//         insert(accountList);

//         String nullString = null;

//         accountList.get(0).Name = nullString;
//         boolean doesThrowExc = false;

//         Test.startTest();

//         try {
//             DBCrud.doUpdate(accountList);
//         } catch (DMLException dmle) {
//             doesThrowExc = true;
//         }
        
//         Test.stopTest();

//         boolean expected = true;
//         System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
//     }


//     /**
//     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//     * When valid object list is passed, Record is updated.
//     * ────────────────────────────────────────────────────────────────────────────────────────────────
//     */
//     @isTest static void doUpdate_ValidObjectRecordList_RecordsUpdated() {

//         List<Account> accountList = new List<Account>();
//         accountList.add(new Account(Name='Dhamitha Ramachandran'));
//         accountList.add(new Account(Name='Nancy Botwin'));
//         insert(accountList);

//         List<String> ids = new List<String>();
//         for (Account a :accountList){
//             a.name += 'x';
//             ids.add(a.Id);
//         }

//         boolean updated = true;

//         Test.startTest();

//         DBCrud.doUpdate(accountList);

//         List<Account> actualAccountResults = [SELECT Id, Name FROM Account WHERE Id in :ids];

//         Integer count = 0;
//         for (Account actualAccount : actualAccountResults) {
//             if (actualAccount.Name != accountList.get(count).Name) {
//                 updated = false;
//                 break;
//             }
//             count ++;
//         }

//         Test.stopTest();

//         boolean expected = true;
//         System.assert(updated == expected, TestLog.makeTestErrorMessage(expected, updated));
//     }

//     ///

// /**
//  * ───────────────────────────────────────────────────────────────────────────────────────────────┐
//  * When null object list is passed, NullPointerException is thrown.
//  * ────────────────────────────────────────────────────────────────────────────────────────────────
//  */
// @isTest static void doInsert_NullList_NullPointerException() {

//     List<Account> accountList;
//     boolean doesThrowExc = false;

//     Test.startTest();

//     try {
//         DBCrud.doInsert(accountList);
//     } catch (NullPointerException npe) {
//         doesThrowExc = true;
//     }
    
//     Test.stopTest();

//     boolean expected = true;
//     System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
// }



// /**
// * ───────────────────────────────────────────────────────────────────────────────────────────────┐
// * When null object in list is passed, ListException is thrown.
// * ────────────────────────────────────────────────────────────────────────────────────────────────
// */
// @isTest static void doInsert_NullObjectInList_ListException() {

//     List<Account> accountList = new List<Account>();
//     accountList.add(new Account(Name='Dhamitha Ramachandran'));
//     accountList.add(null);
//     boolean doesThrowExc = false;

//     Test.startTest();

//     try {
//         DBCrud.doInsert(accountList);
//     } catch (ListException le) {
//         doesThrowExc = true;
//     }
    
//     Test.stopTest();

//     boolean expected = true;
//     System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
// }

// /**
// * ───────────────────────────────────────────────────────────────────────────────────────────────┐
// * When required value is null in object in list, DMLException is thrown.
// * ────────────────────────────────────────────────────────────────────────────────────────────────
// */
// @isTest static void doInsert_NullRequiredAttributeInObjectInList_DMLException() {

//     String nullString = null;

//     List<Account> accountList = new List<Account>();
//     accountList.add(new Account(Name=nullString));

//     boolean doesThrowExc = false;

//     Test.startTest();

//     try {
//         DBCrud.doInsert(accountList);
//     } catch (DMLException dmle) {
//         doesThrowExc = true;
//     }
    
//     Test.stopTest();

//     boolean expected = true;
//     System.assert(doesThrowExc == expected, TestLog.makeTestErrorMessage(expected, doesThrowExc));
// }

// /**
// * ───────────────────────────────────────────────────────────────────────────────────────────────┐
// * When valid object list is passed, Record is updated.
// * ────────────────────────────────────────────────────────────────────────────────────────────────
// */
// @isTest static void doInsert_ValidObjectRecordList_RecordsCreated() {

//     List<Account> accountList = new List<Account>();
//     accountList.add(new Account(Name='Dhamitha Ramachandran'));
//     accountList.add(new Account(Name='Nancy Botwin'));

//     List<String> names = new List<String>();
//     for (Account a :accountList){
//         names.add(a.Name);
//     }

//     Test.startTest();

//     DBCrud.doInsert(accountList);

//     List<Account> actualAccountResults = [SELECT Id, Name FROM Account WHERE Name in :names];

//     Test.stopTest();

//     Integer expected = names.size();
//     System.assert(expected == actualAccountResults.size(), TestLog.makeTestErrorMessage(expected, actualAccountResults.size()));
// }

// }