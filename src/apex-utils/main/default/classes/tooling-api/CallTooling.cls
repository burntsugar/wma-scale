public with sharing class CallTooling {
    public CallTooling() {


    }

    public static void call() {
        String baseURL='callout:toolingapi?';
        string sql='select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';
        string sql2 = sql.replace(' ', '+');
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(baseURL +'q='+sql2);
        req.setMethod('GET');

        Http h = new Http();
        HttpResponse res = h.send(req);
        system.debug(res.getBody());


        // if(string.isNotBlank(body))
        // {
        //     LayoutRecord data=LayoutRecord.parse(body);
            
        //     //get only layput name
        //     List<string> layouts=new List<string>();
        //     for(LayoutRecord.Record record:data.records)
        //     {
        //         if(!layouts.contains(record.Layout.Name))
        //         {
        //             layouts.add(string.valueOf(record.Layout.Name));
        //         }
        //     }
        //     return layouts;
        // }
        // return null;
    }

    // static List<string> getFields( string objectName,string layout ) {
    //     string layoutName=String.format('{0}-{1}', new String[]{objectName, layout}); 
    //     List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
    //     //get only layput name
    //     List<string> fields=new List<string>();
    //     Metadata.Layout layoutMd = (Metadata.Layout)layouts.get(0);
    //     for (Metadata.LayoutSection section : layoutMd.layoutSections) {
    //         for (Metadata.LayoutColumn column : section.layoutColumns) {
    //             if (column.layoutItems != null) {
    //                 for (Metadata.LayoutItem item : column.layoutItems) {
    //                     fields.add(item.field);
    //                 }
    //             }
    //         }
    //     }
    //     return fields;
    // }

}
