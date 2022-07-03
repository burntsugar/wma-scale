@isTest public class CrudTestingUtils {
    
    public static ContentDocumentLink setupForInsertContentDocumentLink(String contentWorkspaceName){
        ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:contentWorkspaceName];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
        ContentFolder contentFolder = new ContentFolder(Name='Test insertContentDocumentLink', ParentContentFolderId=workspaceContentFolder.Id);
        insert contentFolder;
        ContentVersion contentVersion = new ContentVersion(Title='Test insertContentDocumentLink', PathOnClient='Test insertContentDocumentLink.csv', VersionData=Blob.valueOf('content'));
        insert contentVersion;
        Id contentVersionConDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion.Id].ContentDocumentId;

        ContentDocumentLink contentDocumentLink = new ContentDocumentLink(ContentDocumentId=contentVersionConDocId, LinkedEntityId=testWorkspace.Id, ShareType='I');

        return contentDocumentLink;
    }

    public static ContentFolder makeContentWorkspaceContentFolder(String contentWorkspaceName){

        ContentWorkspace testWorkspace = [Select Id from ContentWorkspace WHERE Name =:contentWorkspaceName];
        ContentFolder workspaceContentFolder = [Select Id from ContentFolder WHERE Name =:testWorkspace.Id];
        
        return workspaceContentFolder;

    }

    public static ContentFolder makeContentFolder(String contentWorkspaceId, String contentWorkspaceContentFolderId){

        ContentFolder contentFolder = new ContentFolder(Name='Test insertContentDocumentLink', ParentContentFolderId=contentWorkspaceContentFolderId);
        insert contentFolder;
        ContentVersion contentVersion = new ContentVersion(Title='Test insertContentDocumentLink', PathOnClient='Test insertContentDocumentLink.csv', VersionData=Blob.valueOf('content'));
        insert contentVersion;
        Id contentVersionConDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion.Id].ContentDocumentId;
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink(ContentDocumentId=contentVersionConDocId, LinkedEntityId=contentWorkspaceId, ShareType='I');
        insert contentDocumentLink;

        return contentFolder;

    }
}
