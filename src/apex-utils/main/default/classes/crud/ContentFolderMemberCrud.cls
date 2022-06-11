public class ContentFolderMemberCrud {

    private final static String CONTENTFOLDERMEMBER_NAME = 'ContentFolderMember';

    public enum Selectors {
        ID,
        CHILDRECORDID,
        PARENTCONTENTFOLDERID
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Update the ContentFolderMember.
    * Run this to parent files in a given folder to another folder in the workspace.
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

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Get string value for a given selector.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    selector    Selectors. Field name selector.
    * @return    String value for selector.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static String getSelector(Selectors selector) {
        String slctor;
        switch on selector {
            when ID {
                slctor = 'Id';
            }
            when CHILDRECORDID {
                slctor = 'ChildRecordId';
            }
            when PARENTCONTENTFOLDERID {
                slctor = 'ParentContentFolderId';
            }
        }
        return slctor;
    }

    private static String makeExpression(Selectors selector, String value){
        String expression;
        switch on selector {
            when ID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
            when CHILDRECORDID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
            when PARENTCONTENTFOLDERID {
                expression = getSelector(selector) + '=' + '\'' + value + '\'';
            }
        }
        return expression;
    }
    
}
