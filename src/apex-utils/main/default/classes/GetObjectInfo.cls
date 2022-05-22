public with sharing class GetObjectInfo {

    private final String BASE_URL_TOOLING_PROFILELAYOUT='callout:toolingapi?';
    private final string TOOLING_PROFILELAYOUT_SQL='select Layout.Name,LayoutId, ProfileId, Profile.Name, RecordTypeId, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';

    public ObjectInfoExtract getObjectInfo(String objectAPIName) {
        
        Type customType = Type.forName(objectAPIName);
		sObject instance = (sObject)customType.newInstance();
        Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
        ObjectInfoExtract o = new ObjectInfoExtract();
        o.setObjectAPIName(objectAPIName);
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        for (RecordTypeInfo rti : RT) {
           ObjectInfoRecordType oirt = new ObjectInfoRecordType(objectAPIName,rti.getDeveloperName(),rti.getRecordTypeId(),rti.isMaster());
           o.addObjectInfoRecordType(oirt);
        }
        
        return o;
    }

    public void extractObjectInfoToCSV(String objectAPIName) {

        ObjectInfoExtract o = getObjectInfo(objectAPIName);

        getLayoutsForObject(o);

        
        for (ObjectInfoRecordType rt : o.getObjectInfoRecordTypes()){
            List<ObjectInfoField> objectInfoFields = new List<ObjectInfoField>();
            for (String fieldName : rt.getFields()) {
                objectInfoFields.add(syncFields(o.getObjectAPIName(),fieldName));
            }
            rt.addToObjectInfoFields(objectInfoFields);
        }

        ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

        WriteToCSV.createCSV(objToCSV);
    }


    private ObjectInfoField syncFields(String oName, String fName){
        String objectName = oName;
        String fieldName = fName;

        SObjectType r = ((SObject)(Type.forName('Schema.'+objectName).newInstance())).getSObjectType();
        DescribeSObjectResult d = r.getDescribe();
        // System.debug(d.fields
        //         .getMap()
        //         .get(fieldName)
        //         .getDescribe()
        //         .isNillable());

        String fieldAPIName = fname;
        String label = d.fields.getMap().get(fieldName).getDescribe().getLabel();
        String defaultValue = String.valueOf(d.fields.getMap().get(fieldName).getDescribe().getDefaultValue());
        boolean isCustom = d.fields.getMap().get(fieldName).getDescribe().isCustom();
        boolean isNameField = d.fields.getMap().get(fieldName).getDescribe().isNameField();
        boolean isNillable = d.fields.getMap().get(fieldName).getDescribe().isNillable();
        String type = String.valueOf(d.fields.getMap().get(fieldName).getDescribe().getType());
        String length = String.valueOf(d.fields.getMap().get(fieldName).getDescribe().getLength());
        boolean isAutoNumber = d.fields.getMap().get(fieldName).getDescribe().isAutoNumber();
        boolean isCalculated = d.fields.getMap().get(fieldName).getDescribe().isCalculated();
        boolean isDependentPicklist = d.fields.getMap().get(fieldName).getDescribe().isDependentPicklist();
        boolean isExternalId = d.fields.getMap().get(fieldName).getDescribe().isExternalId();
        boolean isIdLookup = d.fields.getMap().get(fieldName).getDescribe().isIdLookup();
        boolean isUnique = d.fields.getMap().get(fieldName).getDescribe().isUnique();
        String scale = String.valueOf(d.fields.getMap().get(fieldName).getDescribe().getScale());
        String precision = String.valueOf(d.fields.getMap().get(fieldName).getDescribe().getPrecision());
        ObjectInfoField oif = new ObjectInfoField(fname,label,defaultValue,isCustom,isNameField,isNillable,type,length,isAutoNumber,isCalculated,isDependentPicklist,isExternalId,isIdLookup,isUnique,scale,precision);

        return oif;

    }


    public void getLayoutsForObject(ObjectInfoExtract o){

        Map<String,LayoutRecord.Record> layoutRecords = calloutToProfileToolingAPI();

        for (String key : layoutRecords.keySet()) {
            LayoutRecord.Record r = layoutRecords.get(key);
            for (ObjectInfoRecordType rt : o.getObjectInfoRecordTypes()){
                if (r.RecordTypeId == rt.getRecordTypeId()) {
                    rt.setLayoutName(r.Layout.Name);
                    rt.setLayoutId(r.LayoutId);
                    rt.addToFields(getFields(o.getObjectAPIName(), rt.getLayoutName()));
                } 
            }
        }

    }

    private Map<String,LayoutRecord.Record> calloutToProfileToolingAPI(){

        String body = CallSalesforceAPI.call(BASE_URL_TOOLING_PROFILELAYOUT,TOOLING_PROFILELAYOUT_SQL);

        if(string.isNotBlank(body))
        {
            LayoutRecord data=LayoutRecord.parse(body);
            
            //get only layout name
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

    static List<string> getFields( string objectName,string layout ) {
        string layoutName=String.format('{0}-{1}', new String[]{objectName, layout}); 
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
        //get only layout name
        List<string> fields=new List<string>();
        Metadata.Layout layoutMd = (Metadata.Layout)layouts.get(0);
        for (Metadata.LayoutSection section : layoutMd.layoutSections) {
            for (Metadata.LayoutColumn column : section.layoutColumns) {
                if (column.layoutItems != null) {
                    for (Metadata.LayoutItem item : column.layoutItems) {
                        fields.add(item.field);
                    }
                }
            }
        }
        return fields;
    }
}