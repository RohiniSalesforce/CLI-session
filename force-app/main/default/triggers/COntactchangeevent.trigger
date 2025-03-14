trigger COntactchangeevent on ContactChangeEvent (after insert) {
    for(ContactChangeEvent con: Trigger.new){
        // check the change type
        //now whene ver we chnage the contact it will trigger
        System.debug(System.JSON.serializePretty(con));
        //cdc chnages will be stored n eventbus , from there u have to get teh chage type is create oru[date]
        EventBus.ChangeEventHeader header = con.ChangeEventHeader;
        String changeEntity = header.entityName;
        String changeOperation = header.changeType;
        if(changeOperation == 'CREATE'){
            System.debug('Contact Created: ' + con.FirstName);
        } else if(changeOperation == 'UPDATE'){
            System.debug('Contact Updated: ' + con.FirstName);
        } else if(changeOperation == 'DELETE'){
            System.debug('Contact Deleted: ' + con.FirstName);
        } else if(changeOperation == 'UNDELETE'){
            System.debug('Contact Restored: ' + con.FirstName);
        }
    }
}