public class ContentFolderMemberCrud {

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Update the ContentFolderMember.
    * Run this to parent files in a given folder to another folder in the workspace.
    * See https://developer.salesforce.com/docs/atlas.en-us.238.0.object_reference.meta/object_reference/sforce_api_objects_contentfoldermember.htm?q=contentFolderMember
    * 
    * Fails silently when null/invalid parameters passed unless Query all files permission is enabled. See https://help.salesforce.com/s/articleView?id=000353032&type=1
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    parentContentFolderId    String. Id of the source parent folder - such as a ContentWorkspace ContentFolder.
    * @param    contentFolderId    String. Id of the destination ContentFolder.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void updateContentFolderMember(String parentContentFolderId, String contentFolderId){
        List<ContentFolderMember> results = [Select Id, ChildRecordId, ParentContentFolderId from ContentFolderMember where ParentContentFolderId =: parentContentFolderId];

        for (ContentFolderMember c : results) {
            c.ParentContentFolderId = contentFolderId;
        }

        DBCrud.doUpdate(results);
        
    }
}
