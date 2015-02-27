# HT Event Management System

## Introduction
This is my version of a simple Events Management System. The idea of this system is very simple. Please read on further for a brief summary of how my system work.

## How does it work?
When a user wishes to create an event, he will have to sign up an account or login. Afterwhich, he can choose what kind of event he would like to create. There will be several types available, and he may choose to add his own fields. Should the type of event not be found in the list, the user may choose to create his custom template for future purposes. He may also edit any other templates he currently have.

When the event is created, other users may sign up for it. Other users will have to sign up or login as well to join the event. The owner of the event may then view his current event, and check the number of people joining.

## Architecture
The current architecture is based on the following. Attributes are omited, only table names are stated with the relationships.

- **Account** has many **RSVP**, **RSVP** has one **Account**
- **Account** has many **Ownership**, **Ownership** has one **Account**
- **Account** has many **Template**, **Template** has one **Account**
- **Account** has many **Profile**, **Profile** has one **Account**
- **Event** has many **Ownership**, **Ownership** has one **Event**
- **Event** has many **RSVP**, **RSVP** has one **Event**
- **Event** has many **Topic**, **Topic** has one **Event**
- **Event** has many **Attribute**, **Attribute** has one **Event**
- **Template** has many **Attribute**, **Attribute** has one **Template**

## How to start
1. Ensure Ruby on Rails has been installed on the system. For more information on how to install Ruby on Rails, refer to [RubyOnRails](http://rubyonrails.org/ "Ruby on Rails").
2. Open your Terminal and navigate to the root of this project.
3. Type ***rails server*** to run the server. Do not close the Terminal, otherwise the server will stop running.
4. There should be a line that says something like "*=> Rails 4.1.5 application starting in development on http://0.0.0.0:3000*".
5. Enter the address in your preferred browser.

## How to stop
1. Hit the shortcut keys **Control + C**.
2. You may then close the Terminal.