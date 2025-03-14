trigger Order on Order (after insert) {

    ordertriggerhandler.publishevent(Trigger.New);

}