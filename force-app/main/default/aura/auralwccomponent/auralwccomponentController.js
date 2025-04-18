({
    handlemsg : function(component, event) {
         var msg= event.getParam("message");
         component.set("v.message", msg);
    }
})