public interface IContentFolderMemberCrud {
    Database.SaveResult[] updateContentFolderMember(String parentContentFolderId, String contentFolderId);
}
