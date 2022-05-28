@isTest
private class SaveToSalesforceTest {

    @isTest static void testone() {

        CRUDMock crud = new CRUDMock();

        String title = 'xxx';

        String headers = 'header-one, header-two';
        String rows = 'col-one, col-two';
        String content = headers +  + '\n';
        content += rows;

        SaveToSalesforce.setCrud(crud);
        SaveToSalesforce.save('my-queries','general', title, content);

        ContentVersion cv = CRUDMock.getContentVersionForName(title);

        System.assertEquals(title, cv.Title);
    }
}
