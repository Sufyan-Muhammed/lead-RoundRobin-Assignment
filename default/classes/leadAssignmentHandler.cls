public with sharing class leadAssignmentHandler {

    // public static void leadAssignmentWithRoundRobin(List<Lead> newLeads,String queueName){

        
    //     Group queue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = :queueName LIMIT 1];
    //     if (queue == null) {
    //         return;
    //     }

    //     List<GroupMember> queueMembers = [
    //         SELECT UserOrGroupId 
    //         FROM GroupMember 
    //         WHERE GroupId = :queue.Id
    //     ];

    //     if (queueMembers.isEmpty()) {
    //         return;
    //     }

        
    //     List<Id> userIds = new List<Id>();
    //     for (GroupMember member : queueMembers) {
    //         userIds.add(member.UserOrGroupId);
    //     }

        
    //     RoundRobinCounter__c counter = [select id,QueueName__c,LastAssignedUserId__c from RoundRobinCounter__c where QueueName__c = :queueName].size() == 1 ?[select id,QueueName__c,LastAssignedUserId__c from RoundRobinCounter__c where QueueName__c = :queueName]:new RoundRobinCounter__c(QueueName__c =queueName,LastAssignedUserId__c=null);

        


        
    //     Integer lastIndex = userIds.indexOf(counter.LastAssignedUserId__c);
    //     Integer nextIndex = (lastIndex + 1) % userIds.size();
    //     Id nextUserId = userIds[nextIndex];

        
    //     newLead.OwnerId = nextUserId;

        
    //     counter.LastAssignedUserId__c = nextUserId;
    //     upsert counter;

    // }
}