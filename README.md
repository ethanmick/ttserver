# API Server #

# To Do #

* Fix/Finish Readability

* Add a "how often to check feed" option in Feed (eg, objcio only updates monthly. No need to check every 5 minutes)


# Feeds to Add #
* objective -c io feed http://www.objc.io/feed.xml
* Marco's Blog






Schema

Users Objects:

### feed
A user has multiple feeds. A user will always have a main feed.

* title - string
* subtitle - string
* links (array, Link)
* id - string
* updated - datetime
* rights - string

* has many entry

A Feed has many "entries" 

//rss 2.0 - http://cyber.law.harvard.edu/rss/rss.html
* title - string
* link - the URL
* description - string
* author - string (email)
* category - string
* comments - URL for page for comments
* enclosure - Describes a media object that is attached to the item
* guid - unique identifier
* pubDate - date time for publication date
* source - the RSS channel the item came from

//atom //atom first
# Entry
* id - string
* published - datetime
* updated - datetime
* links (many)
* title - string
* content - text
* author_name - string



# Link
* href - string
* rel - string
* type - string
* hreflang - string
* title - string
* length - string

## Backend
Every 5 minutes, or so, a worker will query the feed URL, see if there are any new posts, and if so, create them.

It doesn't make sense to do that for each user.... In fact, each user can just have a reference to the post, and mark it as read or not.

## Objects
Central Feed Objects
for each feed:
	Updated the entries


when a user requests their feeds
	Get the entries from the central feed (last 20?)
	the new ones are unread
	send all the new ones
	//in fact, sending ALL the new ones would be great, I hate not having new posts
	when read, update the 
