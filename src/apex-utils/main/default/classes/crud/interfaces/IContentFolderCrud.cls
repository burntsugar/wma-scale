public interface IContentFolderCrud {
    Database.SaveResult insertContentFolder(ContentFolder contentFolder);
    List<ContentFolder> getContentFolder(ContentFolderFieldSelectors fieldName, String fieldValue);
    String getSelector(ContentFolderFieldSelectors selector);
}
