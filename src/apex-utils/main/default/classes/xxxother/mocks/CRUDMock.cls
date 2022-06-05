public with sharing class CRUDMock  {

    private static List<sObject> sObjects= new List<sObject>();
    
    
    public static SObject doInsert(SObject record) {
        // record.Id = generate a fake id https://salesforce.stackexchange.com/questions/21137/creating-unit-tests-without-interacting-with-the-database-creating-fake-ids
        record.Id = '0685j00000AfoLGAAZ';
        sObjects.add(record);
        return record;
    }

    public static SObject doUpdate(SObject record) {
        //update(record);
        return record;
    }

    public static ContentVersion getContentVersionForName(String title) {

        for (sObject o :sObjects){
            if (o.getSObjectType().getDescribe().getName() == 'ContentVersion'){
                ContentVersion cv = (ContentVersion)o;
                if (cv.Title == title){
                    return cv;
                }
            }
            
        }

        // ContentVersion cv = new ContentVersion();
        // cv.Title = title;

        return null;
    }

    public static ContentVersion getContentVersionForId(String Id) {

        for (sObject o :sObjects){
            if (o.getSObjectType().getDescribe().getName() == 'ContentVersion'){
                ContentVersion cv = (ContentVersion)o;
                if (cv.Id == Id){
                    return cv;
                }
            }
            
        }
        return null;
    }

    public ContentVersion getContentVersion(String contentVersionId){
        ContentVersion conDoc = getContentVersionForId(contentVersionId);
        return conDoc;
    }

    public ContentWorkspace getContentWorkSpace(String workSpaceLibraryName){
        ContentWorkspace libraryContentWorkSpace = new ContentWorkspace();
        libraryContentWorkSpace.Id = '0585j000001MJAsAAO';
        return libraryContentWorkSpace;
    }

    public ContentFolder getLibraryContentFolder(String WorkSpaceId){
        ContentFolder libraryContentFolder = new ContentFolder();
        libraryContentFolder.Id = '07H5j000000LkuaEAC';
        return libraryContentFolder;
    }

    public ContentFolder getContentFolder(String contentFolderName){
        ContentFolder folder = new ContentFolder();
        folder.Id = '07H5j000000LkufEAC';
        folder.Name = contentFolderName;
        return folder;
    }

    public ContentFolderMember getContentFolderMember(ContentFolder libraryContentFolder){
        // ContentFolderMember cfm = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: libraryContentFolder.Id];
        // cfm.ParentContentFolderId = contentFolder.Id;
        ContentFolderMember cfm = new ContentFolderMember();
        cfm.Id = '333';

        return cfm;
    }
}
