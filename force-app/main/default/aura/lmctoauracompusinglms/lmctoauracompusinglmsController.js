({
    handlemessage : function(component, event) {
        const message = event.getParam("LMSComponentAData");
        if(message) {
            
            component.set("v.messagerecieved", message.value);
        }
        console.log("Received message: " + JSON.stringify(event.getParam("message")));
    },
    inputhandler: function(component, event) {
        console.log(event.target.value);
        component.set("v.messagevalue", event.target.value);
    },
    Publish: function(component, event) {
       let msg = component.get("v.messagevalue");
       let message={
        LMSComponentAData:{
            value: msg
        }
       }
       component.find("SampleMessagingChannel").publish(message);
    }
})