public interface IContentWorkSpaceCrud {
    Database.SaveResult insertContentWorkspace(ContentWorkspace contentWorkspace);
    List<ContentWorkspace> getContentWorkspace(ContentWorkSpaceFieldSelectors fieldName, String fieldValue);
    String getSelector(ContentWorkSpaceFieldSelectors selector);
}
