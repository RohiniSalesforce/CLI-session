public class CustomMetadatypedeployment implements Metadata.DeployCallback{
    //some hard job id value to save he custom metadat queable job after deployme here
    public static final String JOB_ID = 'a0I0o00001MbaBJ';

    //to handle result of deployemet we are using this method
        public void handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext cont){
            if(result.status == Metadata.DeployStatus.Succeeded){

                System.debug(' success : 😍 '+ result);
            } else {
                /* 
                    TODO : Fire the Platform Event or Log the Error Message 
                */
                System.debug(' fail : 🥵 '+ result);
            }
        }

        //now to deploye the new cutsom meta datatype

public static void CreatecustomMedatatype(String fullName,String label,Map<String,Object> fieldWithValuesMap){
/* Step1 - Create the Custom Metadata Object from Metadata NameSpace */
Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
customMetadata.fullName = fullName; // sfdc_Config.PS_SalesforceToken
// API Name - Custom metadata Record
customMetadata.label 	= label; // 'Salesforce Token'

for(String key : fieldWithValuesMap.keySet()){

    /* Step2 - Create the CustomMetadataValue Object from Metadata NameSpace */
    Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();

    /* Step2.1 - Prepare the field values */
    customField.field = key;
    customField.value = fieldWithValuesMap.get(key); 

    /* Step2.2 - Add the field values to the custom metadata */
    customMetadata.values.add(customField);
}


/* Step3 - Create the DeployContainer Object from Metadata NameSpace */
Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

/* Step4 - Add the metadata under container */
mdContainer.addMetadata(customMetadata);

/* 
    Step5
    TODO: Deploy the metadata if test is not running using Operations  
 */
Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, new CustomMetadatypedeployment());


}



}