public interface ICrud {

    SObject doInsert(SObject record);
    SObject doUpdate(SObject record);
    ContentVersion getContentVersion(String contentVersionId);
    ContentWorkspace getContentWorkSpace(String contentWorkspaceName);
    ContentFolder getContentFolder(String contentFolderName);
    ContentWorkSpace makeContentWorkspace(String name, String developerName);
    ContentFolder makeContentFolder(String contentFolderName, String parentContentFolderId);
    ContentFolderMember makeContentFolderMember(String parentContentFolderId, String contentFolderId);
    ContentDocumentLink makeContentDocumentLink(ContentVersion contentVersion,ContentWorkSpace contentWorkspace);
    
}
