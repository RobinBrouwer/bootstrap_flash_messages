# bootstrap_flash_messages

    version 1.0.3
    Robin Brouwer

Bootstrap alerts and Rails flash messages combined in one easy-to-use gem.


## Installation

You can use this gem by putting the following inside your Gemfile:

    gem "bootstrap_flash_messages", "~> 1.0.1"

When you're using Bootstrap 2, you can use version 0.0.7.

Now you need flash.en.yml for the flash messages.

    rails g bootstrap_flash_messages:locale

And that's it!


## Changes

Version 1.0.2 changes (05/08/2015):

    - Added :fade_in.

Version 1.0.1 changes (02/08/2015):

    - Made 'info' the default class.

Version 1.0.0 changes (31/01/2014):

    - Added Boostrap 3 support.
    - Added default locales for the flash messages.
    - Removed the 'convert_newlines' option and added 'simple_format'.
    - Added option to set flash values directly inside 'flash!' and 'flash_now!'.
    - Changed the documentation.

Version 0.0.7 changes (26/01/2013):

    - Added alert_class_mapping (documentation below).

Version 0.0.6 changes (27/09/2012):

    - Added pull request #5 by protolif. This adds the :fade option.

Version 0.0.5 changes (24/09/2012):

    - Added HTML escape option for flash_messages helper (:html).
    - Also added option to convert new-lines to br-tags (:convert_newlines).

Version 0.0.4 changes (03/09/2012):

    - Namespaced Controllers can be accessed by nesting your locales.

    # Old
    "admin/products":
      ...

    # New:
    admin:
      products:
        ...

Version 0.0.3 changes (14/08/2012):

    - Added interpolation to the flash messages

Version 0.0.2 changes (10/08/2012):

    - Changed the 'x' in close to & t i m e s ;

Version 0.0.1 changes (08/08/2012):

    - Changed redirect_to method
    - Added flash! and flash_now! methods
    - Added flash_messages helper
    - Made a gem out of it


## Usage

You need [Bootstrap 3](http://getbootstrap.com/) for the styling and close button. You can still use it without Bootstrap, but you need to style it yourself. This gem uses the [Bootstrap alerts](http://getbootstrap.com/components/#alerts).

If you're [customizing Bootstrap](http://getbootstrap.com/customize/), make sure to grab the "Alert" and "Component Animations" (the latter one is optional, unless you want the fade-out animation on close).

All flash messages are defined inside config/locales/flash.en.yml. They are nested like this:

    en:
      flash_messages:
        controller_name:
          action_name:
            success: "It worked!"
            info: "There's something you need to know..."
            warning: "You should watch out now."
            error: "Oh no! Something went wrong."

You have four keys:

    :success
    :info
    :warning
    :error

It is also possible to add default locales globally or per action:

    en:
      flash_messages:
        defaults:
          success: "It really worked!"
          create:
            success: "Created successfully!"

When you've defined the messages it's very easy to call them inside your Controller.

    class PostsController
      def create
        @post = Post.new(params[:post])
        if @post.save
          redirect_to(@post, :flash => :success)
        else
          flash_now!(:error)
          render("new")
        end
      end
    end

You can use the `:flash` parameter inside the `redirect_to` method (note: this gem changes the redirect_to method!) to set the flash messages. You only need to pass the corresponding key and the gem will automatically set `flash[:success]` to `t("flash_messages.posts.create.success")`. The `:flash` parameter also accepts an Array.

    redirect_to(@post, :flash => [:success, :info])

You can still use a Hash to use the default `redirect_to` behavior.

    redirect_to(:root, :flash => { :error => I18n.t("flash_messages.authorize_admin") })

When you don't want to use the `redirect_to` method to set the flash messages, you can use the `flash!` method.

    flash!(:success, :info)
    redirect_to(@post)

When you need to use `flash.now` you can use the `flash_now!` method.

    flash_now!(:error, :warning)

You use `flash_now!` in combination with rendering a view instead of redirecting.

You can also pass options to `flash!` and `flash_now!` to set the flash values directly.

    flash!(:error => I18n.t("flash_messages.authorize_admin"))
    flash_now!(:error => I18n.t("flash_messages.authorize_admin"))

Now's the time to show these messages to the user. Inside the layout (or any other view), add the following:

    <div id="flash_messages"><%= flash_messages %></div>

And that's it! To change the flash messages inside a `.js.erb` file, you can do the following:

    $("#flash_messages").html("<%= j(flash_messages) %>");

The `flash_messages` helper shows a simple Bootstrap alert box. If you want to add a close button you can add the `:close` option.

    <%= flash_messages(:close) %>

If you'd like for the flash message to fade out when you click on the close icon, you can pass in the `:fade` option. This requires `:close` to work, obviously.

    <%= flash_messages(:close, :fade) %>

If you'd like for the flash message to also fade in, you can pass in the `:fade_in` option.

    <%= flash_messages(:close, :fade, :fade_in) %>

    # Also add something like this to application.js:
    window.setTimeout(function() {
      $(".alert").addClass("in");
    }, 1000);

    # If you didn't add the "Component Animations" to your Bootstrap configuration, add this to application.css:
    .alert.fade {
      opacity: 0;
      -webkit-transition: opacity 0.15s linear;
      -moz-transition: opacity 0.15s linear;
      -o-transition: opacity 0.15s linear;
      transition: opacity 0.15s linear;
    }
    .alert.fade.in {
      opacity: 1;
    }

Want a heading? Add `:heading`. The headings inside flash.en.yml are used for the headings.

    <%= flash_messages(:close, :heading) %>

Want to put the heading inside a `<h4>` tag? Just add `:block`.

    <%= flash_messages(:close, :heading, :block) %>

Need to display HTML inside the flash messages? Use the `:html` option.

    <%= flash_messages(:html) %>

It's also possible to use simple_format on the flash message using the `:simple_format` option.

    <%= flash_messages(:simple_format) %>

And that's it! Have fun. :)

## Interpolation

You can use i18n interpolation like this:

    redirect_to :root, :flash => [:success, :info], :locals => { :name => @user.name, :email => @user.email }
    flash! :success, :info, :locals => { :name => @user.name, :email => @user.email }
    flash_now! :success, :info, :locals => { :name => @user.name, :email => @user.email }

Inside `flash.en.yml` you can do the following:

    success: "Welcome, %{name}."
    info: "Your e-mail address has been changed to: %{email}."

## alert_class_mapping

You can map the keys used inside the flash messages to a different alert class. There are 4 different classes for the alert messages inside bootstrap:

    alert-success
    alert-info
    alert-warning
    alert-danger

When you use `:notice` the alert class is mapped (by default) to `alert-success`. So it looks like this:

    :notice  maps to "alert-success"
    :success maps to "alert-success"
    :info    maps to "alert-info"
    :warning maps to "alert-warning"
    :error   maps to "alert-danger"

Changing the mapping is quite easy. Create an initializer (config/initializers/bootstrap_flash_messages.rb) and add the following:

    module BootstrapFlashMessages
      @alert_class_mapping = {
        :notice => :danger,
        :success => :success,
        :info => :info,
        :warning => :warning,
        :error => :danger
      }
    end

Now you can map whatever alert class you want to the different keys.

## Why I created this gem

I created the [gritter gem](https://github.com/RobinBrouwer/gritter) and used it in a lot of projects.
I started using Bootstrap and really liked the alerts. I loved the way gritter allowed you to set messages
and decided to do the same for the Bootstrap alerts. And this is the result!

## Copyright

Copyright (C) 2012 Robin Brouwer

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
