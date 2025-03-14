public with sharing class MetadataUtils {

    public static String getSessionId(){
        String sessionId = '';
        PageReference sessionPage = Page.SessionId;
        String vfContent = sessionPage.getContent().toString();
        /*String tempSessionId = vfContent.substringAfter('Start_Of_Session_Id');
        sessionId = tempSessionId.substringBeforeLast('End_Of_Session_Id');*/
        Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length();
        Integer endP   = vfContent.indexOf('End_Of_Session_Id');
        sessionId      = vfContent.substring(startP, endP);
        return sessionId;
        // session if between strat n end so eith use subsstirng index
    }

    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }

    /*now we will write example for list the metada 
    public MetadataService.FileProperties[] listMetadata(MetadataService.ListMetadataQuery[] queries,Double asOfVersion) {
        MetadataService.listMetadata_element request_x = new MetadataService.listMetadata_element();
        request_x.queries = queries;
        request_x.asOfVersion = asOfVersion;
        MetadataService.listMetadataResponse_element response_x;
        Map<String, MetadataService.listMetadataResponse_element> response_map_x = new Map<String, MetadataService.listMetadataResponse_element>();
        response_map_x.put('response_x', response_x);
        WebServiceCallout.invoke(
          this,
          request_x,
          response_map_x,
          new String[]{endpoint_x,
          '',
          SOAP_M_URI,
          'listMetadata',
          SOAP_M_URI,
          'listMetadataResponse',
          'MetadataService.listMetadataResponse_element'}
        );
        response_x = response_map_x.get('response_x');
        return response_x.result;
    }
*/
    // here this method will accep the query form MetadataService.ListMetadataQuery[]
      /*
    public class ListMetadataQuery {
        public String folder;
        public String type_x;
        private String[] folder_type_info = new String[]{'folder',SOAP_M_URI,null,'0','1','false'};
        private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'folder','type_x'};
    }
        */

    // in this method we need to send the folder and type_x , folder for dashboard or reports
    //type_X is metadata type

    public static void getlistmetadta(){
        //first step create the service 

        MetadataService.MetadataPort service=createService();
        //since ListMetadataQuery[] is under MetadataService
        List<MetadataService.ListMetadataQuery> query=new List<MetadataService.ListMetadataQuery>();
        // now we have to initialize this type/-x
        MetadataService.ListMetadataQuery query1=new  MetadataService.ListMetadataQuery();
        query1.type_x='Profile';
        query.add(query1);

        MetadataService.ListMetadataQuery query2=new  MetadataService.ListMetadataQuery();
        query2.type_x='CustomObject';
        query.add(query2);

        //now this method MetadataService.FileProperties[] is accepting the query of metadata and version

       List<MetadataService.FileProperties> prop= service.listMetadata(query,60);

        System.debug(System.JSON.serializePretty(prop));


    }
    /*
      public MetadataService.IReadResult readMetadata(String type_x,String[] fullNames) {
            MetadataService.readMetadata_element request_x = new MetadataService.readMetadata_element();
            request_x.type_x = type_x;
            request_x.fullNames = fullNames;
            MetadataService.IReadResponseElement response_x;
            Map<String, MetadataService.IReadResponseElement> response_map_x = new Map<String, MetadataService.IReadResponseElement>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              SOAP_M_URI,
              'readMetadata',
              SOAP_M_URI,
              'readMetadataResponse',
              'MetadataService.read' + type_x + 'Response_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.getResult();
        }
    */

    public static void readmetadata(){
       
        
        //System.debug(System.JSON.serializePretty(profileDetails));
         //readMetadata - this get the metadata type and its list name
         MetadataService.MetadataPort service=createService();
         String Metadatatype='Profile';
         List<String> metadatatypename=new List<String>();
         metadatatypename.add('Admin');

         // this iwllbe saved on IReadResult

         /*
         public interface IReadResult {
        MetadataService.Metadata[] getRecords();
    }


        */

    

        /*
            MetadataService.IReadResult result = service.readMetadata('Profile', itemList);
            MetadataService.Profile profileDetails = (MetadataService.Profile) result.getRecords().get(0);
        */
        // to get the result which sis stored in interface
        MetadataService.IReadResult result= service.readMetadata(Metadatatype,metadatatypename);

        // from interface we need to get the metadata values  -MetadataService.Metadata[] getRecords();
       // since this get recors has the list of values so get(0)
       // everymetadata  like profile /object will be extend the Metadata , so we can change to any metaaat type we need

       /*
       public class Profile extends Metadata {
        public String type = 'Profile';
        public String fullName;
        private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
        public MetadataService.ProfileApplicationVisibility[] applicationVisibilities;
        public MetadataService.ProfileCategoryGroupVisibility[] categoryGroupVisibilities;
        public MetadataService.ProfileApexClassAccess[] classAccesses;
        public Boolean custom;
        public MetadataService.ProfileCustomPermissions[] customPermissions;
        public String description;
        public MetadataService.ProfileExternalDataSourceAccess[] externalDataSourceAccesses;
        public MetadataService.ProfileFieldLevelSecurity[] fieldPermissions;
        public MetadataService.ProfileLayoutAssignment[] layoutAssignments;
        public MetadataService.ProfileLoginHours loginHours;
        public MetadataService.ProfileLoginIpRange[] loginIpRanges;
        public MetadataService.ProfileObjectPermissions[] objectPermissions;
        public MetadataService.ProfileApexPageAccess[] pageAccesses;
        public MetadataService.ProfileActionOverride[] profileActionOverrides;
        public MetadataService.ProfileRecordTypeVisibility[] recordTypeVisibilities;
        public MetadataService.ProfileTabVisibility[] tabVisibilities;
        public String userLicense;
        public MetadataService.ProfileUserPermission[] userPermissions;
        private String[] applicationVisibilities_type_info = new String[]{'applicationVisibilities',SOAP_M_URI,null,'0','-1','false'};
        private String[] categoryGroupVisibilities_type_info = new String[]{'categoryGroupVisibilities',SOAP_M_URI,null,'0','-1','false'};
        private String[] classAccesses_type_info = new String[]{'classAccesses',SOAP_M_URI,null,'0','-1','false'};
        private String[] custom_type_info = new String[]{'custom',SOAP_M_URI,null,'0','1','false'};
        private String[] customPermissions_type_info = new String[]{'customPermissions',SOAP_M_URI,null,'0','-1','false'};
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] externalDataSourceAccesses_type_info = new String[]{'externalDataSourceAccesses',SOAP_M_URI,null,'0','-1','false'};
        private String[] fieldPermissions_type_info = new String[]{'fieldPermissions',SOAP_M_URI,null,'0','-1','false'};
        private String[] layoutAssignments_type_info = new String[]{'layoutAssignments',SOAP_M_URI,null,'0','-1','false'};
        private String[] loginHours_type_info = new String[]{'loginHours',SOAP_M_URI,null,'0','1','false'};
        private String[] loginIpRanges_type_info = new String[]{'loginIpRanges',SOAP_M_URI,null,'0','-1','false'};
        private String[] objectPermissions_type_info = new String[]{'objectPermissions',SOAP_M_URI,null,'0','-1','false'};
        private String[] pageAccesses_type_info = new String[]{'pageAccesses',SOAP_M_URI,null,'0','-1','false'};
        private String[] profileActionOverrides_type_info = new String[]{'profileActionOverrides',SOAP_M_URI,null,'0','-1','false'};
        private String[] recordTypeVisibilities_type_info = new String[]{'recordTypeVisibilities',SOAP_M_URI,null,'0','-1','false'};
        private String[] tabVisibilities_type_info = new String[]{'tabVisibilities',SOAP_M_URI,null,'0','-1','false'};
        private String[] userLicense_type_info = new String[]{'userLicense',SOAP_M_URI,null,'0','1','false'};
        private String[] userPermissions_type_info = new String[]{'userPermissions',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName', 'applicationVisibilities','categoryGroupVisibilities','classAccesses','custom','customPermissions','description','externalDataSourceAccesses','fieldPermissions','layoutAssignments','loginHours','loginIpRanges','objectPermissions','pageAccesses','profileActionOverrides','recordTypeVisibilities','tabVisibilities','userLicense','userPermissions'};
    }
       */
      MetadataService.Profile profiledetails=(MetadataService.Profile)result.getRecords().get(0);
      MetadataService.ProfileLoginHours lh=profiledetails.loginHours;
      MetadataService.ProfileLoginIpRange[] ip=profiledetails.loginIpRanges;

      System.debug(profiledetails);
   System.debug(lh);
   System.debug(ip);

    }

    /* public MetadataService.SaveResult[] createMetadata(MetadataService.Metadata[] metadata) {
            MetadataService.createMetadata_element request_x = new MetadataService.createMetadata_element();
            request_x.metadata = metadata;
            MetadataService.createMetadataResponse_element response_x;
            Map<String, MetadataService.createMetadataResponse_element> response_map_x = new Map<String, MetadataService.createMetadataResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              SOAP_M_URI,
              'createMetadata',
              SOAP_M_URI,
              'createMetadataResponse',
              'MetadataService.createMetadataResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }

    */

    public static void createobject(){
        MetadataService.MetadataPort service=createService();
        /*
public class CustomObject extends Metadata {
        public String type = 'CustomObject';
        public String fullName;
        private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
        public MetadataService.ActionOverride[] actionOverrides;
        public Boolean allowInChatterGroups;
        public MetadataService.ArticleTypeChannelDisplay articleTypeChannelDisplay;
        public MetadataService.BusinessProcess[] businessProcesses;
        public String compactLayoutAssignment;
        public MetadataService.CompactLayout[] compactLayouts;
        public String customHelp;
        public String customHelpPage;
        public String customSettingsType;
        public String dataStewardGroup;
        public String dataStewardUser;
        public String deploymentStatus;
        public Boolean deprecated;
        public String description;
        public Boolean enableActivities;
        public Boolean enableBulkApi;
        public Boolean enableChangeDataCapture;
        public Boolean enableDivisions;
        public Boolean enableEnhancedLookup;
        public Boolean enableFeeds;
        public Boolean enableHistory;
        public Boolean enableReports;
        public Boolean enableSearch;
        public Boolean enableSharing;
        public Boolean enableStreamingApi;
        public String eventType;
        public String externalDataSource;
        public String externalName;
        public String externalRepository;
        public String externalSharingModel;
        public MetadataService.FieldSet[] fieldSets;
        public MetadataService.CustomField[] fields;
        public String gender;
        public MetadataService.HistoryRetentionPolicy historyRetentionPolicy;
        public Boolean household;
        public MetadataService.Index[] indexes;
        public String label;
        public MetadataService.ListView[] listViews;
        public MetadataService.CustomField nameField;
        public String pluralLabel;
        public Boolean recordTypeTrackFeedHistory;
        public Boolean recordTypeTrackHistory;
        public MetadataService.RecordType[] recordTypes;
        public MetadataService.SearchLayouts searchLayouts;
        public String sharingModel;
        public MetadataService.SharingReason[] sharingReasons;
        public MetadataService.SharingRecalculation[] sharingRecalculations;
        public String startsWith;
        public MetadataService.ValidationRule[] validationRules;
        public String visibility;
        public MetadataService.WebLink[] webLinks;
        private String[] actionOverrides_type_info = new String[]{'actionOverrides',SOAP_M_URI,null,'0','-1','false'};
        private String[] allowInChatterGroups_type_info = new String[]{'allowInChatterGroups',SOAP_M_URI,null,'0','1','false'};
        private String[] articleTypeChannelDisplay_type_info = new String[]{'articleTypeChannelDisplay',SOAP_M_URI,null,'0','1','false'};
        private String[] businessProcesses_type_info = new String[]{'businessProcesses',SOAP_M_URI,null,'0','-1','false'};
        private String[] compactLayoutAssignment_type_info = new String[]{'compactLayoutAssignment',SOAP_M_URI,null,'0','1','false'};
        private String[] compactLayouts_type_info = new String[]{'compactLayouts',SOAP_M_URI,null,'0','-1','false'};
        private String[] customHelp_type_info = new String[]{'customHelp',SOAP_M_URI,null,'0','1','false'};
        private String[] customHelpPage_type_info = new String[]{'customHelpPage',SOAP_M_URI,null,'0','1','false'};
        private String[] customSettingsType_type_info = new String[]{'customSettingsType',SOAP_M_URI,null,'0','1','false'};
        private String[] dataStewardGroup_type_info = new String[]{'dataStewardGroup',SOAP_M_URI,null,'0','1','false'};
        private String[] dataStewardUser_type_info = new String[]{'dataStewardUser',SOAP_M_URI,null,'0','1','false'};
        private String[] deploymentStatus_type_info = new String[]{'deploymentStatus',SOAP_M_URI,null,'0','1','false'};
        private String[] deprecated_type_info = new String[]{'deprecated',SOAP_M_URI,null,'0','1','false'};
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] enableActivities_type_info = new String[]{'enableActivities',SOAP_M_URI,null,'0','1','false'};
        private String[] enableBulkApi_type_info = new String[]{'enableBulkApi',SOAP_M_URI,null,'0','1','false'};
        private String[] enableChangeDataCapture_type_info = new String[]{'enableChangeDataCapture',SOAP_M_URI,null,'0','1','false'};
        private String[] enableDivisions_type_info = new String[]{'enableDivisions',SOAP_M_URI,null,'0','1','false'};
        private String[] enableEnhancedLookup_type_info = new String[]{'enableEnhancedLookup',SOAP_M_URI,null,'0','1','false'};
        private String[] enableFeeds_type_info = new String[]{'enableFeeds',SOAP_M_URI,null,'0','1','false'};
        private String[] enableHistory_type_info = new String[]{'enableHistory',SOAP_M_URI,null,'0','1','false'};
        private String[] enableReports_type_info = new String[]{'enableReports',SOAP_M_URI,null,'0','1','false'};
        private String[] enableSearch_type_info = new String[]{'enableSearch',SOAP_M_URI,null,'0','1','false'};
        private String[] enableSharing_type_info = new String[]{'enableSharing',SOAP_M_URI,null,'0','1','false'};
        private String[] enableStreamingApi_type_info = new String[]{'enableStreamingApi',SOAP_M_URI,null,'0','1','false'};
        private String[] eventType_type_info = new String[]{'eventType',SOAP_M_URI,null,'0','1','false'};
        private String[] externalDataSource_type_info = new String[]{'externalDataSource',SOAP_M_URI,null,'0','1','false'};
        private String[] externalName_type_info = new String[]{'externalName',SOAP_M_URI,null,'0','1','false'};
        private String[] externalRepository_type_info = new String[]{'externalRepository',SOAP_M_URI,null,'0','1','false'};
        private String[] externalSharingModel_type_info = new String[]{'externalSharingModel',SOAP_M_URI,null,'0','1','false'};
        private String[] fieldSets_type_info = new String[]{'fieldSets',SOAP_M_URI,null,'0','-1','false'};
        private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
        private String[] gender_type_info = new String[]{'gender',SOAP_M_URI,null,'0','1','false'};
        private String[] historyRetentionPolicy_type_info = new String[]{'historyRetentionPolicy',SOAP_M_URI,null,'0','1','false'};
        private String[] household_type_info = new String[]{'household',SOAP_M_URI,null,'0','1','false'};
        private String[] indexes_type_info = new String[]{'indexes',SOAP_M_URI,null,'0','-1','false'};
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
        private String[] listViews_type_info = new String[]{'listViews',SOAP_M_URI,null,'0','-1','false'};
        private String[] nameField_type_info = new String[]{'nameField',SOAP_M_URI,null,'0','1','false'};
        private String[] pluralLabel_type_info = new String[]{'pluralLabel',SOAP_M_URI,null,'0','1','false'};
        private String[] recordTypeTrackFeedHistory_type_info = new String[]{'recordTypeTrackFeedHistory',SOAP_M_URI,null,'0','1','false'};
        private String[] recordTypeTrackHistory_type_info = new String[]{'recordTypeTrackHistory',SOAP_M_URI,null,'0','1','false'};
        private String[] recordTypes_type_info = new String[]{'recordTypes',SOAP_M_URI,null,'0','-1','false'};
        private String[] searchLayouts_type_info = new String[]{'searchLayouts',SOAP_M_URI,null,'0','1','false'};
        private String[] sharingModel_type_info = new String[]{'sharingModel',SOAP_M_URI,null,'0','1','false'};
        private String[] sharingReasons_type_info = new String[]{'sharingReasons',SOAP_M_URI,null,'0','-1','false'};
        private String[] sharingRecalculations_type_info = new String[]{'sharingRecalculations',SOAP_M_URI,null,'0','-1','false'};
        private String[] startsWith_type_info = new String[]{'startsWith',SOAP_M_URI,null,'0','1','false'};
        private String[] validationRules_type_info = new String[]{'validationRules',SOAP_M_URI,null,'0','-1','false'};
        private String[] visibility_type_info = new String[]{'visibility',SOAP_M_URI,null,'0','1','false'};
        private String[] webLinks_type_info = new String[]{'webLinks',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName', 'actionOverrides','allowInChatterGroups','articleTypeChannelDisplay','businessProcesses','compactLayoutAssignment','compactLayouts','customHelp','customHelpPage','customSettingsType','dataStewardGroup','dataStewardUser','deploymentStatus','deprecated','description','enableActivities','enableBulkApi','enableChangeDataCapture','enableDivisions','enableEnhancedLookup','enableFeeds','enableHistory','enableReports','enableSearch','enableSharing','enableStreamingApi','eventType','externalDataSource','externalName','externalRepository','externalSharingModel','fieldSets','fields','gender','historyRetentionPolicy','household','indexes','label','listViews','nameField','pluralLabel','recordTypeTrackFeedHistory','recordTypeTrackHistory','recordTypes','searchLayouts','sharingModel','sharingReasons','sharingRecalculations','startsWith','validationRules','visibility','webLinks'};
    }
        */


        // create custom object first entr details u need

        MetadataService.CustomObject customObject=new MetadataService.CustomObject();

        customObject.label = 'Invoice';
        customObject.pluralLabel = 'Invoices';
        customObject.fullName = customObject.label.deleteWhitespace()+'__c';
        customObject.enableHistory = true;
        customObject.enableActivities = true;
        customObject.enableSearch = true;
        customObject.enableReports = true;
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';

        // now we have to craete a name feild - like account name - will be defult feild when we craete object ,
        //similarly we ned to create here

        /*
        public class CustomField extends Metadata {
        public String type = 'CustomField';
        public String fullName;
        private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
        public String businessOwnerGroup;
        public String businessOwnerUser;
        public String businessStatus;
        public Boolean caseSensitive;
        public String customDataType;
        public String defaultValue;
        public String deleteConstraint;
        public Boolean deprecated;
        public String description;
        public String displayFormat;
        public Boolean displayLocationInDecimal;
        public Boolean encrypted;
        public Boolean escapeMarkup;
        public String externalDeveloperName;
        public Boolean externalId;
        public String fieldManageability;
        public String formula;
        public String formulaTreatBlanksAs;
        public String inlineHelpText;
        public Boolean isConvertLeadDisabled;
        public Boolean isFilteringDisabled;
        public Boolean isNameField;
        public Boolean isSortingDisabled;
        public String label;
        public Integer length;
        public MetadataService.LookupFilter lookupFilter;
        public String maskChar;
        public String maskType;
        public String metadataRelationshipControllingField;
        public Boolean populateExistingRows;
        public Integer precision;
        public String referenceTargetField;
        public String referenceTo;
        public String relationshipLabel;
        public String relationshipName;
        public Integer relationshipOrder;
        public Boolean reparentableMasterDetail;
        public Boolean required;
        public Boolean restrictedAdminField;
        public Integer scale;
        public String securityClassification;
        public Integer startingNumber;
        public Boolean stripMarkup;
        public String summarizedField;
        public MetadataService.FilterItem[] summaryFilterItems;
        public String summaryForeignKey;
        public String summaryOperation;
        public Boolean trackFeedHistory;
        public Boolean trackHistory;
        public Boolean trackTrending;
        public String type_x;
        public Boolean unique;
        public MetadataService.ValueSet valueSet;
        public Integer visibleLines;
        public Boolean writeRequiresMasterRead;
        private String[] businessOwnerGroup_type_info = new String[]{'businessOwnerGroup',SOAP_M_URI,null,'0','1','false'};
        private String[] businessOwnerUser_type_info = new String[]{'businessOwnerUser',SOAP_M_URI,null,'0','1','false'};
        private String[] businessStatus_type_info = new String[]{'businessStatus',SOAP_M_URI,null,'0','1','false'};
        private String[] caseSensitive_type_info = new String[]{'caseSensitive',SOAP_M_URI,null,'0','1','false'};
        private String[] customDataType_type_info = new String[]{'customDataType',SOAP_M_URI,null,'0','1','false'};
        private String[] defaultValue_type_info = new String[]{'defaultValue',SOAP_M_URI,null,'0','1','false'};
        private String[] deleteConstraint_type_info = new String[]{'deleteConstraint',SOAP_M_URI,null,'0','1','false'};
        private String[] deprecated_type_info = new String[]{'deprecated',SOAP_M_URI,null,'0','1','false'};
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] displayFormat_type_info = new String[]{'displayFormat',SOAP_M_URI,null,'0','1','false'};
        private String[] displayLocationInDecimal_type_info = new String[]{'displayLocationInDecimal',SOAP_M_URI,null,'0','1','false'};
        private String[] encrypted_type_info = new String[]{'encrypted',SOAP_M_URI,null,'0','1','false'};
        private String[] escapeMarkup_type_info = new String[]{'escapeMarkup',SOAP_M_URI,null,'0','1','false'};
        private String[] externalDeveloperName_type_info = new String[]{'externalDeveloperName',SOAP_M_URI,null,'0','1','false'};
        private String[] externalId_type_info = new String[]{'externalId',SOAP_M_URI,null,'0','1','false'};
        private String[] fieldManageability_type_info = new String[]{'fieldManageability',SOAP_M_URI,null,'0','1','false'};
        private String[] formula_type_info = new String[]{'formula',SOAP_M_URI,null,'0','1','false'};
        private String[] formulaTreatBlanksAs_type_info = new String[]{'formulaTreatBlanksAs',SOAP_M_URI,null,'0','1','false'};
        private String[] inlineHelpText_type_info = new String[]{'inlineHelpText',SOAP_M_URI,null,'0','1','false'};
        private String[] isConvertLeadDisabled_type_info = new String[]{'isConvertLeadDisabled',SOAP_M_URI,null,'0','1','false'};
        private String[] isFilteringDisabled_type_info = new String[]{'isFilteringDisabled',SOAP_M_URI,null,'0','1','false'};
        private String[] isNameField_type_info = new String[]{'isNameField',SOAP_M_URI,null,'0','1','false'};
        private String[] isSortingDisabled_type_info = new String[]{'isSortingDisabled',SOAP_M_URI,null,'0','1','false'};
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'0','1','false'};
        private String[] length_type_info = new String[]{'length',SOAP_M_URI,null,'0','1','false'};
        private String[] lookupFilter_type_info = new String[]{'lookupFilter',SOAP_M_URI,null,'0','1','false'};
        private String[] maskChar_type_info = new String[]{'maskChar',SOAP_M_URI,null,'0','1','false'};
        private String[] maskType_type_info = new String[]{'maskType',SOAP_M_URI,null,'0','1','false'};
        private String[] metadataRelationshipControllingField_type_info = new String[]{'metadataRelationshipControllingField',SOAP_M_URI,null,'0','1','false'};
        private String[] populateExistingRows_type_info = new String[]{'populateExistingRows',SOAP_M_URI,null,'0','1','false'};
        private String[] precision_type_info = new String[]{'precision',SOAP_M_URI,null,'0','1','false'};
        private String[] referenceTargetField_type_info = new String[]{'referenceTargetField',SOAP_M_URI,null,'0','1','false'};
        private String[] referenceTo_type_info = new String[]{'referenceTo',SOAP_M_URI,null,'0','1','false'};
        private String[] relationshipLabel_type_info = new String[]{'relationshipLabel',SOAP_M_URI,null,'0','1','false'};
        private String[] relationshipName_type_info = new String[]{'relationshipName',SOAP_M_URI,null,'0','1','false'};
        private String[] relationshipOrder_type_info = new String[]{'relationshipOrder',SOAP_M_URI,null,'0','1','false'};
        private String[] reparentableMasterDetail_type_info = new String[]{'reparentableMasterDetail',SOAP_M_URI,null,'0','1','false'};
        private String[] required_type_info = new String[]{'required',SOAP_M_URI,null,'0','1','false'};
        private String[] restrictedAdminField_type_info = new String[]{'restrictedAdminField',SOAP_M_URI,null,'0','1','false'};
        private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
        private String[] securityClassification_type_info = new String[]{'securityClassification',SOAP_M_URI,null,'0','1','false'};
        private String[] startingNumber_type_info = new String[]{'startingNumber',SOAP_M_URI,null,'0','1','false'};
        private String[] stripMarkup_type_info = new String[]{'stripMarkup',SOAP_M_URI,null,'0','1','false'};
        private String[] summarizedField_type_info = new String[]{'summarizedField',SOAP_M_URI,null,'0','1','false'};
        private String[] summaryFilterItems_type_info = new String[]{'summaryFilterItems',SOAP_M_URI,null,'0','-1','false'};
        private String[] summaryForeignKey_type_info = new String[]{'summaryForeignKey',SOAP_M_URI,null,'0','1','false'};
        private String[] summaryOperation_type_info = new String[]{'summaryOperation',SOAP_M_URI,null,'0','1','false'};
        private String[] trackFeedHistory_type_info = new String[]{'trackFeedHistory',SOAP_M_URI,null,'0','1','false'};
        private String[] trackHistory_type_info = new String[]{'trackHistory',SOAP_M_URI,null,'0','1','false'};
        private String[] trackTrending_type_info = new String[]{'trackTrending',SOAP_M_URI,null,'0','1','false'};
        private String[] type_x_type_info = new String[]{'type',SOAP_M_URI,null,'0','1','false'};
        private String[] unique_type_info = new String[]{'unique',SOAP_M_URI,null,'0','1','false'};
        private String[] valueSet_type_info = new String[]{'valueSet',SOAP_M_URI,null,'0','1','false'};
        private String[] visibleLines_type_info = new String[]{'visibleLines',SOAP_M_URI,null,'0','1','false'};
        private String[] writeRequiresMasterRead_type_info = new String[]{'writeRequiresMasterRead',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName', 'businessOwnerGroup','businessOwnerUser','businessStatus','caseSensitive','customDataType','defaultValue','deleteConstraint','deprecated','description','displayFormat','displayLocationInDecimal','encrypted','escapeMarkup','externalDeveloperName','externalId','fieldManageability','formula','formulaTreatBlanksAs','inlineHelpText','isConvertLeadDisabled','isFilteringDisabled','isNameField','isSortingDisabled','label','length','lookupFilter','maskChar','maskType','metadataRelationshipControllingField','populateExistingRows','precision','referenceTargetField','referenceTo','relationshipLabel','relationshipName','relationshipOrder','reparentableMasterDetail','required','restrictedAdminField','scale','securityClassification','startingNumber','stripMarkup','summarizedField','summaryFilterItems','summaryForeignKey','summaryOperation','trackFeedHistory','trackHistory','trackTrending','type_x','unique','valueSet','visibleLines','writeRequiresMasterRead'};
    }

        */
        MetadataService.CustomField nameField = new MetadataService.CustomField();
        nameField.type_x = 'Text';
        nameField.label = 'Stripe Invoice ID';

        customObject.nameField = nameField;
        // this how we need to send -MetadataService.SaveResult[] createMetadata(MetadataService.Metadata[] metadata)
       List<MetadataService.Metadata> newmetadata=new List<MetadataService.Metadata>();
       newmetadata.add(customObject);
       
        List<MetadataService.SaveResult> res=service.createMetadata(newmetadata);

        System.debug(System.JSON.serializePretty(res));

    }
    public static void createcustomfeild(String objectApiName,String fielLabel){
        MetadataService.MetadataPort service     = createService();

        MetadataService.CustomField customField = new MetadataService.CustomField();
        // ObjectApiName.FieldApiName // Stripe UUID - StripeUUID
        customField.fullName         = objectApiName+'.'+fielLabel.deleteWhitespace()+'__c'; 
        // Account - Active => Account.Active__c
        customField.label            = fielLabel;
        customField.type_x           = 'Text';
        customField.description      = 'This is the field created from Salesforce Metadata API';
        customField.inlineHelpText   = 'This is the field created from Salesforce Metadata API';
        customField.length           = 120;
        customField.required         = false;
        customField.unique           = false;
        customField.externalId       = true;
        List<MetadataService.Metadata> metadata = new List<MetadataService.Metadata>();
        metadata.add(customField);
        List<MetadataService.SaveResult> results = service.createMetadata( metadata );
        System.debug(System.JSON.serializePretty(results));
    }
    public static void createLookupFields(){
        /*
        Lookup field
        Related to - > object name
        Relate dlist name -> related list label name that will be displayed under accoun-object

        relationshipName
        Thi sis the child relationship name

*/
        MetadataService.MetadataPort service     = createService();
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName                    = 'Invoice__c.StripeCustomer__c';
        customField.label                       = 'Stripe Customer';
        customField.type_x                      = 'Lookup'; // Lookup // MasterDetail
        customField.description                 = 'This is the Lookup field related to Account Object';
        customField.inlineHelpText              = 'This is the Lookup field related to Account Object';
        customField.relationshipLabel           = 'Stripe Invoices';
        customField.relationshipName            = 'StripeInvoices';
        customField.referenceTo                 = 'Account';
        
        List<MetadataService.SaveResult> results = service.createMetadata( new MetadataService.Metadata[] { customField } );
        System.debug(System.JSON.serializePretty(results));
    }


    public static void createPicklistField(List<String> options){
        
        MetadataService.MetadataPort service     = createService();

        MetadataService.CustomField customField = new MetadataService.CustomField();

        customField.fullName         = 'Invoice__c.InvoiceStatus__c';
        customField.label            = 'Invoice Status';
        customField.type_x           = 'Picklist';
        customField.description      = 'This is the picklist field created from Salesforce Metadata API';
        customField.inlineHelpText   = 'This is the picklist field created from Salesforce Metadata API';
        
        MetadataService.ValueSet valueSetDef          = new MetadataService.ValueSet();
        
        MetadataService.ValueSetValuesDefinition valueDefinition = new MetadataService.ValueSetValuesDefinition();
        
        List<MetadataService.CustomValue> values      = new List<MetadataService.CustomValue>();        
       /*
        List<String> options = new List<String>{
            'Open',
            'Closed',
            'Paid',
            'Voided',
            'Part-Paid'
        };
        MetadataUtils.createPicklistField(options);
    */
        for(String value : options){
            MetadataService.CustomValue customValue = new MetadataService.CustomValue();
            customValue.fullName  = value; 
            customValue.default_x = false;
            customValue.isActive  = true;
            customValue.label     = value;
            values.add(customValue);
        }
        valueDefinition.value              = values;
        valueDefinition.sorted             = true;
        
        valueSetDef.valueSetDefinition  = valueDefinition;
        valueSetDef.restricted          = true;
        
        customField.valueSet            = valueSetDef;
        customField.required            = true;
        List<MetadataService.SaveResult> results = service.createMetadata( new MetadataService.Metadata[] { customField } );
        System.debug(System.JSON.serializePretty(results));
        handleSaveResults(results.get(0));
    }

   /*
        List<String> names = new List<String>{'PS_ZoomToken'};
        MetadataUtils.deleteMetadataRecord('Google_Config', names);
    */
    public static void deleteMetadataRecord(String metadataType, List<String> names){
        MetadataService.MetadataPort service = createService();
        // MetadataObjectName.RecordName
        // Google_Config.PS_ZoomToken metadataType+'.'+name
        List<String> recordsToDelete = new List<String>();
        for(String name : names){
            recordsToDelete.add(metadataType+'.'+name);
        }
        MetadataService.DeleteResult[] deleteResults = service.deleteMetadata('CustomMetadata', recordsToDelete); //250
        handleDeleteResults(deleteResults.get(0));
    }
    public class MetadataServiceExamplesException extends Exception { }
    public static void handleSaveResults(MetadataService.SaveResult saveResult){
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        System.debug(' saveResult.errors \n '+saveResult.errors);
        if(saveResult.errors!=null){
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors) {
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                     ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            }
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
            
            System.debug(' Message  '+String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult){
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null){
            List<String> messages = new List<String>();
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                     ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    
    public static void handleUpsertResults(MetadataService.UpsertResult upsertResult){
        // Nothing to see?
        if(upsertResult==null || upsertResult.success)
            return;
        // Construct error message and throw an exception
        if(upsertResult.errors!=null){
            List<String> messages = new List<String>();
            messages.add(
                (upsertResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                'occured processing component ' + upsertResult.fullName + '.');
            for(MetadataService.Error error : upsertResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                     ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!upsertResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
}