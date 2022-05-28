public class KickOff {

    public void extractObjectInfoToCSV(String objectAPIName){
        GetObjectInfo fieldInfo = new GetObjectInfo();
        fieldInfo.extractObjectInfoToCSV(objectAPIName);
    }

    public void extractObjectInfoToCSV(String objectAPIName, String reportTitle){
        GetObjectInfo fieldInfo = new GetObjectInfo();
        fieldInfo.extractObjectInfoToCSV(objectAPIName, reportTitle);
    }

}