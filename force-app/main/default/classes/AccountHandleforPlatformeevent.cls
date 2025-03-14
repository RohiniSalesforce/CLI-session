public with sharing class AccountHandleforPlatformeevent implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id, Name FROM Account');
    }

    public void execute(Database.BatchableContext bc, List<Account> records){
        Integer i = 100/0;
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}