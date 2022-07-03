
KickOff k = new KickOff();
k.extractObjectInfoToCSV('WMA_Facility__c','Fields for Record Type', 'WMA', 'my-queries', 'general');

public void extractObjectInfoToCSV(String objectAPIName, String documentTitle, String envName, String workspaceLibraryName, String environmentContentFolderName){


sfdx force:mdapi:retrieve -k manifest/package.xml -u wmadh -r retrievedapex -w 10

sfdx force:mdapi:convert -r "retrievedapex/unpackaged 3" -d "src/apex-utils"


sfdx force:source:deploy -p src/apex-utils -u wmadh


sfdx force:apex:execute -u wmadh -f "src/apex-utils/main/default/classes/KickOff.cls"

sfdx force:limits:api:display -u wmadh

sfdx force:apex:test:run -u wmadh -s "crud" -c -v --json -r human


KickOff k = new KickOff();
ObjectInfoWrapper s = k.Go('WMA_Facility__c');
List<ObjectInfoRecordType> rts = s.objectInfoRecordTypes;
for (ObjectInfoRecordType rt : rts) {
    System.Debug(rt.objectAPIName);
    System.Debug(rt.recordTypeDeveloperName);
    System.Debug(rt.recordTypeId);
}
System.Debug(s);

GoNow go = new GoNow();

KickOff k = new KickOff();
k.extractObjectInfoToCSV('WMA_Facility__c');

GetInfo.getObjectInfo('WMA_Facility__c');


KickOff k = new KickOff();
k.GetLastModifedAttr();


Type customType = Type.forName('WMA_Facility__c');
sObject instance = (sObject)customType.newInstance();
Schema.DescribeSObjectResult R = instance.getSObjectType().getDescribe();
ObjectInfoExtract o = new ObjectInfoExtract();
List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
System.Debug(RT.get(0).getName() + ' ' + RT.get(0).isMaster() + ' ' + RT.get(0).getRecordTypeId());
System.Debug(RT.get(1).getName() + ' ' + RT.get(1).isMaster() + ' ' + RT.get(1).getRecordTypeId());



URL.getSalesforceBaseUrl().toExternalForm();

https://wise-impala-ns4i14-dev-ed.my.salesforce.com


select Layout.Name,LayoutId, ProfileId, Profile.Name from ProfileLayout where TableEnumOrId='01I5j000000BHZl'

select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl'


select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl' and Profile.Name = 'WMA Admin User'

select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl' and Profile.Name in ('WMA Admin User','WMA Standard User','System Administrator')


List<SObjectField> allFields = SObjectType.WMA_Facility__c.fields.getMap().values();


Schema.DescribeFieldResult F = WMA_Facility__c.fields.WMA_Facility_Location_Type__c.getDescribe();
Schema.sObjectField T = F.getSObjectField();
System.Debug(T);
System.Debug(F.getLabel());
System.Debug(F.getDefaultvalue());
System.Debug(F.isCustom());
System.Debug(F.isNameField());
System.Debug(F.isNillable());
System.Debug(F.getType());


    String getLabel();
     String getDefaultValue();
     boolean getIsCustom();
     boolean getIsNameField();
     boolean getIsNillable();
     String getFieldDataType();
     String getFieldLength();
     String getIsAutoNumber();
     boolean getIsCalculated();
     boolean getIsDependentPicklist();
     boolean getIsExternalId();
     boolean getIsIdLookup();
     boolean getIsUnique();
     String getScale();
     String getPrecision();

     List<String> addToPicklistValues();

