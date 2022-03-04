require './item.rb'

class List
    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        begin
            item = Item.new(title, deadline, description)
        rescue
            return false
        end

        @items << item
        true
    end 

    def size
        @items.length
    end

    def valid_index?(index)
        (0...@items.length).to_a.include?(index)
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts "---------------------------------------------------"
        puts @label.upcase
        puts "---------------------------------------------------"
        puts "Index | Item              | Deadline         | Done"
        puts "---------------------------------------------------"
        @items.each_with_index do |item, i|
            puts "#{i}  | #{item.title}          | #{item.deadline}     | #{item.done}"
        end
        puts "---------------------------------------------------"
    end

    def print_full_item(index)
        if valid_index?(index)
            puts "--------------------------------"
            puts "#{@items[index].title}                    #{@items[index].deadline}"
            puts "#{@items[index].description}"
            puts "Done: #{@items[index].done}"
            puts "--------------------------------"
        end

    end 

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount = 1)
        return false if !valid_index?(index)
        while amount > 0 && index >= 1
            self.swap(index, index - 1)
            amount -= 1
            index -= 1
        end
        true
    end

    def down(index, amount = 1)
        return false if !valid_index?(index)
        while amount > 0 && index < @items.length - 1
            self.swap(index, index + 1)
            amount -= 1
            index += 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        if valid_index?(index)
            @items[index].toggle
        end
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.reject! { |item| item.done }
    end

end