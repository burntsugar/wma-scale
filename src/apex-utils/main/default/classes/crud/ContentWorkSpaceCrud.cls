public class ContentWorkSpaceCrud {

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentWorkspace record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    contentWorkspace    ContentWorkspace instance from which to create the record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void insertContentWorkspace(ContentWorkspace contentWorkspace){

        DBCrud.doInsert(contentWorkspace);
    }

    /**
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * Creates a ContentWorkspace record.
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    name    String. Name of the workspace.
    * @param    developerName    String. Developer name of the workspace.
    * @return    ContentWorkspace sObject record.
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static ContentWorkspace insertContentWorkspace(String name, String developerName){
        ContentWorkspace cw = new ContentWorkspace();
        cw.Name = name;
        cw.DeveloperName = developerName;

        DBCrud.doInsert(cw);

        return cw;
    }
    
}
