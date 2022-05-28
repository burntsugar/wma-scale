public with sharing class GetInfo {

    public static void getObjectInfo(String objectAPIName) {

        // Get all object fields and their attributes.
        // fieldAPIName, field attribute Values
        Map<String,List<String>> fields = GetFieldsForObject.getFields(objectAPIName);

        // Get all object record Types and their attributes.
        // recorTypeName, attributeValues
        Map<String,List<String>> recordtypes = GetRecordTypesForObject.getRecordTypes(objectAPIName);

        // Get all object record type layouts
        //rt,layoutName,layout
        Map<String,Map<String,List<String>>> rtlayouts = new Map<String,Map<String,List<String>>>();
        for(String rt:recordtypes.keySet()){
            //Hack in the index below
            Map<String,List<String>> m = GetLayoutsForRecordType.getLayouts(recordtypes.get(rt).get(1));
            String recordTypeName = rt;
            for (String s: m.keySet()){

                if(!rtlayouts.containsKey(rt)){///
                    rtlayouts.put(rt,new Map<String,List<String>>());///
                }
                rtlayouts.get(rt).put(s,m.get(s));///
            } 
        }

        // layoutName, list of fields on the layout.
        //Map<String,List<String>> layoutFields = new Map<String,List<String>>();
        
        //rt,layoutName,layout
        Map<String,Map<String,List<String>>> layoutFields2 = new  Map<String,Map<String,List<String>>>();
        

        // Match the object fields to the layout they belong to.
        // Stores the format rt,layoutName,layout attribte values (name?)
        for (String mainMap: rtLayouts.keyset()) {
            for (String innerMapString:rtLayouts.get(mainMap).keyset()){
                if (innerMapString == null) continue;
                Map<String,List<String>> m = GetFieldsForlayout.getFields(objectAPIName, innerMapString);
                for (String s:m.keySet()){

                    // if(!layoutFields.containsKey(s)){
                    //     layoutFields.put(s,new List<String>());
                    // }
                    // layoutFields.get(s).AddAll(m.get(s));

                    if (s == null) continue;
                    //System.Debug('zzzzzzzzzzzz ' + mainMap);
                    if (!layoutFields2.containsKey(mainMap)){
                        layoutFields2.put(mainMap,new Map<String,List<String>>());
                        if (!layoutFields2.get(mainMap).containsKey(s)){
                            layoutFields2.get(mainMap).put(s,new List<String>());
                        }
                    }
                    layoutFields2.get(mainMap).get(s).AddAll(m.get(s));

                    // if(!layoutFields2.get(mainMap).containsKey(s)){
                    //     layoutFields2.put(s,new Map<String,List<String>>());
                    // }
                    // layoutFields2.get(mainMap).get(s).AddAll(m.get(s));
                    //}
                }

                
            }
        }

        print(layoutFields2,'tttttttt:::::','layoutFields2');

        // Compile map of object fields and their attributes on a page layout.
        // field api name , attributes
        // Map<String,List<String>> feildsForRecordType = GetDetailedLayoutFeilds.getDetailedLayout
        
        //rt,layoutname,fieldapiname, fieldattributes
        Map<String,Map<String,List<String>>> feildsForRecordTypeLayout = new Map<String,Map<String,List<String>>>();


        // for (String rtName: layoutFields2.keyset()){
        //     for(String layoutName: layoutFields2.get(rtName).keyset()){
        //         //Map<String,List<String>> fieldsForRT = GetDetailedLayoutFeilds.getDetailedLayout(fields,layoutFields2(rtName));

        //         if (!feildsForRecordTypeLayout.containsKey(rtName)){
        //             feildsForRecordTypeLayout.put(rtName, new Map<String,List<String>>());
        //         } else if(!feildsForRecordTypeLayout.get(rtName).containsKey(layoutName)){
        //             feildsForRecordTypeLayout.get(rtName).put(layoutName, new List<String>());
        //         }
        //         feildsForRecordTypeLayout.get(rtName).get(layoutName).put(GetDetailedLayoutFeilds.getDetailedLayout(fields,layoutFields2(rtName)));
        //     }            
        // } COME BACK HERE IN EXECUTION



        // // layoutName, fields.
        // Map<String,List<String>> layoutFields = new Map<String,List<String>>();
        // for (String l:layouts.keySet()){
        //     if (l == null) continue;
        //     Map<String,List<String>> m = GetFieldsForlayout.getFields(objectAPIName, l);
        //     for (String s:m.keySet()){
        //         if(!layoutFields.containsKey(s)){
        //             layoutFields.put(s,new List<String>());
        //         }
        //         layoutFields.get(s).AddAll(m.get(s));
        //     }
        // }

        // // field api name , attributes
        // Map<String,List<String>> feildsForRecordType = GetDetailedLayoutFeilds.getDetailedLayout(fields,layoutFields);

        // String[] headers = getHeaders(feildsForRecordType.keySet());
        // List<String> rows = getRows(feildsForRecordType);

        // String csvTitle = 'objectAPIName-RecordType-Fields';
        // WriteContentVersionCSV.toCSV(headers,rows,csvTitle);

    }

    private static List<String> getHeaders(Set<String> keys ) {
        List<String> headers = GetFieldsForObject.CSV_HEADERS;
        return headers;
    }

    private static List<String> getRows(Map<String,List<String>> fieldMap) {
        List<String> rows = new List<String>();

        // field api name , attributes
        for (String fieldName: fieldMap.keySet()){
            List<String> row = new List<String>();
            row.add(fieldName);
            row.addAll(fieldMap.get(fieldName));

            String str = String.join(row,',');
            rows.add(str);
        }
        return rows;
    }

    public static void print( Map<String,Map<String,List<String>>> m , String logPrefix, String msg){
        System.Debug(logPrefix + ' ' + msg);
        for (String mainMapKey:m.keySet()){
            System.Debug(logPrefix + ' ' + mainMapKey);
            for (String innerMapKey:m.get(mainMapKey).keySet()){
                System.Debug(logPrefix + ' ' + innerMapKey);
                for (String layoutattrs: m.get(mainMapKey).get(innerMapKey)){
                    System.Debug(logPrefix + ' ' + layoutattrs);
                }
            }
            System.Debug('WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::');
        }
    }

    // public static void print( Map<String,Map<String,List<String>>> m , String msg){
    //     System.Debug('WHOOSH-WHOOSH:::' + msg);
    //     for (String mainMapKey:m.keySet()){
    //         System.Debug('WHOOSH-WHOOSH::: mainMapKey' + mainMapKey);
    //         for (String innerMapKey:m.get(mainMapKey).keySet()){
    //             System.Debug('WHOOSH-WHOOSH::: innerMapKey' + innerMapKey);
    //         }
    //         System.Debug('WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::WHOOSH-WHOOSH:::');
    //     }
    // }

}
