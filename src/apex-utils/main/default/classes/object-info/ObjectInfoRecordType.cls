public class ObjectInfoRecordType implements RecordTypeWrapping {
    
    private String objectAPIName;
    private String recordTypeDeveloperName;
    private String recordTypeId;
    private List<String> fields;
    private boolean isMaster;
    private String layoutName;
    private String layoutId;
    public final String[] CSV_HEADERS = new String[] {'RT Developer Name','RT Id','Feild API Name'};

    
    public ObjectInfoRecordType(String objectAPIName, String recordTypeDeveloperName,String recordTypeId, boolean isMaster){
        this.objectAPIName = objectAPIName;
        this.recordTypeDeveloperName = recordTypeDeveloperName;
        this.recordTypeId = recordTypeId;
        this.isMaster = isMaster;
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
        System.Debug('ADDFIELDSX' + ' ' + fields);

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