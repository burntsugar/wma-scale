public interface RecordTypeWrapping {
    
        String getObjectAPIName();
        String getRecordTypeDeveloperName();
        String getRecordTypeId();
        void addToFields(List<String> fields);  
        List<String> getFields();
        Boolean getIsMaster();
        void setLayoutName(String layoutName);
        String getLayoutName();
        void setLayoutId(String layoutId);
        String getLayoutId();


}