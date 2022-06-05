@isTest public class StringUtilsTest {
    @isTest static void stringIsNull_Single_String_Is_Null() {
        String s;
        boolean expected = true;
        boolean actual = StringUtils.stringIsNull(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsNull_Single_String_Is_Not_Null() {
        String s = 'Not null';
        boolean expected = false;
        boolean actual = StringUtils.stringIsNull(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsNull_String_In_A_List_Is_Null() {
        String nullString;
        List<String> s = new List<String>{'not null', nullString};
        boolean expected = true;
        boolean actual = StringUtils.stringIsNull(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsNull_String_In_A_List_Is_Not_Null() {
        List<String> s = new List<String>{'not','null'};
        boolean expected = false;
        boolean actual = StringUtils.stringIsNull(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsBlank_Single_String_Is_Blank() {
        String s;
        boolean expected = true;
        boolean actual = StringUtils.stringIsBlank(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsBlank_Single_String_Is_Not_Blank() {
        String s = 'Not null';
        boolean expected = false;
        boolean actual = StringUtils.stringIsBlank(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsBlank_String_In_A_List_Is_Blank() {
        String nullString;
        List<String> s = new List<String>{'not null',' '};
        boolean expected = true;
        boolean actual = StringUtils.stringIsBlank(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }

    @isTest static void stringIsBlank_String_In_A_List_Is_Not_Blank() {
        String nullString;
        List<String> s = new List<String>{'not null','not null'};
        boolean expected = false;
        boolean actual = StringUtils.stringIsBlank(s);
        System.assert(expected == actual, 'Expected is ' + String.valueOf(expected) + ' but actual was ' + String.valueOf(actual));
    }
}
