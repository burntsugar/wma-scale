public with sharing class GetInfo {

    public static void getObjectInfo(String objectAPIName) {

        // fieldAPIName, attributeValues
        Map<String,List<String>> fields = GetFieldsForObject.getFields(objectAPIName);

        // recorTypeName, attributeValues
        Map<String,List<String>> recordtypes = GetRecordTypesForObject.getRecordTypes(objectAPIName);

        //rt,layoutName,layout
        Map<String,Map<String,List<String>>> rtlayouts = new Map<String,Map<String,List<String>>>();

        // LayoutName, attribute values
        Map<String,List<String>> layouts = new Map<String,List<String>>();
        for(String rt:recordtypes.keySet()){
            //Hack below
            Map<String,List<String>> m = GetLayoutsForRecordType.getLayouts(recordtypes.get(rt).get(1));
            String recordTypeName = rt;
            for (String s: m.keySet()){
                if(!layouts.containsKey(s)){
                    layouts.put(s,new List<String>());
                }
                layouts.get(s).AddAll(m.get(s));

                if(!rtlayouts.containsKey(rt)){///
                    rtlayouts.put(rt,new Map<String,List<String>>());///
                }
                rtlayouts.get(rt).put(s,m.get(s));///
        
            }

            
        }

        // layoutName, fields.
        Map<String,List<String>> layoutFields = new Map<String,List<String>>();
        for (String l:layouts.keySet()){
            if (l == null) continue;
            Map<String,List<String>> m = GetFieldsForlayout.getFields(objectAPIName, l);
            for (String s:m.keySet()){
                if(!layoutFields.containsKey(s)){
                    layoutFields.put(s,new List<String>());
                }
                layoutFields.get(s).AddAll(m.get(s));
            }
        }

        // field api name , attributes
        Map<String,List<String>> feildsForRecordType = GetDetailedLayoutFeilds.getDetailedLayout(fields,layoutFields);

        String[] headers = getHeaders(feildsForRecordType.keySet());
        List<String> rows = getRows(feildsForRecordType);

        String csvTitle = 'objectAPIName-RecordType-Fields';
        WriteContentVersionCSV.toCSV(headers,rows,csvTitle);

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

}
