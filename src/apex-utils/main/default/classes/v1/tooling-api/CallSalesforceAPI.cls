public with sharing class CallSalesforceAPI {

    public static String call(String baseURL, String sql) {
       
        string encodedSql = sql.replace(' ', '+');
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(baseURL +'q='+encodedSql);
        req.setMethod('GET');

        Http h = new Http();
        HttpResponse res = h.send(req);
        return res.getBody();
    }

}
