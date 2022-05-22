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
                //syncFields(o.getObjectAPIName(),fieldName);
                objectInfoFields.add(syncFields(o.getObjectAPIName(),fieldName));
            }
            rt.addToObjectInfoFields(objectInfoFields);
        }

        // syncFields(o.getObjectAPIName(),'Name');

        ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

        WriteToCSV.createCSV(objToCSV);
    }

    // private void syncFields(ObjectInfoExtract o){

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

        //Map<String,Schema.SObjectTypeFields> l = d.fields.getMap().get(fieldName).getDescribe();
        System.debug('FOOOOOOOOOOO ::' + d.fields.getMap().get(fieldName).getDescribe().isNillable());
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

            //ObjectInfoField ooo = (IObjectInfoField)oif;

            return oif;



///

        // SObjectType oType = Schema.getGlobalDescribe().get(o.getObjectAPIName());
        // Map<String,Schema.SObjectField> mfields = oType.getDescribe().fields.getMap();

        // // System.Debug('FOOOOOOOOOOO ::' + mFields);

        // for( String fieldName : mFields.keySet()) {
        //     // System.Debug('FOOOOOOOOOOO ::' + mFields.get('Type'));
        //     SObjectField sof = mFields.get(fieldName);
        //     System.Debug('FOOOOOOOOOOO ::' + sof);
        //     //Schema.DescribeFieldResult dfr = sof;

        // }
        // Type customType = Type.forName(objectAPIName);
		// sObject instance = (sObject)customType.newInstance();

        // String[] types = new String[]{o.getObjectAPIName()};
        // Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        // // Schema.DescribeFieldResult F = results[0].getDescribe();
        // // Schema.DescribeFieldResult dfr = Schema.SObjectType.Account.fields.Name;
        //  List<Schema.DescribeFieldResult> F = results[0].getMap();



        // for (IObjectInfoRecordType rt: o.getObjectInfoRecordTypes()){
        //     String label = results[0].getLabel();
        //     //String defaultValue = String.valueOf(results[0].getDefaultValue());
        //     boolean isCustom = results[0].isCustom();
        //     //boolean isNameField = results[0].isNameField();
        //     //boolean isNillable = results[0].isNillable();
        //     //String type = String.valueOf(results[0].getType());
        //     //String length = String.valueOf(results[0].getLength());
        //     //boolean isAutoNumber = results[0].isAutoNumber();
        //     //boolean isCalculated = results[0].isCalculated();
        //     boolean isDependentPicklist = results[0].isDependentPicklist();
        //     boolean isExternalId = results[0].isExternalId();
        //     boolean isIdLookup = results[0].isIdLookup();
        //     boolean isUnique = results[0].isUnique();
        //     String scale = String.valueOf(results[0].getScale());
        //     String precision = String.valueOf(results[0].getPrecision());
            //ObjectInfoField oif = new ObjectInfoField();


            //System.Debug('XXX::: ' + rt.getRecordTypeId() + ' ' + oif.getLabel());

            // for (String f : rt.getFields()) {
            //     SObjectField = mfields.get(f);
            //     ObjectInfoField oif = new ObjectInfoField(mfields.get(f).getLabel());

            // }
        //}

    }

    // private void syncFields(ObjectInfoExtract o){

    //     // SObjectType oType = Schema.getGlobalDescribe().get(o.getObjectAPIName());
    //     // Map<String,Schema.SObjectField> mfields = oType.getDescribe().fields.getMap();
    //     // Type customType = Type.forName(objectAPIName);
	// 	// sObject instance = (sObject)customType.newInstance();

    //     String[] types = new String[]{o.getObjectAPIName()};
    //     Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
    //     // Schema.DescribeFieldResult F = results[0].getDescribe();
    //     // Schema.DescribeFieldResult dfr = Schema.SObjectType.Account.fields.Name;
    //      List<Schema.DescribeFieldResult> F = results[0].getMap();



    //     for (IObjectInfoRecordType rt: o.getObjectInfoRecordTypes()){
    //         String label = results[0].getLabel();
    //         //String defaultValue = String.valueOf(results[0].getDefaultValue());
    //         boolean isCustom = results[0].isCustom();
    //         //boolean isNameField = results[0].isNameField();
    //         //boolean isNillable = results[0].isNillable();
    //         //String type = String.valueOf(results[0].getType());
    //         //String length = String.valueOf(results[0].getLength());
    //         //boolean isAutoNumber = results[0].isAutoNumber();
    //         //boolean isCalculated = results[0].isCalculated();
    //         boolean isDependentPicklist = results[0].isDependentPicklist();
    //         boolean isExternalId = results[0].isExternalId();
    //         boolean isIdLookup = results[0].isIdLookup();
    //         boolean isUnique = results[0].isUnique();
    //         String scale = String.valueOf(results[0].getScale());
    //         String precision = String.valueOf(results[0].getPrecision());
    //         //ObjectInfoField oif = new ObjectInfoField();


    //         //System.Debug('XXX::: ' + rt.getRecordTypeId() + ' ' + oif.getLabel());

    //         // for (String f : rt.getFields()) {
    //         //     SObjectField = mfields.get(f);
    //         //     ObjectInfoField oif = new ObjectInfoField(mfields.get(f).getLabel());

    //         // }
    //     }

    // }

    // private void syncFields(ObjectInfoExtract o){

    //     SObjectType oType = Schema.getGlobalDescribe().get(o.getObjectAPIName());
    //     Map<String,Schema.SObjectField> mfields = oType.getDescribe().fields.getMap();

    //     for (IObjectInfoRecordType rt: o.getObjectInfoRecordTypes()){
    //         for (String f : rt.getFields()) {
    //             SObjectField = mfields.get(f);
    //             ObjectInfoField oif = new ObjectInfoField(mfields.get(f).getLabel());

    //         }
    //     }

    // }

    // private void queryFields(String objectAPIName, String fieldName){

    //     Type customType = Type.forName(objectAPIName);
	// 	sObject instance = (sObject)customType.newInstance();

    //     SObjectType accountType = Schema.getGlobalDescribe().get('objectAPIName');
    //     Map<String,Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();

    //     Schema.DescribeFieldResult nameDesc = instance.get(fieldName).getDescribe();

    //     schema.sObjectField fieldObject = instance.get(fieldName);

    //     Schema.DescribeFieldResult F = instance.get(fieldName).getDescribe();


    //     //Schema.DescribeFieldResult F = WMA_Facility__c.fields.WMA_Facility_Location_Type__c.getDescribe();
    //    // Schema.sObjectField T = F.getSObjectField();
    // }

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
            
            //get only layput name
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
        System.Debug('LAYOUT NAME :::' + layoutName);
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


// public with sharing class GetObjectInfo {

//     private final String BASE_URL_TOOLING_PROFILELAYOUT='callout:toolingapi?';
//     private final string TOOLING_PROFILELAYOUT_SQL='select Layout.Name,LayoutId, ProfileId, Profile.Name, RecordTypeId, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';

//     public ObjectInfoExtract getObjectInfo(String objectAPIName) {
        
//         Type customType = Type.forName(objectAPIName);
// 		sObject instance = (sObject)customType.newInstance();
//         Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
//         ObjectInfoExtract o = new ObjectInfoExtract();
//         o.setObjectAPIName(objectAPIName);
//         List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
//         for (RecordTypeInfo rti : RT) {
//            ObjectInfoRecordType oirt = new ObjectInfoRecordType(objectAPIName,rti.getDeveloperName(),rti.getRecordTypeId(),rti.isMaster());
//            o.addObjectInfoRecordType(oirt);
//         }
        
//         return o;
//     }

//     public void extractObjectInfoToCSV(String objectAPIName) {

//         ObjectInfoExtract o = getObjectInfo(objectAPIName);

//         getLayoutsForObject(o);

//         ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

//         WriteToCSV.createCSV(objToCSV);
//     }

//     public void getLayoutsForObject(ObjectInfoExtract o){

//         Map<String,LayoutRecord.Record> layoutRecords = calloutToProfileToolingAPI();

//         for (String key : layoutRecords.keySet()) {
//             LayoutRecord.Record r = layoutRecords.get(key);
//             for (ObjectInfoRecordType rt : o.getObjectInfoRecordTypes()){
//                 if (r.RecordTypeId == rt.getRecordTypeId()) {
//                     rt.setLayoutName(r.Layout.Name);
//                     rt.setLayoutId(r.LayoutId);
//                     rt.addToFields(getFields(o.getObjectAPIName(), rt.getLayoutName()));
//                 } 
//             }
//         }

//     }

//     private Map<String,LayoutRecord.Record> calloutToProfileToolingAPI(){

//         String body = CallSalesforceAPI.call(BASE_URL_TOOLING_PROFILELAYOUT,TOOLING_PROFILELAYOUT_SQL);

//         if(string.isNotBlank(body))
//         {
//             LayoutRecord data=LayoutRecord.parse(body);
            
//             //get only layput name
//             List<string> layouts=new List<string>();
//             Map<String,LayoutRecord.Record> layoutRecords = new Map<String,LayoutRecord.Record>();

//             for(LayoutRecord.Record record:data.records)
//             {
//                 if(!layouts.contains(record.Layout.Name))
//                 {
//                     layouts.add(string.valueOf(record.Layout.Name));
//                     layoutRecords.put(string.valueOf(record.Layout.Name),record);
//                 }
                
//             }
//             return layoutRecords;
//         }
//         return null;

//     }

//     static List<string> getFields( string objectName,string layout ) {
//         string layoutName=String.format('{0}-{1}', new String[]{objectName, layout}); 
//         System.Debug('LAYOUT NAME :::' + layoutName);
//         List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
//         //get only layout name
//         List<string> fields=new List<string>();
//         Metadata.Layout layoutMd = (Metadata.Layout)layouts.get(0);
//         for (Metadata.LayoutSection section : layoutMd.layoutSections) {
//             for (Metadata.LayoutColumn column : section.layoutColumns) {
//                 if (column.layoutItems != null) {
//                     for (Metadata.LayoutItem item : column.layoutItems) {
//                         fields.add(item.field);
//                     }
//                 }
//             }
//         }
//         return fields;
//     }
// }
