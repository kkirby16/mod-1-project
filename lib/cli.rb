require "pry"

class CommandLineInterface
  #   def run
  #     greet
  #     user_login
  #     main_menu_options
  #     list_of_top_ski_resorts
  #   end"

  def greet
    puts ""
    puts "Welcome to Ski Ticketer, the best resource for buying ski tickets in the world! What would you like to do today?"
    puts "
                    *
                    XX
                   MMMMM
                   //(00
                .:.....
               .::::::::: 
              :: %%%%%% ::.
            ::  ::::::  :::::::I)
            (%  :::::          |
           /   |  /______      |
          /    |______   ))    |
         /            / //     |
        /            / //      |
       /            / //       |
      *            ZZZZ        *
          _________ZZZZZZ_________//_//"
  end

  def user_login
    puts ""
    puts "Please enter your name."
    @username = gets.chomp
    puts "Hi #{@username}! What would you like to do today?"
    @user_id = User.find_or_create_by(name: @username).id
    main_menu_options #welcome to ski ticketer. What would you like to do today.
  end

  def main_menu_options
    puts ""
    puts "1. View a list of the top 20 ski resorts in the world and/or purchase a ticket."
    puts "2. Edit a user."
    puts "3. Cancel a ticket."
    puts "4. Exit the program."
    user_selection = gets.chomp
    if user_selection == "1"
      list_of_top_ski_resorts
    elsif user_selection == "2"
      edit_name
    elsif user_selection == "3"
      delete_ticket
    elsif user_selection == "4"
      exit!
    elsif user_selection != "1" && user_selection != "2" && user_selection != "3" && user_selection != "4"
      puts ""
      puts "Invalid entry. Please enter a valid number."
      main_menu_options
      #binding.pry
    end
  end

  def list_of_top_ski_resorts
    puts ""
    puts ""
    puts "Below are the top 20 ski resorts in the world!"
    puts ""
    SkiResort.all.each do |ski_resort|
      puts ski_resort.name
    end
    puts ""
    list_of_top_ski_resorts_menu_question
  end

  def list_of_top_ski_resorts_menu_question
    puts "To go back to the main menu then press 1."
    puts "To buy a ski ticket for one of these resorts press 2."
    user_selection = gets.chomp
    if user_selection == "1"
      main_menu_options
    elsif user_selection == "2"
      purchase_ticket
    elsif user_selection != "1" && user_selection != "2"
      puts "Invalid entry. Please enter a valid number."
    end
  end

  def purchase_ticket
    new_ticket = Ticket.new
    puts ""
    puts ""
    SkiResort.all.each do |ski_resort|
      puts "Ski Resort Name: #{ski_resort.name}"
    end
    puts ""
    puts "Please enter the name of the resort you would like to purchase a ticket to."

    resort_name = gets.chomp.to_s
    if SkiResort.exists?(name: resort_name) == true
      ticket_resort = SkiResort.find_by(name: resort_name)
      new_ticket.ski_resort_id = ticket_resort.id
      puts "Please enter your name."
      ticket_name = gets.chomp.to_s
      if User.exists?(name: ticket_name) == true
        ticket_user = User.find_by(name: ticket_name)
        new_ticket.user_id = ticket_user.id
        new_ticket.save
        puts ""
        puts "Ticket successfully purchased! We've brought you back to the main menu now."
        main_menu_options
      else
        puts "That user does not exist in our records. Please try again."
        purchase_ticket
      end
    else
      puts "That resort does not exist in our records. Please try again."
      purchase_ticket
    end
  end

  #once you know the user exists, find the user and assign their id to the ticket.

  # puts ""
  # puts ""
  # puts "Please enter your user ID number."
  # guest_id = gets.chomp
  # new_ticket.ski_resort_id = resort_id
  # new_ticket.user_id = guest_id
  # new_ticket.save
  # puts ""
  # puts ""
  # puts "Thank you for your purchase from Ski Ticketer!"
  # puts ""
  # puts purchase_ticket_menu_question

  #     purchase_ticket_menu_question #iterate through ski resort tickets to find the price.
  #   end

  #   def users_ticket
  #     puts ""
  #     puts "Thank you for your purchase from Ski Ticketer. Below is your ski ticket:"
  #     puts ""
  #   end

  def delete_ticket
    puts ""
    puts ""
    puts "Please enter your name to cancel your ticket."
    inputted_name = gets.chomp.to_s
    if User.exists?(name: inputted_name) == true
      current_user = User.find_by(name: inputted_name)
      puts ""
      puts "Below are the resorts you have a ticket for:"
      current_user.ski_resorts.each do |ski_resort| #because user has many ski resorts, we can do .ski_resorts
        puts ski_resort.name
      end

      puts ""
      puts "Please enter the name of the resort where you would like to cancel your ticket."
      inputted_resort = gets.chomp.to_s
      if SkiResort.exists?(name: inputted_resort) == true
        current_resort = SkiResort.find_by(name: inputted_resort)

        ticket_to_delete = Ticket.where({ user_id: current_user.id, ski_resort_id: current_resort.id })
        ticket_to_delete[0].destroy
        puts ""
        puts "Your ticket to #{current_resort.name} has been cancelled. We've brought you back to the main menu now."
        main_menu_options
      else
        puts ""
        puts "That resort doesn't exist in our records. Please check your spelling and try again below."
        delete_ticket
      end
    else
      puts "That user doesn't exist in our records. Please check your spelling and try again below."
      puts ""
      puts ""
      delete_ticket
    end
  end

  #maybe I should add a check here for if the resort exists or not.

  #find ticket where user id is equal to current user.id and where ski resort is equal to the resort

  def edit_name
    puts "Please enter your name to change your name."
    input_name = gets.chomp
    if User.exists?(name: input_name) == true
      editing_user = User.find_by(name: input_name)

      #if this user exists then we want to proceed and have them change their name

      puts "What would you like to change your name to."
      changed_name = gets.chomp
      editing_user.name = changed_name
      editing_user.save
      puts ""
      puts "Your name is now #{editing_user.name}"
      puts ""
      puts "To go back to the main menu press 1."
      user_selection = gets.chomp
      if user_selection == "1"
        main_menu_options
      elsif user_selection != "1"
        puts "Invalid Entry. Please enter a valid number."
      end
    else
      puts ""
      puts "That user doesn't exist in our records. Please check your spelling and try again below."
      puts ""
      puts ""
      edit_name
    end
  end
end

#make price an attribute of the ski resort. then everyone who gets a ticket to that resort will pay the same price and can assign it as what the resort price is.
#rollback database and change migration and get rid of price on ticket and add to resort. and then migrate and seed again.
