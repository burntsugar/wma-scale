public interface IContentVersionCrud {
    Database.SaveResult insertContentVersion(ContentVersion contentVersion); 
    List<ContentVersion> getContentVersion(ContentVersionFieldSelectors fieldName, String fieldValue);
    String getSelector(ContentVersionFieldSelectors selector);
}
