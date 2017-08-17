[![Build
Status](https://travis-ci.org/agranado2k/mgg_campaign.svg?branch=master)](https://travis-ci.org/agranado2k/mgg_campaign)

# Mission
temp0566

### Task:

Create a rails application to show the results for TV SMS voting
campaigns,
derived from the log data similar to the attached tarball.

This task should take no more than 2 hours, and probably considerably
less.

Deliverables:

 - A rails application and associated database to hold the data
 - A basic web front-end to view the results which should;
   - Present a list of campaigns for which we have results.
   - When the user clicks on a campaign, present a list of the
     candidates, their scores, and the number of messages which were
sent in
     but not counted
 - A command-line script that will import log file data into the
   application.
   Any lines that are not well-formed should be discarded. The sample
data
   has been compressed to be emailed to you, but your script should
assume
   the data is uncompressed plain text.
 - A description of your approach to this problem, including any
   significant design decisions and your reasoning in making your
   choices. (This is the most important deliverable)

Parsing rules;

Here is an example log line;

VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele
CONN:MIG00VU MSISDN:00777778429999
GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334

- All well-formed lines will have the same fields, in the same order.
  They
 will all begin with VOTE, then have an epoch time value, then a set
 of fields with an identifier, a colon, and the value of the field
 (e.g. 'Campaign:ssss_uk_01B')

- A campaign is an episode of voting

- 'Choice:' indicates the candidate the user is voting for. In every
  campaign
 there will be a limited set of candidates that can be voted for.
 If Choice is blank, it means the system could not identify the chosen
 candidate from the text of the SMS message. All such messages should
 be counted together as 'errors', irrespective of their Validity
 values. There is a limited set of values for 'Choice', each of which
 represents a candidate who can be voted for.

- Validity classifies the time when the vote arrived, relative to the
  time
 window when votes will count towards a candidate's score.  Only votes
 with a Validity of 'during' should count towards a candidate's score.
 Other possible values of Validity are 'pre' (message was too early to
be
 counted), 'post' (message was too late to be counted). 'pre' and 'post'
 messages should be counted together irrespective of the candidate
chosen.

- The CONN, MSISDN, Shortcode and GUID fields are not relevant to this
 exercise.
 
## Architecture and Design Decisions
Rails uses MVC pattern that is great for Web Application. But if we only
use this pattern we can have some coupled code that is hard to test and
organize ([SOLID
Principles](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design))).

So to improve the code organization I decided to use the hexagonal
architecture that can help do decouple code from the Rails framework
(that is awesome!).

For emphasize I created a folder **app** in **lib** where I included the
application and domain files/code. I let the Rails files/code
(controllers, models and views) in the standard **app** folder. But I
could created all files/code in starndard **app**.

For Rail I have only two routes (**'/'** and **'/campaign/detail'**),
one controller and two views. Everything else are in **'lib/app'** with
my application files/code. 

I organized the code: 
- Domains, the entities **campaign** and **vode** in entities folder;
- UseCases, where are the business logic, how parse file information to
  create the entities (campaigns and votes), how get the campaigns names
in a list, how to analyze the campaign votes for each candidate and
return the structure with all this information. Also I have test for all
the use cases on test folder;
- Repositories, here are how I abstract the Storage using the Repository
  Pattern that decouple my code from Active Record. It allow me to use
any kind of Storage only inject it. So I can use a InMemoryDB for test
and MySQL (with ActiveRecord) on development and production.

The good thing to organize the code in this way is that we can isolate
the inner code from outer code, keeping the SOLID principles. 
It's easier to test, for example, we can use memory db for test propose
(I use it), instead of use Active Record. Also we can run test without
load Rails that is faster!!!

![hexagonal
architecture](https://raw.githubusercontent.com/smakagon/decoupling/master/public/possible.png)


#### References:
- [October CincyRb - Jim Weirich on Decoupling from
  Rails](https://www.youtube.com/watch?v=tg5RFeSfBM4)
- [Decoupling from Rails [Part 1] - Repository and
  UseCase](http://rubyblog.pro/2017/03/decoupling-from-rails-repository-and-use-case)
- [The Repository
  Pattern](https://8thlight.com/blog/mike-ebert/2013/03/23/the-repository-pattern.html)
- [Implementing the Repository Pattern in
  Ruby](http://hawkins.io/2013/10/implementing_the_repository_pattern/)
- [Thanks to
  repositories...](http://blog.arkency.com/2015/06/thanks-to-repositories/)
- [Why is your Rails application still coupled to
  ActiveRecord?](https://blog.lelonek.me/why-is-your-rails-application-still-coupled-to-activerecord-efe34d657c91)


## For Test
Execute:
```
rake test
```

## For run the application
Execute:
```
rails s
```
or

Access the Heroku app in this
[URL](https://mgagecampaign.herokuapp.com/)

## For run the migration script
Execute:
```
bundle exec rake 'db:migrate_campaigns_data[file_path]'
```
Where **file_path** is the file with data. For our exemple the file_path
is **'public/votes.txt'**.

