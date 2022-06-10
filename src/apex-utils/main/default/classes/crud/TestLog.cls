public class TestLog {
    
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

    public static String makeTestErrorMessage(String expected, String actual){ 
        return 'Expected ' + expected + ' but got ' + actual;
    }  
}
