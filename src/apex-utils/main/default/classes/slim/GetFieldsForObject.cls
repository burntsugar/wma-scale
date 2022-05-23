public with sharing class GetFieldsForObject {

     public final static String[] CSV_HEADERS = new String[] {'Feild API Name', 'label' , 'defaultValue' , 'isCustom' , 'isNameField' , 'isNillable' , 'fieldDataType' , 'fieldLength' , 'isAutoNumber' , 'isCalculated' , 'isDependentPicklist' , 'isExternalId' , 'isIdLookup' , 'isUnique' , 'scale' , 'precision' };

    public static Map<String,List<String>> getFields(String objectAPIName) {

        // fieldAPIName, attributeValues
        Map<String,List<String>> m = new Map<String,List<String>>();
        String fieldAPIName;
        SObjectType r = ((SObject)(Type.forName('Schema.'+objectAPIName).newInstance())).getSObjectType();
        DescribeSObjectResult d = r.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = d.fields.getMap();

        for (String s : fieldMap.keySet()) {
            List<String> attrValue = new List<String>();            
            fieldAPIName = String.valueOf(fieldMap.get(s).getDescribe().getName());
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getLabel()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getDefaultValue()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isCustom()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isNameField()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isNillable()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getType()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getLength()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isAutoNumber()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isCalculated()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isDependentPicklist()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isExternalId()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isIdLookup()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().isUnique()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getScale()));
            attrValue.add(String.valueOf(fieldMap.get(s).getDescribe().getPrecision()));

            if (!m.containsKey(fieldAPIName)){
                m.put(fieldAPIName, new List<String>());
            }
            m.get(fieldAPIName).addAll(attrValue);
        }

        return m;
    }

    public static void print( Map<String,List<String>> m, String msg){
        System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::' + msg);
        for (String s:m.keySet()){
            System.Debug('BAMMMM1::: ' + s);
            for (String l:m.get(s)){
                System.Debug('BAMMMM2::: ' + l);
            }
            System.Debug('BAMMMM:::BAMMMM:::BAMMMM:::BAMMMM:::');
        }
    }

}
