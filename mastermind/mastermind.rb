module Mastermind
  class Game
    def initialize
      @row = []
      @exact_close = []
      @correct_order = []
      @range = 10
      @round = 0
      @chanses = 12
      @game_on = true
      @error = false
      @multiples = false
    end

    def generate_sequence(range = 10)
      rand_num = rand(range).to_s
      @correct_order.append(rand_num.to_s)
      3.times do
        if @multiples == false

          rand_num = rand(range) while @correct_order.include?(rand_num.to_s)
          @correct_order.append(rand_num.to_s)
        elsif @multiples == true
          @correct_order.append[rand_num.to_s]
        end
      end
    end

    def check_if_right
      exact = 0
      close = 0
      @row[@round].each_index do |i|
        exact += 1 if @row[@round][i] == @correct_order[i]
        @row[@round].each_index do |a|
          close += 1 if @correct_order[i] == @row[@round][a] && @row[@round][i] != @correct_order[i]
        end
      end
      @exact_close[@round] = [exact, close]
      exact = 0
      close = 0
    end

    def check_game_state
      if @round + 1 >= @chanses && @game_on == true
        @game_on = false
        puts 'You have lost'
        puts "The right order was: #{@correct_order.join(' | ')}"
      elsif @exact_close[@round][0] == 4
        @game_on = false
        puts 'You have won!'
        puts "The right order was: #{@correct_order.join(' | ')}"
      end
    end

    def visualize_game
      30.times do
        puts "\n"
      end
      @row.each_index do |i|
        puts "#{@row[i].join(' | ')}   #{@exact_close[i].join(' ')}   try: #{i + 1}"
      end
    end

    def input_allowed(value)
      if value.scan(/\D/).empty? && value.length == 4
        @error = false
      else
        @error = true
        visualize_game
        puts 'Type in 4 numbers between 0-9 like this: 9812'
      end
    end

    def input
      input = gets
      input_allowed(input.chomp)
      new_arr = input.delete('^0-9').split('').map(&:to_s)
      return unless @error == false

      @row[@round] = new_arr
    end

    def play
      puts 'Type in 4 numbers between 0-9 like this: 9812'
      generate_sequence(@range)
      while @game_on == true
        input
        next unless @error == false

        check_if_right
        visualize_game
        check_game_state
        @round += 1
      end
    end
  end
end

Mastermind::Game.new.play
