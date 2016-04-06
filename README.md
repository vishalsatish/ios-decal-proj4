# RoomGreat

## Authors
* Vishal Satish

## Purpose
RoomGreat is a management app that allows roommates or family members to easily 
manage chores and expenditures for their apartment or household. Arguing over 
who is supposed to take out the trash tonight or figuring out what bills are 
left to pay are only a couple things that will become problems of the past.

## Features
* Create groups for each household/apartment being managed
* Add member profiles for each roommate/inhabitant
* List chores/duties that cycle through each member daily, weekly, or by some 
other custom interval
* List pending expenses and designate who will be pitching in/how much
* Ability to reward (through accumulation of points) or punish (deduction of 
points, doing more chores, etc.) members based on completion or incompletion of
chores

## Control Flow
* Users are presented a menu with a list of their created groups (homes/
apartments) and buttons to add new or edit (rename, delete) existing groups
	* If the user selects the add button, they are presented a view where they 
	name the group and add members to it
	* Members can be selected from a bank of existing profiles (i.e. from other 
	existing or old groups)
	* Or, new profiles can be created (with fields for name and picture)
* Upon clicking on a group (or clicking the done button for group creation), 
user is taken to the "dashboard" for that group where they can view summaries 
for active chores, current expenditures, and member reward status
	* the dashboard is one of five main tabs which also include separate views 
	for chores, expenditures, rewards, and member profiles
* Clicking on the chores tab takes the user to a view that displays every 
active chore, including when it must be completed next and who will be 
responsible for it, as well as add and edit (delete chores) buttons
	* the list is sorted from top to bottom by immediacy
	* If the user selects the add button, they are presented a view where they 
	name the chore, add a description, set an interval (daily, weekly, custom), 
	set the point value, name the punishments (point deduction, extra chores, 
	custom), and add which members will be part of the rotation & in which order
	* when an existing chore is clicked on, a view displays all the associated 
	information, as well as an edit button to make changes to any of that info
		* most importantly, when it comes to the day or time that the chore should 
		be completed, a complete button will be visible
		* once the button is clicked on, the user will be asked whether the member 
		actually performed the task
			* if so, the number of points for that task will be added to the member's 
			total
			* if not, the user will be asked to select the other member that did the 
			task instead of the delegated person; points will be given to whoever 
			did the task and the listed punishments will be doled out against the 
			member originally responsible for the chore
		* if the chore remains neglected beyond the completion date/time, it will 
		be indicated as incomplete and remain at the top of the list until the 
		above "completion" actions are performed; the rotation will continue as 
		normal
* Clicking on the expenditures tab takes the user to a view that displays 
every active expense, including when it must be completed by and how much it 
costs, as well as add and edit (delete items) buttons
	* the list is sorted from top to bottom by immediacy
	* If the user selects the add button, they are presented with a view where 
	they name the expense, add a description, add a cost, and add which members 
	will be pitching in
		* the user may choose either to split the bill evenly among all involved 
		members or to manually give each member a cost, in which case the total 
		amount will be calculated automatically
	* upon selecting an item in the expenditures list, all the above information 
	will be present, as well as a complete button
	* If the complete button is not pressed before the due date, the expense will 
	be indicated as incomplete and remain at the top of the list until the button 
	is pressed
* Clicking on the rewards tab takes the user to a view that displays each 
member with a bar indicating their progress towards a full "reward", as well 
as a settings button
	* The settings button allows the user to set how many points are needed for 
	each member to receive a reward; this is by default set to 100
	* Each member (as a table entry) has next to them a "cookie" button that 
	allows the user to give them additional points with a reason attached (i.e. 
	Took care of Bob when he was sick.)
	* when the progress bar is filled, the bar right away starts filling again 
	and the member receives an addition to their "reward count"
* Clicking on the members tab takes the user to a view that displays every 
group member, including add (new members) and edit (delete members) buttons
	* Clicking on the add button brings the user to the same view they saw when 
	first adding new members in the group creation stage
	* If the user clicks on a member, they may view all their associated info 
	including: name, photo, chores they are responsible for (listed by group 
	if they are part of more than one), and cookies they have received
	* Each member view also has an edit button that allows the user to edit 
	and add certain information (name, photo, email, phone number, etc.)

## Implementation
### Model
* Group.swift
* Member.swift
* Chore.swift

### View
* GroupListTableView
* AddGroupView
* DashboardTableView
* ChoreTableView
* AddChoreView
* ExpenseTableView
* AddExpenseView
* RewardTableView
* AddCookieView
* MemberTableView
* AddMemberView

### Controller
* GroupListTableViewController
* AddGroupViewController
* DashboardTableViewController
* ChoreTableViewController
* AddChoreViewController
* ExpenseTableViewController
* AddExpenseViewController
* RewardTableViewController
* AddCookieViewController
* MemberTableViewController
* AddMemberViewController
