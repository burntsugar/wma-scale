public class KickOff {

    // public void extractObjectInfoToCSV(String objectAPIName){
    //     GetObjectInfo fieldInfo = new GetObjectInfo();
    //     fieldInfo.extractObjectInfoToCSV(objectAPIName);
    // }

    // public void extractObjectInfoToCSV(String objectAPIName, String reportTitle){
    //     GetObjectInfo fieldInfo = new GetObjectInfo();
    //     fieldInfo.extractObjectInfoToCSV(objectAPIName, reportTitle);
    // }

    // public void extractObjectInfoToCSV(String objectAPIName, String reportTitle, String envName){
    //     GetObjectInfo fieldInfo = new GetObjectInfo();
    //     fieldInfo.extractObjectInfoToCSV(objectAPIName, reportTitle, envName);
    // }

    //     public void extractObjectInfoToCSV(String objectAPIName, String documentTitle, String envName, String workspaceLibraryName, String environmentContentFolderName) {

        public void extractObjectInfoToCSV(String objectAPIName, String documentTitle, String envName, String workspaceLibraryName, String environmentContentFolderName){
            GetObjectInfo fieldInfo = new GetObjectInfo();
            fieldInfo.extractObjectInfoToCSV(objectAPIName, documentTitle, envName, workspaceLibraryName, environmentContentFolderName);
        }

    public void GetLastModifedAttr(){
        GetLastModifedAttributesFromTooling.calloutToProfileToolingAPI();
    }

}