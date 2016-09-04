require 'rubygems'
require 'circular_list'

class Robot
    
    # normally I don't abuse class variables like this. but this will save me a lot of time
    @@scent_grid = Hash.new('X')

    def initialize (x, y, orientation, max_x, max_y)
        @orientation = orientation
        @x           = x.to_i
        @y           = y.to_i
        @max_y       = max_y.to_i
        @max_x       = max_x.to_i
        @lost        = false
        # this will let us turn relativly without worrying about the current orientation of the rover
        @compass   = CircularList::List.new(['N','E','S','W'])
        #need to set the compass to the current dir
        while @compass.fetch_next != orientation
        end
    end

    def forward
        if @@scent_grid[[@x,@y]] == @orientation
            #robot detected scent, ignores command
            return
        end

        # this needs refactoring. 
        if @orientation    == 'N'
            if @y < @max_y
                @y += 1
            else
                @lost = true
            end
        elsif @orientation == 'E'
            if @x < @max_x
                @x += 1
            else
                @lost = true
            end
        elsif @orientation == 'S'
            if @y > 0
                @y -= 1
            else
                @lost = true
            end
        elsif @orientation == 'W'
            if @x > 0
                @x -= 1
            else
                @lost = true
            end
        end

        if @lost
            # if you've just gotten lost drop a scent
            @@scent_grid[[@x,@y]] = @orientation
        end
    end

    def do_command (dir)
        #don't accept new commands when lost
        if @lost
            return
        end

        # use the compass to turn relatively 
        if dir    == 'L'
            @orientation = @compass.fetch_previous
        elsif dir == 'R'
            @orientation = @compass.fetch_next
        elsif dir == 'F'
            self.forward
        end
    end

    def get_position (max_x, max_y)
        lost_string = ''

        if @lost
            lost_string = ' LOST'
        end

        return "#{@x} #{@y} #{@orientation}#{lost_string}"
    end
end