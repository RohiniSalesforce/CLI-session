trigger sapaccount on SAPAccount__e (after insert) {

System.debug(JSON.serializePretty(Trigger.New));


}