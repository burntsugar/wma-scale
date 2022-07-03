public interface ICrud {

    // SObject doInsert(SObject record);
    // SObject doUpdate(SObject record);
    ContentVersion getContentVersion(String contentVersionId);
    ContentWorkspace getContentWorkSpace(String contentWorkspaceName);
    ContentFolder getContentFolder(String contentFolderName);
    ContentWorkSpace saveContentWorkspace(String name, String developerName);
    ContentFolder saveContentFolder(String contentFolderName, String parentContentFolderId);
    ContentFolderMember saveContentFolderMember(String parentContentFolderId, String contentFolderId);
    ContentDocumentLink saveContentDocumentLink(ContentVersion contentVersion,ContentWorkSpace contentWorkspace);
    ContentVersion saveContentVersion(String pathOnClient, String documentTitle, String content);
    
}
