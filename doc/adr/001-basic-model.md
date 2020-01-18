# ADR: basic models for TYL
## Status
In Progress

## Context
The idea for this app spawned from reading the book Getting Things Done.

### Tasks
Everything that resembles some sort of task can be filed under one or a number of 'tags' that can represent basically anything to the user.
Tags can represent a place or tool required to perform a task, or simply a subject or keyword.
For example, the task 'Renew car registration' can be tagged with 'computer', 'phone', 'internet', 'car'.
Since it can be done online, if a user sits down at a computer or with a smartphone with internet access and opens up TYL to see what they can complete with the tools at hand, 'Renew car registration' will pop up and they can act to complete the task.
This was the basic genesis for this app.

### Snippets of information
But tags can also apply to things that aren't necessarily tasks to be completed.
Tags can be used to store and organize snippets of information that the user wants to have handy and doesn't expect to memorize.
For instance, to aid a user's gym routine they can add favorite ab exercises to the app and tag them 'abs' (among additional potential tags like 'gym' or 'workout').
A user can tag oven temperatures for baking various vegetables or dishes with the tag 'baking temps'.
A user can even use TYL to aid in their networking activities, or even to be a better friend, by creating snippets of information about a person and using that person's name as the tag.
For example, say the user wants to keep handy the names of someone's spouse, children, pets, their favorite hobbies, something they mentioned that would be a good gift idea for an upcoming birthday, the user can simply file all of this information under their friend's name.
In addition, something like a gift idea could be tagged both under a person's name and under 'gift ideas' so that the user can view their cards in different ways for different purposes.
For example, a user could drill down in tags to pull up all 'gift ideas' for 'george' and hide everything else under the 'george' tag.
Or when out holiday shopping, the user can simply pull up 'gift ideas' and all gift ideas recorded in cards will pop up in one place.

The initial work on this app was done before the snippets idea was formed so although some models have already been created and some functionality already exists, this ADR represents reverting back to basics and taking a slightly different approach.
Since not everything will be a task, the Task model will likely be completely phased out and replaced with something more generic (see card below), or used in a different way.

## Decision
Start with these models:

### tag
Tags represent anything that can be used to group tasks and snippets of information together.
Tags can have many cards (see below), and a card can have many tags.

### card
A card (think notecards) will be used to store snippets of information as well as tasks.
The task funcionality will come later, as for now cards will simply be made up of a title and optional description.
Cards will have many tags (and tags will have many cards).

### card-tags
This model will serve to connect cards to tags as the has_many :through table.

## Consequences
1. Will cards have to be checked for uniqueness by content? 
If so, by title? This seems too narrow. 
By a combination of title and other attributes?
2. To turn a card into a task do two new attributes need to be added? 
(task:boolean, completed:boolean)
Two attributes seems verbose for a simple checkbox.
3. Perhaps the task attribute can be an integer: 
0 => not a task
1 => not completed
2 => completed
4. Also perhaps overly verbose but with potential for extension of additional functionality, tasks can be their own model with a one-to-one relation with cards.
Cards would simply have a column for task_id and the task model would handle the lift of managing task completion with the potential to handle additional task-related attributes like order/priority, due date, etc.
5. Getting Things Done introduces the concept of an 'inbox'.
This is where (in TYL terminology), 'untagged' cards will live.
'inbox' was originally an attribute on the Task model, however, inbox can be inferred by the fact that a card has no tags, thus, can easily be the responsibility of the frontend, reducing complexity on the backend.
