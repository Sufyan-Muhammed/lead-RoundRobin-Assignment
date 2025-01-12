public with sharing class leadAssignmentHandler {
    
    public static void leadAssignmentWithRoundRobin(List<Lead> newLeads, String queueName) {
        List<String> userIds = new List<String>();
        
        
        Group queue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = :queueName LIMIT 1];
        if (queue == null) {
            return;
        }
        
        
        List<GroupMember> queueMembers = [
            SELECT UserOrGroupId 
            FROM GroupMember 
            WHERE GroupId = :queue.Id
        ];
        if (queueMembers.isEmpty()) {
            return;
        }
        
        
        for (GroupMember member : queueMembers) {
            userIds.add(member.UserOrGroupId);
        }
        
        
        RoundRobinCounter__c counter = [
            SELECT Id, QueueName__c, LastAssignedUserId__c 
            FROM RoundRobinCounter__c 
            WHERE QueueName__c = :queueName
            LIMIT 1
        ];
        if (counter == null) {
            counter = new RoundRobinCounter__c(QueueName__c = queueName, LastAssignedUserId__c = null);
        }
        
        Integer lastIndex = -1;
        
        
        if (counter.LastAssignedUserId__c != null) {
            lastIndex = userIds.indexOf(counter.LastAssignedUserId__c);
        }
        
        
        for (Lead newLead : newLeads) {
            Integer nextIndex = (lastIndex + 1) >= userIds.size() ? 0 : lastIndex + 1; 
            Id nextUserId = userIds[nextIndex]; 
            
            
            newLead.OwnerId = nextUserId;
            
            lastIndex = nextIndex;
        }
        
        
        counter.LastAssignedUserId__c = userIds[lastIndex];
        upsert counter;
    }
    
}