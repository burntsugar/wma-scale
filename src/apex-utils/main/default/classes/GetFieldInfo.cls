public class GetFieldInfo {
    
    String objectName;
    
    public List<ObjectInfoWrapper> getObjectInfo(String objectAPIName) {
        
        Type customType = Type.forName(objectAPIName);
		sObject instance = (sObject)customType.newInstance();
        
        Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        List<ObjectInfoWrapper> retvals = new List<ObjectInfoWrapper>();
        for (RecordTypeInfo rti : RT) {
            ObjectInfoWrapper o = new ObjectInfoWrapper();
            o.setObjectAPIName(objectAPIName);
            o.setRecordTypeDeveloperName(rti.getDeveloperName());
            o.setRecordTypeId(rti.getRecordTypeId());
            retvals.add(o);
        }
        
        objectName = 'WMA_Facility__c';
        return retvals;
    }
    
    public List<String> getRecordTypesForObject(String objectAPIName) {
        
        Type customType = Type.forName(objectAPIName);
		sObject instance = (sObject)customType.newInstance();
        
        Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        List<String> retvals = new List<String>();
        for (RecordTypeInfo rti : RT) {
            //System.Debug(rti.getDeveloperName() + ' ' + rti.getRecordTypeId());
            retvals.add(rti.getDeveloperName());
        }
        
        objectName = 'WMA_Facility__c';
        return retvals;
    }
    
    public String getXXX() {
        Schema.DescribeSObjectResult R = WMA_Facility__c.SObjectType.getDescribe();
		List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
		for (RecordTypeInfo rti : RT) {
    		System.Debug(rti.getDeveloperName() + ' ' + rti.getRecordTypeId());
		}
        
        objectName = 'WMA_Facility__c';
        return ObjectName;
    }

}