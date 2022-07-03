public class EasyOutput {
    public EasyOutput() {

    }

    public void saveFile(String workspaceLibraryName, String environmentContentFolderName, String documentTitle, String contentData) {

        String libWorkspaceName = workspaceLibraryName;
        String envContentFolderName = environmentContentFolderName;
    
        ContentWorkspace libraryContentWorkSpace = [Select Id from ContentWorkspace where Name =: libWorkspaceName];
        ContentFolder libraryContentFolder = [Select Id from ContentFolder where Name =: libraryContentWorkSpace.Id];
        ContentFolder folder = [Select Id from ContentFolder where Name =: envContentFolderName];
    
        String timestamp = Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        String title = documentTitle + '-' + timeStamp;
    
        String versionData = contentData;
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; 
        cv.Title = title; 
        cv.PathOnClient = title+ '.csv';
        cv.VersionData = Blob.valueOf(versionData);
        insert cv;
    
    
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = conDoc;
        cDe.LinkedEntityId = libraryContentWorkSpace.Id; 
        cDe.ShareType = 'I'; 
        insert cDe;
    
        ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
        cfm.ParentContentFolderId = folder.Id;
        update cfm;
    }
}
