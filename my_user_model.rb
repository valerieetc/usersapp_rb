require 'sqlite3'


class User

    attr_accessor :id, :firstname, :lastname, :age, :password, :email

    def initialize(attributes)
        @id = attributes["id"]
        @firstname = attributes["firstname"]
        @lastname = attributes["lastname"]
        @age = attributes["age"]
        @password = attributes["password"]
        @email = attributes["email"]
    end

    
    NAME = "db.sql"


    def self.create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        db.execute("CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                firstname TEXT,
                lastname TEXT,
                age INTEGER,
                password TEXT,
                email TEXT
            )")
        db.close
    end


    def self.create(user_info)
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        result = db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)" ,
        [
        user_info[:firstname],
        user_info[:lastname],
        user_info[:age],
        user_info[:password],
        user_info[:email],
        ])

        user_id = db.last_insert_row_id
        db.close
        User.find(user_id)
    end

    def self.find(user_id)
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        result = db.execute("SELECT * FROM users WHERE id = ?", [user_id]).first
        db.close
        User.new(result) if result 
    end

    def self.find_by_email(email)
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        result = db.execute("SELECT * FROM users WHERE email = ?", [email]).first
        db.close
        User.new(result) if result
    end

    def self.all
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        result = db.execute("SELECT * FROM users")
        db.close
        result.map { |row| User.new(row) }
    end
    
    def self.update(user_id, attribute, value)
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        result = db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", [value, user_id])
        db.close
        User.find(user_id)
    end

    def self.destroy(user_id)
        create_table
        db = SQLite3::Database.new(NAME)
        db.results_as_hash = true
        db.execute("DELETE FROM users WHERE id = ?", [user_id])
        db.close
    end
end


User.create_table

