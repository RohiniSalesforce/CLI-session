trigger deact1 on Account (before insert) {
    
        System.debug(JSON.serializePretty(Trigger.New));
    
}