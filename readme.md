# Inquiries

![Refinery Inquiries](http://refinerycms.com/system/images/BAhbBlsHOgZmSSIqMjAxMS8wNS8wMS8wNF81MF8wMV81MDlfaW5xdWlyaWVzLnBuZwY6BkVU/inquiries.png)

### Gem Installation using Bundler (The very best way)

Include the latest [gem](http://rubygems.org/gems/refinerycms-inquiries) into your Refinery CMS application's Gemfile:

    gem 'refinerycms-inquiries', '~> 2.0.0'

Then type the following at command line inside your Refinery CMS application's root directory:

    bundle install

#### Installation on Refinery 2.0.0 or above.

To install the migrations, run:

    rails generate refinery:inquiries
    rake db:migrate
    
Add pages to the database and you're done:

    rake db:seed

## About

__Add a simple contact form to Refinery that notifies you and the customer when an inquiry is made.__

In summary you can:

* Collect and manage inquiries
* Specify who is notified when a new inquiry comes in
* Customise an auto responder email that is sent to the person making the inquiry

When inquiries come in, you and the customer are generally notified. As we implemented spam filtering through the [filters_spam plugin](https://github.com/resolve/filters_spam#readme) you will not get notified if an inquiry is marked as 'spam'.

## How do I get Notified?

Go into your 'Inquiries' tab in the Refinery admin area and click on "Update who gets notified"

## How do I Edit the Automatic Confirmation Email

Go into your 'Inquiries' tab in the Refinery admin area and click on "Edit confirmation email"

## Help! How do I send emails from no-reply@domain.com.au instead of no-reply@com.au?

Simply set the following in config/application.rb:

```ruby
config.action_dispatch.tld_length = 2
```
