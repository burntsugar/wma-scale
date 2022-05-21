public class KickOff {

    public ObjectInfoExtract Go(String objectAPIName){
        GetObjectInfo fieldInfo = new GetObjectInfo();
        ObjectInfoExtract o = fieldInfo.getObjectInfo(objectAPIName);
        List<ObjectInfoRecordType> returnVals = o.getObjectInfoRecordTypes();
        return o;

    }

    public void extractObjectInfoToCSV(String objectAPIName){
        GetObjectInfo fieldInfo = new GetObjectInfo();
        fieldInfo.extractObjectInfoToCSV(objectAPIName);
    }

}