#
# Copyright 2012 Jochen Seeber
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
require 'rubygems'
require 'uv'
require 'redmine_ultraviolet_syntax_highlighter'
require 'redmine_ultraviolet_syntax_highlighter/stylesheet_hook'

Redmine::Plugin.register :redmine_ultraviolet_syntax_highlighter do
    name 'Ultraviolet Syntax Highlighter Plugin'
    author 'Jochen Seeber'
    description 'Ultraviolet Syntax Highlighter Plugin for Redmine 2.x'
    version '0.0.1'
    url 'https://github.com/jochenseeber/redmine_ultraviolet_syntax_highlighter'
    author_url 'http://www.noussommesdesoles.net'

    # Copy Ultraviolet style sheets to the plugin's asset directory
    target_dir = File.join(public_directory, 'ultraviolet')
    FileUtils.mkdir_p(target_dir)

    files = Dir.entries(Uv.theme_path).select {|f| f =~ /\.css$/i}
    files.each do |f|
        css = File.read(File.join(Uv.theme_path, f))
        # Adjust stylesheet to match Redmines HTML
        css.gsub!(/^\s*pre.\w+/m, '.syntaxhl')
        File.open(File.join(target_dir, f), 'w') do |out|
            out.write css
        end
    end

    ActionDispatch::Reloader.to_prepare do
        # Ensure we always use the Ultraviolet highlighter
        Redmine::SyntaxHighlighting.highlighter = 'RedmineUltravioletSyntaxHighlighter'
    end
end
