public with sharing class WriteToCSV {

    private static void createFile(String versionData, String title) {
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; //denotes it resides on Salesforce
        cv.Title = title; //title of the file
        cv.PathOnClient = title; // full path within Salesforce this can just be the name of file to be in the library
        cv.VersionData = Blob.valueOf(versionData); //file data
        insert cv;
    }

    public static void createCSV(ObjectInfoCSV objectInfoCSV) {
        createCSV(objectInfoCSV.getCSVHeaders().getCSVHeaders(),objectInfoCSV.getCSVRows().getCSVRows(),objectInfoCSV.getCsvTitle());
    }

    private static void createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
        String headerRow = String.join(csvHeaders,',') + '\n';
        String concantenatedStr = headerRow;
        Integer i = 0;
        Integer rowListSize = csvRowList.size();
        //assuming the rowList is in the correct format and each object in the list is a new record
        for(String row :csvRowList){
           
            i++;
            List<String> res = row.split(',');
            String str = String.join(res,',');
            concantenatedStr += (String)str + ((i != rowListSize) ? '\n' : '');//add new line
        }
        title += '.csv';
        createFile(concantenatedStr, title);
    }

    // private static void createCSV(List<String> csvHeaders, List<String> csvRowList, String title){
    //     String headerRow = String.join(csvHeaders,',') + '\n';
    //     String concantenatedStr = headerRow;
    //     Integer i = 0;
    //     Integer rowListSize = csvRowList.size();
    //     //assuming the rowList is in the correct format and each object in the list is a new record
    //     for(String row :csvRowList){
           
    //         i++;
    //         concantenatedStr += (String)row + ((i != rowListSize) ? '\n' : '');//add new line
    //     }
    //     title += '.csv';
    //     createFile(concantenatedStr, title);
    // }
}
