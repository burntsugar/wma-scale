public interface IContentDocumentLinkCrud {

    Database.Saveresult insertContentDocumentLink(ContentDocumentLink contentDocumentLink);
    List<ContentDocumentLink> getContentDocumentLink(ContentDocumentLinkFieldSelectors fieldName, String fieldValue);
    String getSelector(ContentDocumentLinkFieldSelectors selector);
}
