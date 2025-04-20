({
    handlemsg : function(component, event) {
         var msg= event.getParam("message");
         component.set("v.message", msg);
    },
    doInit : function(component) {
        var pageref = component.get("v.pageReference");
        if (pageref && pageref.state) {
            var id = pageref.state.c__id; // Retrieve the c__id parameter
            component.set("v.id", id);
        } else {
            console.error("PageReference or state is null. Ensure the component is used in a valid context.");
        }
    }
})