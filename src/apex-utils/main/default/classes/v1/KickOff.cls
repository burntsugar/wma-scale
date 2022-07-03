public class KickOff {

    public void extractObjectInfoToCSV() {

    List<String> objectAPINames = new List<String> {'WMA_Place__c', 'WMA_Facility__c'};
    List<String> tableEnumOrIds = new List<String> {'01I5j000000BHZm','01I5j000000BHZl'};

    String documentTitle = 'Fields for Record Type';
    String envName = 'WMA';
    String workspaceLibraryName = 'my-queries';
    String environmentContentFolderName = 'general';

    List<ObjectInfoCSVWrapper> csvWrappers = new List<ObjectInfoCSVWrapper>();
    for (Integer i = 0; i < objectAPINames.size(); i++){
        GetObjectInfo fieldInfo = new GetObjectInfo();
    
        csvWrappers.add(fieldInfo.extractObjectInfoToCSV(objectAPINames.get(i), tableEnumOrIds.get(i), documentTitle, envName, workspaceLibraryName, environmentContentFolderName));
    }

    List<String> finalRows = new List<String>();
    for (ObjectInfoCSVWrapper csv : csvWrappers) {
        CSVRows rows = csv.makecSVRows();
        for (String row : rows.getCSVRows()) {
            finalRows.add(row);
        }
        
    }

    CSVHeaders headers = csvWrappers.get(0).makecSVHeaders();
    String finalContent = createCSVContent(headers,finalRows);
    EasyOutput easyOutput = new EasyOutput();
    easyOutput.saveFile(workspaceLibraryName,environmentContentFolderName,documentTitle,finalContent);
    }

    public String createCSVContent(CSVHeaders headers, List<String> rows) {
        String headerRow = String.join(headers.getCSVHeaders(),',') + '\n';
        String concantenatedStr = headerRow;
        Integer i = 0;
        Integer rowListSize = rows.size();

        try {
            for(String row :rows){
            
                i++;
                List<String> res = row.split(',');
                String str = String.join(res,',');
                concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
            }
        } catch (StringException stre) {
            throw new ContentException(ContentException.getErrorMessage(ContentException.errorMsg.BLOB_SIZE_MSG_CONTENTVERSION), stre);
        }
        return concantenatedStr;
    }
}