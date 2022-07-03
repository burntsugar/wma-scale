public interface IObjectInfoExtract {

    String getObjectAPIName();
    String setObjectAPIName(String objectAPIName);
    List<ObjectInfoRecordType> getObjectInfoRecordTypes();
    void addObjectInfoRecordType(ObjectInfoRecordType objectInfoRecordType);
    String[] getCSV_Headers();
    
}
