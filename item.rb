class Item
    attr_accessor :title, :description
    attr_reader :deadline, :done
    def self.valid_date?(date_str)
        date_split = date_str.split("-")
        return false if date_split.length != 3
        begin
            year = Integer(date_split[0], 10)
            month = Integer(date_split[1], 10)
            day = Integer(date_split[2], 10)
        rescue
            return false
        end
        return false if !(1..12).to_a.include?(month)
        return false if !(1..31).to_a.include?(day)

        true
    end

    def initialize(title, deadline, description)
        @title = title
        @description = description
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise "Invalid date"
        end
        @done = false
    end

    def deadline=(deadline)
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise "Invalid date"
        end
    end

    def toggle
        if @done
            @done = false
        else
            @done = true
        end
    end


end

