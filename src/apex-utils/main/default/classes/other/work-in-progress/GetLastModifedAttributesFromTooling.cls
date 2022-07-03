public class GetLastModifedAttributesFromTooling {

    private static final String BASE_URL_TOOLING='callout:toolingapi?';
    // private static final string TOOLING_ENTITYDEFINITION_SQL='SELECT EntityDefinition.DurableId, EntityDefinition.QualifiedAPIName, DeveloperName, CreatedDate, LastModifiedDate, TableEnumOrId FROM CustomField WHERE EntityDefinition.QualifiedAPIName = \'Account\'';

    public static void calloutToProfileToolingAPI(){

        // String body = CallSalesforceAPI.call(BASE_URL_TOOLING, TOOLING_ENTITYDEFINITION_SQL);

        // if(string.isNotBlank(body))
        // {
        //     System.Debug(body);
        // }

        List<String> objectAPINames = new List<String> {'Account','Contact'};

        List<EntityDef> entityDefs = new List<EntityDef>();
        for (String apiName : objectAPINames){
            entityDefs.add(call(apiName));
        }

        System.debug('SIZEOF::: ' + entityDefs.size());
        System.debug('WHAT::: DeveloperName ' + entityDefs.get(0).records.get(0).DeveloperName);
        System.debug('WHAT::: entityDefinition ' + entityDefs.get(0).records.get(0).entityDefinition.QualifiedAPIName);
        System.debug('WHAT::: DeveloperName ' + entityDefs.get(0).records.get(1).DeveloperName);
        System.debug('WHAT::: entityDefinition ' + entityDefs.get(0).records.get(1).entityDefinition.QualifiedAPIName);

        

    }

    private static EntityDef call(string entityDefQualAPIName){

        System.Debug('BARK AT DA MOON');

        string TOOLING_ENTITYDEFINITION_SQL='SELECT EntityDefinition.DurableId, EntityDefinition.QualifiedAPIName, DeveloperName, CreatedDate, LastModifiedDate, TableEnumOrId FROM CustomField WHERE EntityDefinition.QualifiedAPIName = ';

        // string TOOLING_ENTITYDEFINITION_SQL='SELECT EntityDefinition.DurableId, EntityDefinition.QualifiedAPIName, DeveloperName, CreatedDate, LastModifiedDate, TableEnumOrId, (SELECT QualifiedAPIName FROM CustomFields) FROM CustomField WHERE EntityDefinition.QualifiedAPIName = ';

        string whereCriteria = '\'' + entityDefQualAPIName + '\'';
        string sql = TOOLING_ENTITYDEFINITION_SQL + whereCriteria;

        String body = CallSalesforceAPI.call(BASE_URL_TOOLING, sql);

        EntityDef data;
        if(string.isNotBlank(body))
        {
            System.Debug(body);

            data=EntityDef.parse(body);
        }

        return data;

    }
}
