require './robot'

max_y = 0
max_x = 0
robot = Robot.new('0','0','N', max_x, max_y)

ARGF.each_with_index do |line, idx|

    # use regex to find match valid input lines
    # if first line is valid grid size then set the grid limit
    if idx == 0 and /^\d\s\d$/.match line
        grid = line.split(' ')
        max_x = grid[0]
        max_y = grid[1]
        next
    elsif /^\d\s\d\s[nsewNSEW]$/.match line
        robot_new = line.split(' ')
        # resets the robot to first positions
        robot = Robot.new(robot_new[0],robot_new[1],robot_new[2], max_x, max_y)
    elsif /^[lrfLRF]+$/.match line
        instructions = line.split('')
        instructions.each do |instruction|
            robot.do_command(instruction)
        end
        puts robot.get_position(max_x, max_y)
        
    end
end