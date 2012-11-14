Redmine Ultraviolet Syntax Highlighter Plugin
=============================================

Redmine Plugin to integrate the [Ultraviolet Syntax Highlighting Engine][ultraviolet] into Redmine.

[ultraviolet]: https://github.com/grosser/ultraviolet "Ultraviolet Syntax Highlighting Engine"

Features
--------

* Integrates the Ultraviolet Syntax Highlighting Engine.

* Configures Ultraviolet as default highlighter in issues and wiki pages.

* Automatically copies all style sheets from the Ultraviolet Gem into the plugin's asset directory. 

Installation and Setup
----------------------

* The plugin requires at least Redmine 2.1

* Open a shell and cd into your Redmine installation directory

* Install the plugin

        cd plugins
        git clone https://github.com/jochenseeber/redmine_ultraviolet_syntax_highlighter.git
    
* Run the database migration

        RAILS_ENV=production rake redmine:plugins:migrate
    
* Restart Redmine

License
-------

This plugin is licensed under the [GNU Affero General Public License][agpl].

[agpl]: http://www.gnu.org/licenses/agpl-3.0.html "GNU Affero General Public License"
