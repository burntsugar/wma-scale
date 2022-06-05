public with sharing class GetRecordTypesForObject {
    
    public static Map<String,List<String>> getRecordTypes(String objectAPIName) {

        // recorTypeName, attributeValues
        Map<String,List<String>> m = new Map<String,List<String>>();
        
        String recordTypeName;

        SObjectType ot = ((SObject)(Type.forName('Schema.'+objectAPIName).newInstance())).getSObjectType();
        Schema.DescribeSObjectResult R = ot.getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();

        for (RecordTypeInfo rti: RT){
            List<String> attrValue = new List<String>();
            recordTypeName = rti.getName();
            attrValue.add(rti.getDeveloperName());
            attrValue.add(rti.getRecordTypeId());

            if (!m.containsKey(recordTypeName)){
                m.put(recordTypeName, new List<String>());
            }
            m.get(recordTypeName).addAll(attrValue);
        }
        
        return m;
    }

}
