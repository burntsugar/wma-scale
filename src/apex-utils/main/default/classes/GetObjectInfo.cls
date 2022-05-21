public with sharing class GetObjectInfo {

    public ObjectInfoExtract getObjectInfo(String objectAPIName) {
        
        Type customType = Type.forName(objectAPIName);
		sObject instance = (sObject)customType.newInstance();
        Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        ObjectInfoExtract o = new ObjectInfoExtract();
        for (RecordTypeInfo rti : RT) {
           ObjectInfoRecordType oirt = new ObjectInfoRecordType(objectAPIName,rti.getDeveloperName(),rti.getRecordTypeId());
           o.addObjectInfoRecordType(oirt);
        }
        
        return o;
    }

    public void extractObjectInfoToCSV(String objectAPIName) {

        Type customType = Type.forName(objectAPIName);
		sObject instance = (sObject)customType.newInstance();
        Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        ObjectInfoExtract o = new ObjectInfoExtract();
        o.setObjectAPIName(objectAPIName);
        for (RecordTypeInfo rti : RT) {
            ObjectInfoRecordType oirt = new ObjectInfoRecordType(objectAPIName,rti.getDeveloperName(),rti.getRecordTypeId());
            o.addObjectInfoRecordType(oirt);
         }

        ObjectInfoCSV objToCSV = new ObjectInfoCSV(o, 'second-csv');

        WriteToCSV.createCSV(objToCSV);
    }
}
