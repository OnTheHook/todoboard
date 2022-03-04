require './list.rb'

class TodoBoard
    def initialize
        @list = Hash.new { |h,k| h[k] = List.new(k) }
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            @list[*args]
        when 'ls'
            @list.keys.each { |label| puts label }
        when 'mktodo'
            @list[args[0]].add_item(*args[1..-1])
        when 'quit'
            return false
        when 'up'
            @list[args[0]].up(*args[1..-1].map(&:to_i))
        when 'down'
            @list[args[0]].down(*args[1..-1].map(&:to_i))
        when 'swap'
            @list[args[0]].swap(*args[1..-1].map(&:to_i))
        when 'sort'
            @list[*args].sort_by_date!
        when 'priority'
            @list[*args].print_priority
        when 'print'
            if args.length == 1
                @list[*args].print
            else
                @list[args[0]].print_full_item(*args[1..-1].map(&:to_i)) 
            end
        when 'toggle'
            @list[args[0]].toggle_item(*args[1..-1].map(&:to_i))
        when 'rm'
            @list[args[0]].remove_item(*args[1..-1].map(&:to_i))
        when 'purge'
            @list[*args].purge
        when 'showall'   
            @list.values.each { |el| el.print }
        else
            print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        running = self.get_command
        while running
            running = self.get_command
        end
    end



end

b = TodoBoard.new
b.run