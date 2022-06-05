public class ObjectInfoRecordType implements IObjectInfoRecordType {
    
    private String objectAPIName;
    private String recordTypeDeveloperName;
    private String recordTypeId;
    private List<String> fields;
    private boolean isMaster;
    private String layoutName;
    private String layoutId;
    private List<ObjectInfoField> objectInfoFields;
    public final String[] CSV_HEADERS = new String[] {'RT Developer Name','RT Id','Feild API Name', 'label' , 'defaultValue' , 'isCustom' , 'isNameField' , 'isNillable' , 'fieldDataType' , 'fieldLength' , 'isAutoNumber' , 'isCalculated' , 'isDependentPicklist' , 'isExternalId' , 'isIdLookup' , 'isUnique' , 'scale' , 'precision' };

    
    public ObjectInfoRecordType(String objectAPIName, String recordTypeDeveloperName,String recordTypeId, boolean isMaster){
        this.objectAPIName = objectAPIName;
        this.recordTypeDeveloperName = recordTypeDeveloperName;
        this.recordTypeId = recordTypeId;
        this.isMaster = isMaster;
    }

    public void addToObjectInfoFields(List<ObjectInfoField> objectInfoFields){
        if (this.objectInfoFields == null) {
            this.objectInfoFields = new List<ObjectInfoField>();
        }
        this.objectInfoFields.addAll(objectInfoFields);
    }
    public List<ObjectInfoField> getObjectInfoFields(){
        return this.objectInfoFields;
    }

    public String[] getCSV_Headers(){
        return this.CSV_HEADERS;
    }

    public List<String> getFields(){
        if (this.fields == null) {
            this.fields = new List<String>();
        }
        return this.fields;
    }

    public void addToFields(List<String> fields) {
        if (this.fields == null) {
            this.fields = new List<String>();
        }
        this.fields.addAll(fields);
    }
    
    public String getObjectAPIName(){
        return this.objectAPIName = recordTypeDeveloperName;
    }
    public String getRecordTypeDeveloperName(){
        return this.recordTypeDeveloperName;
    }
    public String getRecordTypeId(){
        return this.recordTypeId;
    }

    public Boolean getIsMaster() {
        return this.isMaster;
    }

    public void setLayoutName(String layoutName) {
        this.layoutName = layoutName;
    }
    public String getLayoutName(){
        return layoutName;
    }
    public void setLayoutId(String layoutId) {
        this.layoutId = layoutId;
    }
    public String getLayoutId(){
        return this.layoutId;
    }

}