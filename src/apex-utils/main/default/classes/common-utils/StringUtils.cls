public without sharing class StringUtils {

    public static boolean stringIsNull(String s) {
        if(s==null)return true;
        
        return false;
    }

    public static boolean stringIsNull(List<String> strings) {
        for (String s: strings){
            if(s==null)return true;
        }

        return false;
    }

    public static boolean stringIsBlank(String s) {
        if(String.isBlank(s))return true;
        
        return false;
    }

    public static boolean stringIsBlank(List<String> strings) {
        for (String s: strings){
            if(String.isBlank(s))return true;
        }

        return false;
    }
}
