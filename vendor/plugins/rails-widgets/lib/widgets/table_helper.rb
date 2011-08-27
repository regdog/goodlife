
module Widgets
  
  module TableHelper
    include CssTemplate
    
    # Returns an HTML table with +:collection+ disposed in rows. Add
    # HTML attributes by passing an attributes hash to +html+.
    # The content of each item is rendered using the given block.
    #
    # +:collection+ array of items
    # +:cols+ number of columns (default 3)
    # +:html+ table html attributes (+:class+, +:id+)
    # +:name+ name of table (dafault +:main+)
    #
    #   <% tableize @users, :name => 'credential', :html => {:class => 'people'}, :cols => 2 do |user| -%>
    #     login: <%= user.name %>
    #   <% end -%>
    #
    #    # => <table id="credential_table" class="people"><tbody><tr>
    #           <td>login: scooby</td><td>&nbsp;</td>
    #         </tr></tbody></table>
    #
    def tableize(collection = nil, opts = {}, &block)
      table = Tableizer.new(collection, opts, self, &block)
      table.render
    end
    
    class Tableizer

      include CssTemplate
      attr_accessor :name

      def initialize(collection, opts, template, &block)
        parse_args(collection, opts, template, &block)
        
        raise ArgumentError, 'Missing collection parameter in tableize call' unless @collection
        raise ArgumentError, 'Missing block in tableize call' unless block_given?
        raise ArgumentError, 'Tableize columns must be two or more' unless columns >= 2
        
        @buffer = ''.html_safe
      end
      
      def render
        generate_css.to_s.html_safe
        generate_html.to_s.html_safe
        flush_to_template.to_s.html_safe
        return nil # avoid duplication if called with <%= %>
      end
      
      protected
      
      def parse_args(collection, opts, template, &block)
        @collection = collection
        @collection ||= opts[:collection]
        
        @opts = opts

        @name = opts[:name] || :main
        @html = opts[:html] || {}
        @html[:id] ||= @name.to_s.underscore << '_table'
        @html[:class] ||= @html[:id]
        
        @template = template
        @block = block
      end
      
      def generate_css
        @buffer << render_css('table').to_s.html_safe if generate_css?
      end
      
      def generate_html
        opening_table_tags.to_s.html_safe
        table_rows.to_s.html_safe
        closing_table_tags.to_s.html_safe
      end
      
      def flush_to_template
        concat(@buffer).to_s.html_safe
      end
      
      def opening_table_tags
        @buffer << tag('table', {:id => table_id, :class => table_class}, true).to_s.html_safe
        @buffer << tag('tbody', nil, true).to_s.html_safe
      end
      
      def closing_table_tags
        @buffer << '</tbody>'.html_safe << '</table>'.html_safe
      end
      
      def table_rows
        @index = 0
        @size = @collection.size

        header_tag.to_s.html_safe
        opening_tr_tag.to_s.html_safe
        fill_table_cells.to_s.html_safe
        closing_tr_tag.to_s.html_safe
      end
      
      def opening_tr_tag
        @buffer << tag('tr', nil, true).to_s.html_safe
      end
      
      def closing_tr_tag
        @buffer << '</tr>'.html_safe
      end

      def header_tag
        if header
          @buffer << content_tag('th', header).to_s.html_safe
          allow_for_extra_item
        end
      end
      
      def allow_for_extra_item
        @index += 1
        @size += 1
      end
      
      def fill_table_cells
        @collection.each do |item|
          @index += 1
          generate_cell(item).to_s.html_safe
          wrap_to_new_row_if_required
        end
        pad_last_row
      end
      
      def empty_cell
        content_tag('td', '&nbsp;'.html_safe, :class => 'blank').to_s.html_safe
      end
      
      def generate_cell(item)
        @buffer << content_tag('td', capture(item, &@block)).to_s.html_safe
      end
      
      def wrap_to_new_row_if_required
        if wrap_to_new_row?
          closing_tr_tag.to_s.html_safe
          opening_tr_tag.to_s.html_safe
          skip_header_column.to_s.html_safe
        end
      end
      
      def wrap_to_new_row?
        end_of_current_line? and !final_element?
      end
      
      def end_of_current_line?
        @index.remainder(columns) == 0
      end
      
      def final_element?
        @index == @size
      end
      
      def skip_header_column
        if skip_header_column?
          @buffer << empty_cell.to_s.html_safe
          allow_for_extra_item
        end
      end
      
      def skip_header_column?
        @opts[:skip_header_column] == true
      end
      
      def pad_last_row
        remainder = @size.remainder(columns)
        cells_to_pad = columns - remainder
        
        unless remainder == 0
          cells_to_pad.times do
            @buffer << empty_cell.to_s.html_safe
          end 
        end
      end

      def generate_css?
        @opts[:generate_css] || false
      end
      
      def columns
        @opts[:cols] || 3
      end
      
      def header
        @opts[:header]
      end
      
      def table_id
        @html[:id]
      end
      
      def table_class
        @html[:class]
      end
      
      def method_missing(*args, &block)
        @template.send(*args, &block)
      end
    end
    
  end
  
end
