public with sharing class CallTooling {
    public CallTooling() {


    }


    // private void callEndPoint(String baseUrl, String sql){
    //     sql = sql.replace(' ', '+');

    //     HttpRequest req = new HttpRequest();
    //     req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
    //     req.setHeader('Content-Type', 'application/json');
    //     req.setEndpoint(baseURL + 'q=' + sql);
    //     req.setMethod('GET');

    //     Http h = new Http();
    //     HttpResponse res = h.send(req);

    //     system.debug(res.getBody());

    //     if(string.isNotBlank(body))
    //     {
    //         LayoutRecord data=LayoutRecord.parse(body);
            
    //         //get only layput name
    //         List<string> layouts=new List<string>();
    //         for(LayoutRecord.Record record:data.records)
    //         {
    //             if(!layouts.contains(record.Layout.Name))
    //             {
    //                 layouts.add(string.valueOf(record.Layout.Name));
    //             }
    //         }
    //         return layouts;
    //     }
    // }

    public static String call() {
        String baseURL='callout:toolingapi?';
        string sql='select Layout.Name,LayoutId, ProfileId, Profile.Name, RecordTypeId, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId=\'01I5j000000BHZl\' and Profile.Name in (\'WMA Admin User\',\'WMA Standard User\',\'System Administrator\')';
        string sql2 = sql.replace(' ', '+');
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(baseURL +'q='+sql2);
        req.setMethod('GET');

        Http h = new Http();
        HttpResponse res = h.send(req);
        //system.debug(res.getBody());

        return res.getBody();

    }

    

}
