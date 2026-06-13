this is an application that was written from a Thoughtbot blog post:  https://thoughtbot.com/blog/ruby-rack-tutorial

# Learnings: 

Rack is a interface that enables folks to build Webservers (process code, serve templates, add middleware etc)
this is a bare bones web application. The main server like processing portion of this is the single method on this
class App called: 'call'. The call function in this case acts as a controller.

To be a Rack enabled application, the class needs to contain a method called: App#call. And the method needs to return
an array containing 3 elements. 
It's pretty basic: [status_code, headers, body]. 

This app class is run by passing the class App with call defined on it.

run encapsulates the class as a block and then calls the "call" method defined on it. Call in this case only ever
returns [status, headers, body]

In this particular example:
  There is 2 routes defined: '/' and 404.html

  If you navigate to '/something', you reach a undefined route case that displays a 404

  If you pass a param called url to '/' you can see the server do some processing

  The app also returns template html snippets and builds itself up between Home.html.erb and Layout.html.erb

Its basically a super bare bones version of any web framework out there. But if you go through the process of 
building this, you can see how web frameworks can explode in complexity and give you a greater appreciation of 
all of the tools you have to your disposal. 

# Problems encountered: 

Needed to require some libraries from ruby core.


# AI Used:

I ran into an uninitialized constant error and asked Chat GPT to debug the error for me. After that I made the 
decision to always require standard library classes if I called to them, even if I know that the Ruby Interpreter 
would implicitly include it anyway.

# Final Takeway:

I never made a rack application before today. I can now appreciate frameworks like Rails and Sinatra a bit more. 
Rack is powerful and insanely modular. I'll try to look out for where Rack magic is happening when I develop my 
next application. 


# RUN:
in the root folder in the terminal type: `rackup`

best, 
Arnold
