# RoomGreat

## Authors
* Vishal Satish

## Purpose
RoomGreat is a management app that allows roommates or family members to 
easily manage chores for their apartment or household. Arguing over 
who is supposed to take out the trash or do the dishes tonight are only a 
couple things that will become problems of the past.

## Features
* Create groups for each household/apartment being managed
* Add member profiles for each roommate/inhabitant
* List chores/duties from earliest to latest due with intervals for when
the responsibility should go to the next member (daily, every 2 weeks, 
never, etc.)

## Control Flow
* Users are presented a menu with a list of their created groups (homes/
apartments) and a button to add a new group
	* If the user selects the add button, they are presented a view where they 
	name the group, give it an address and picture, and add members to it
	* Members can be selected from a bank of existing profiles (i.e. from 
	other existing or old groups)
	* Or, new profiles can be created (with fields for name and picture)
* Users may click on the tab for members to view all member profiles that
have ever been created
	* Clicking on a member allows the user to view or edit it
* Upon clicking on a group (or clicking the done button for group creation), 
user is taken to the list of pending chores
* Clicking on the chores tab takes the user to a view that displays every 
active chore, including when it must be completed and who will be 
responsible for it, as well as an add button
	* the list is sorted from top to bottom by immediacy
	* If the user selects the add button, they are presented a view where they 
	name the chore, add a description, set an interval and due date, and add 
	which members will be part of the rotation & in which order
* Similar to the overall tab for members, there is another tab within each
group that lists only the members for that certain group

## Implementation
### Model
* Group.swift
* Member.swift
* Chore.swift

### View
* See Controller

### Controller
* AddGroupTableViewController
* GroupImageCell
* GroupNameCell
* GroupAddressCell
* GroupMemberCell
* GroupChooseMemberCell
* GroupTableViewController
* GroupTableViewCell
* ChooseMemberTableViewController
* ChooseMemberTableViewCell
* AddMemberViewController
* MemberCollectionViewController
* MemberCollectionViewCell
* MemberViewController
* GroupMemberCollectionViewController
* GroupMemberCollectionViewCell
* ChoreTableViewController
* ChoreTableViewCell
* AddChoreTableViewController
* ChoreMemberTableViewCell
* ChoreNameCell
* ChoreDueCell
* DatePickerCell
* AllDayCell
* RepeatCell
* EndRepeatCell
* DescriptionCell
* RepeatTableViewController
* EndRepeatTableViewController
* ReorderTableViewController
* ReorderTableViewCell
