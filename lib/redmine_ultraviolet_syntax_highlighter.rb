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
require 'uv'

module RedmineUltravioletSyntaxHighlighter
    class << self
        def highlight_by_filename(text, filename)
            language = File.extname(filename)[/\.?(.*)/, 1]
            highlight_by_language(text, language)
        end

        def highlight_by_language(text, language)
            markup = Uv.parse(text, "xhtml", language, false, ultraviolet_theme)
            markup[/^<pre[^>]*>(.*)<\/pre>$/m, 1]
        rescue => ex
            Rails.logger.error "Error highlighting code with language '#{language}' with Ultraviolet: #{ex}"
            ERB::Util.h(text)
        end

        def ultraviolet_theme
            Setting.plugin_redmine_ultraviolet_syntax_highlighter['ultraviolet_theme'] || 'dawn'
        end
    end
end

