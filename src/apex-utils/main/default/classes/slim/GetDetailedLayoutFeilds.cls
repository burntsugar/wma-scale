public with sharing class GetDetailedLayoutFeilds {


    public static Map<String,List<String>> getDetailedLayout(Map<String,List<String>> fields, Map<String,Map<String,List<String>>> layoutFields){

        // field api name , attributes
         Map<String,List<String>> m = new Map<String,List<String>>();
 
         for (String rtName: layoutFields.keySet()){
             for (String layoutName: layoutFields.get(rtName).keyset()){
                 for (String fieldAPIName: layoutFields.get(rtName).get(layoutName)){
                     if (!m.containsKey(fieldAPIName)){
                         m.put(fieldAPIName,new List<String>());
                     }
                     m.get(fieldAPIName).addAll(fields.get(fieldAPIName)); ////
                 }
             }
         }
         return m;
     }

     //rt,layoutName,layout
     //Map<String,Map<String,List<String>>> layoutFields2
    
    // public static Map<String,List<String>> getDetailedLayout(Map<String,List<String>> fields, Map<String,Map<String,List<String>>> layoutFields){

    //    // field api name , attributes
    //     Map<String,List<String>> m = new Map<String,List<String>>();

    //     for (String rtName: layoutFields.keySet()){
    //         for (String layoutName: layoutFields.get(rtName).keyset()){
    //             for (String fieldAPIName: layoutFields.get(rtName).get(layoutName)){
    //                 if (!m.containsKey(fieldAPIName)){
    //                     m.put(fieldAPIName,new List<String>());
    //                 }
    //                 m.get(fieldAPIName).addAll(fields.get(fieldAPIName)); 
    //             }
    //         }
    //     }
    //     return m;
    // }

    // public static void print( Map<String,List<String>> m, String msg){
    //     System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::' + msg);
    //     for (String s:m.keySet()){
    //         System.Debug('BAMMMM::: ' + s);
    //         for (String l:m.get(s)){
    //             System.Debug('BAMMMM::: ' + l);
    //         }
    //         System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::');
    //     }
    // }
}

// public with sharing class GetDetailedLayoutFeilds {
    
//     public static Map<String,List<String>> getDetailedLayout(Map<String,List<String>> fields, Map<String,List<String>> layoutFields){

//        // field api name , attributes
//         Map<String,List<String>> m = new Map<String,List<String>>();

//         for (String layoutName: layoutFields.keySet()){

//             for (String fieldAPIName: layoutFields.get(layoutName)){

//                     // m.put(fieldAPIName,fields.get(fieldAPIName));
//                     if (!m.containsKey(fieldAPIName)){
//                         m.put(fieldAPIName,new List<String>());
//                     }
//                     m.get(fieldAPIName).addAll(fields.get(fieldAPIName));                
//             }
//         }
//         return m;
//     }

//     public static void print( Map<String,List<String>> m, String msg){
//         System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::' + msg);
//         for (String s:m.keySet()){
//             System.Debug('BAMMMM::: ' + s);
//             for (String l:m.get(s)){
//                 System.Debug('BAMMMM::: ' + l);
//             }
//             System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::');
//         }
//     }
// }