public with sharing class GoNow {
    public GoNow() {

    //     CRUD crud = new CRUD();

    //     String title = 'catchpole';

    //     String headers = 'header-one, header-two';
    //     String rows = 'col-one, col-two';
    //     String content = headers +  + '\n';
    //     content += rows;

    //    // SaveToSalesforce.setCrud(crud);
    //     SaveToSalesforce.save('my-queries','general', title, content);

    //     ContentVersion cv = crud.getContentVersionByTitle(title);

    //     System.Debug(cv);

    String headers = 'header-one, header-two';
    String rows = 'col-one, col-two';
    String content = headers +  + '\n';
    content += rows;

    CRUD crud = new Crud();

    ContentVersion cv = new ContentVersion();
    cv.ContentLocation = 'S'; 
    cv.Title = 'radical'; 
    cv.PathOnClient = 'radical.csv';
    cv.VersionData = Blob.valueOf(content);

    crud.doInsert(cv);

    System.Debug('AFTER:::'+cv);

    }
}
