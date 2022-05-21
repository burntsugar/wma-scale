
sfdx force:mdapi:retrieve -k manifest/package.xml -u wmadh -r retrievedapex -w 10

sfdx force:mdapi:convert -r "retrievedapex/unpackaged 3" -d "src/apex-utils"


sfdx force:source:deploy -p src/apex-utils -u wmadh


sfdx force:apex:execute -u wmadh -f "src/apex-utils/main/default/classes/KickOff.cls"

sfdx force:limits:api:display -u wmadh


KickOff k = new KickOff();
ObjectInfoWrapper s = k.Go('WMA_Facility__c');
List<ObjectInfoRecordType> rts = s.objectInfoRecordTypes;
for (ObjectInfoRecordType rt : rts) {
    System.Debug(rt.objectAPIName);
    System.Debug(rt.recordTypeDeveloperName);
    System.Debug(rt.recordTypeId);
}
System.Debug(s);



KickOff k = new KickOff();
k.extractObjectInfoToCSV('WMA_Facility__c');

URL.getSalesforceBaseUrl().toExternalForm();

https://wise-impala-ns4i14-dev-ed.my.salesforce.com


select Layout.Name,LayoutId, ProfileId, Profile.Name from ProfileLayout where TableEnumOrId='01I5j000000BHZl'

select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl'


select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl' and Profile.Name = 'WMA Admin User'

select Layout.Name,LayoutId, ProfileId, Profile.Name, Layout.EntityDefinitionId from ProfileLayout where TableEnumOrId='01I5j000000BHZl' and Profile.Name in ('WMA Admin User','WMA Standard User','System Administrator')