trigger caseTrigger on Case (after insert) {

        casehandler.casehandlermethod(Trigger.new);
        
}