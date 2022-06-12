@isTest public class TestLog {
    
    public static String makeTestErrorMessage(String expected, Integer actual){ 
        return makeTestErrorMessage(expected, String.valueOf(actual));
    } 

    public static String makeTestErrorMessage(String expected, Boolean actual){ 
        return makeTestErrorMessage(expected, String.valueOf(actual));
    } 

    public static String makeTestErrorMessage(Boolean expected, Boolean actual){ 
        return makeTestErrorMessage(String.valueOf(expected), String.valueOf(actual));
    } 

    public static String makeTestErrorMessage(Integer expected, Integer actual){ 
        return makeTestErrorMessage(String.valueOf(expected), String.valueOf(actual));
    } 

    public static String makeTestErrorMessage(String descriptor, Integer expected, Integer actual){ 
        return makeTestErrorMessage(String.valueOf(expected + ' ' + descriptor), String.valueOf(actual)+ ' ' + descriptor);
    } 

    public static String makeTestErrorMessage(String descriptor, Integer expected, Integer actual, Database.SaveResult sr){ 
        return makeTestErrorMessage(String.valueOf(expected + ' ' + descriptor), String.valueOf(actual)+ ' ' + descriptor + ' ' + makeTestErrorMessage(sr));
    }

    public static String makeTestErrorMessage(String expected, String actual){ 
        return 'Expected ' + expected + ' but got ' + actual;
    }  

    public static String makeTestErrorMessage(String expected){ 
        return 'Expected ' + expected;
    } 

    public static String makeTestErrorMessage(Database.SaveResult[] sr){ 
        String str;
        for (Database.SaveResult s : sr) {
            str += 'Got ' + makeTestErrorMessage(s);
        }
        return str;
    } 

    public static String makeTestErrorMessage(Database.SaveResult sr){ 
        return 'Got ' + makeQRErrors(sr);
    }  

    private static String makeQRErrors(Database.SaveResult sr) {
        String ers;
        ers += 'The following errors occurred: ';   
        Integer count = 1;
        for (Database.Error er : sr.getErrors()) {         
            ers += count + ': ' + er.getStatusCode() + ': ' + er.getMessage();
            ers += ' - Account fields that affected this error: ' + er.getFields();
            count++;
        }
        return ers;
    }
}
