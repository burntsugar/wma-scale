public with sharing class GetObjectInfo {

    private final String BASE_URL='callout:toolingapi?';
    private final string TOOLING_SQL='select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';

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

    // public void extractObjectInfoToCSV(String objectAPIName) {

    //     Type customType = Type.forName(objectAPIName);
	// 	sObject instance = (sObject)customType.newInstance();
    //     Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
    //     List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
    //     ObjectInfoExtract o = new ObjectInfoExtract();
    //     o.setObjectAPIName(objectAPIName);
    //     for (RecordTypeInfo rti : RT) {
    //         ObjectInfoRecordType oirt = new ObjectInfoRecordType(objectAPIName,rti.getDeveloperName(),rti.getRecordTypeId());
    //         o.addObjectInfoRecordType(oirt);
    //      }

    //     ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

    //     WriteToCSV.createCSV(objToCSV);
    // }

    // public void extractObjectInfoToCSV(String objectAPIName) {


    //     ObjectInfoExtract o = getObjectInfo(objectAPIName);

    //     ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

    //     WriteToCSV.createCSV(objToCSV);
    // }

    public void extractObjectInfoToCSV(String objectAPIName) {


        ObjectInfoExtract o = getObjectInfo(objectAPIName);

        startCall(o);

        ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

        WriteToCSV.createCSV(objToCSV);
    }

    public void startCall(ObjectInfoExtract o){
        // List<string> layouts = getBody();
        Map<String,LayoutRecord.Record> layoutRecords = getBody();

        // for(LayoutRecord.Record l : layoutObject.records){
        //     System.Debug(l.LayoutId);

        //     //List<String> fields = getFields(o.getObjectAPIName(), l);
        //     //o.getObjectInfoRecordTypes().addToFields(fields);
        // }

        for (String key : layoutRecords.keySet()) {
            // The "key" variable is also available inside the loop
            LayoutRecord.Record r = layoutRecords.get(key);
            // System.Debug(r.LayoutId);
            // System.Debug(r.Layout.Name + ' ' + r.RecordTypeId);
            for (ObjectInfoRecordType rt : o.getObjectInfoRecordTypes()){
                if (r.RecordTypeId == rt.getRecordTypeId()) {
                    rt.setLayoutName(r.Layout.Name);
                    rt.setLayoutId(r.LayoutId);
                     rt.addToFields(getFields(o.getObjectAPIName(), rt.getLayoutName()));
                     System.Debug('XXXXXXXXX 1: ' + rt.getLayoutName());
                } 
                // else if (r.RecordTypeId == null && RT.getIsMaster()){
                //     rt.setLayoutName(r.Layout.Name);
                //     rt.addToFields(getFields(o.getObjectAPIName(), rt.getLayoutName()));
                //     System.Debug('XXXXXXXXX 2: ' + rt.getLayoutName());

                // }
            }


            //o.getObjectInfoRecordTypes.get
            //List<String> toAddresses = emailDiseaseMap.get(key);
            // ... emailing logic
        }

        System.Debug('POOT:: ' + ' ' + o.getObjectInfoRecordTypes());

    }

    private Map<String,LayoutRecord.Record> getBody(){
    // private static List<string> getBody(){
        String body = CallTooling.call();

        if(string.isNotBlank(body))
        {
            LayoutRecord data=LayoutRecord.parse(body);

            //System.Debug(body);
            
            //get only layput name
            List<string> layouts=new List<string>();
            //List<LayoutRecord> layoutObjects = new List<LayoutRecord>();
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

            // return layouts;
            //System.Debug(layouts.size());

        }
        return null;

    }

    static List<string> getFields( string objectName,string layout ) {
        string layoutName=String.format('{0}-{1}', new String[]{objectName, layout}); 
        System.Debug('LAYOUT NAME :::' + layoutName);
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
        //get only layput name
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
        System.Debug('SIZEEEEEEEEEE: ' + fields.size());
        System.Debug(fields);
        return fields;
    }
}
