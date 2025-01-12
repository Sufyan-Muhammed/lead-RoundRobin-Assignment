# Lead Assignment Handler - Round Robin Logic

## Overview

The `leadAssignmentHandler` class provides a method to implement **Round Robin** lead assignment for Salesforce leads. It assigns new leads to a group of users in a queue based on the round-robin logic. The method ensures that each user in the group receives a fair and sequential distribution of leads.

## Key Features

- **Round Robin Lead Assignment**: Assigns leads to users in a queue in a circular (round-robin) manner, ensuring that each user receives a balanced number of leads.
- **Queue-based Assignment**: Leads are assigned to users within a specified queue, identified by the `queueName` parameter.
- **Persistent Last Assignment**: The class keeps track of the last user to whom a lead was assigned using a custom object (`RoundRobinCounter__c`), ensuring that the round-robin process continues from the correct user.

## Functionality

The class contains a method named `leadAssignmentWithRoundRobin` which:

1. **Retrieves the Queue**: It fetches the `Group` record that represents the specified queue using the provided `queueName`.
2. **Fetches Queue Members**: It retrieves all the users who are members of the given queue using the `GroupMember` object.
3. **Round Robin Assignment Logic**:
   - A custom object `RoundRobinCounter__c` is used to track the last assigned user for the queue. If no record exists, it creates a new record.
   - It uses the `LastAssignedUserId__c` field in `RoundRobinCounter__c` to determine where to start the next lead assignment.
   - Each new lead in the `newLeads` list is assigned to the next user in the round-robin order.
4. **Upserts the Round Robin Counter**: After assigning the leads, the class updates the `LastAssignedUserId__c` in `RoundRobinCounter__c` to track which user was assigned the last lead.

## Method Details

### `leadAssignmentWithRoundRobin(List<Lead> newLeads, String queueName)`

- **Parameters**:
  - `newLeads` (List<Lead>): A list of `Lead` records that need to be assigned to users.
  - `queueName` (String): The name of the queue to which leads should be assigned.
  
- **Returns**: 
  - None. The method updates the `OwnerId` of each `Lead` record in the `newLeads` list.

- **Logic**:
  - Retrieves the queue specified by `queueName`.
  - Fetches all users in the queue.
  - Uses a custom object `RoundRobinCounter__c` to track the last assigned user.
  - Iterates through the leads and assigns each one to the next user in the round-robin cycle.
  - Updates the `LastAssignedUserId__c` to reflect the last user to whom a lead was assigned.

## Requirements

- **Custom Object**: `RoundRobinCounter__c` with the following fields:
  - `QueueName__c` (Text): The name of the queue.
  - `LastAssignedUserId__c` (Lookup to User): The user who last received a lead.

- **Standard Objects**:
  - `Lead` (Standard Salesforce Object).
  - `Group` and `GroupMember` (Standard Salesforce Objects for queues).

## Example Usage

To assign leads to users in a queue, you can call the `leadAssignmentWithRoundRobin` method from any Apex code like this:

```apex
List<Lead> leadsToAssign = [SELECT Id FROM Lead WHERE Status = 'New'];
String queueName = 'SalesQueue';  // Replace with your actual queue name
leadAssignmentHandler.leadAssignmentWithRoundRobin(leadsToAssign, queueName);
