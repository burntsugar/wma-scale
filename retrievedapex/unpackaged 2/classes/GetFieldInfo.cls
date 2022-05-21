public class GetFieldInfo {
    
    String objectName;
    
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