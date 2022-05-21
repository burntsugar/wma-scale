public class ObjectInfoRecordType implements RecordTypeWrapping {
    
    public String objectAPIName;
    public String recordTypeDeveloperName;
    public String recordTypeId;
    
    public ObjectInfoRecordType(String objectAPIName, String recordTypeDeveloperName,String recordTypeId){
        this.objectAPIName = objectAPIName;
        this.recordTypeDeveloperName = recordTypeDeveloperName;
        this.recordTypeId = recordTypeId;
    }
    

    // TODO:Remove
    public String getObjectAPIName(){
        return this.objectAPIName = recordTypeDeveloperName;
    }
    public String getRecordTypeDeveloperName(){
        return this.recordTypeDeveloperName;
    }
    public String getRecordTypeId(){
        return this.recordTypeId;
    }

}