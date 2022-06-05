public with sharing class GetLayoutsForRecordType {

    private static final String BASE_URL_TOOLING_PROFILELAYOUT='callout:toolingapi?';
    private static final string TOOLING_PROFILELAYOUT_SQL='select Layout.Name,LayoutId, ProfileId, Profile.Name, RecordTypeId, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';

    public static Map<String,List<String>> getLayouts(String recordTypeId){
        // LayoutName, attribute values
        Map<String,List<String>> m = new Map<String,List<String>>();
        Map<String,LayoutRecord.Record> layoutRecords = calloutToProfileToolingAPI();
        // List<String> attrValue = new List<String>();
        String layoutName;

        for (String key : layoutRecords.keySet()) {
            LayoutRecord.Record r = layoutRecords.get(key);
            List<String> attrValue = new List<String>();
                if (r.RecordTypeId == recordTypeId) {
                    layoutName = r.Layout.Name;
                    attrValue.add(r.LayoutId);
                } 
                if (!m.containsKey(layoutname)){
                    m.put(layoutName,attrValue);
                }
                m.get(layoutName).addAll(attrValue);
        }

        return m;
    }

    private static Map<String,LayoutRecord.Record> calloutToProfileToolingAPI(){
        String body = CallSalesforceAPI.call(BASE_URL_TOOLING_PROFILELAYOUT,TOOLING_PROFILELAYOUT_SQL);
        if(string.isNotBlank(body))
        {
            LayoutRecord data=LayoutRecord.parse(body);
            List<string> layouts=new List<string>();
            Map<String,LayoutRecord.Record> layoutRecords = new Map<String,LayoutRecord.Record>();
            for(LayoutRecord.Record record:data.records)
            {
                if(!layouts.contains(record.Layout.Name))
                {
                    layouts.add(string.valueOf(record.Layout.Name));
                    layoutRecords.put(string.valueOf(record.Layout.Name),record);
                }
            }
            return layoutRecords;
        }
        return null;
    }
}
