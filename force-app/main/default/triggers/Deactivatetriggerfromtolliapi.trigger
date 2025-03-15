trigger Deactivatetriggerfromtolliapi on Account (before insert) {
    System.debug(JSON.serializePretty(Trigger.New));
}