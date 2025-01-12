trigger leadTrigger on lead  (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        leadAssignmentHandler.leadAssignmentWithRoundRobin(trigger.new,'RR_User_Queues');
    }
}