# Welcome to My Users App
***

## Task
The task was to create an MVC with the help of Ruby, SQL and the gems Sinatra and sqlite3. The MVC
should handle user creation, user retrieval, login, signout and user deletion. 

## Description
The MVC consists of three parts. The model my_user_model.rb contains the User class that creates a database 
with a table and allows to create a new user, show all users, find a user, update user info and delete a user.
The controller app.rb handles HTTP routes that utilize the methods of the User class. The index.erb file is
the view, i.e. it displays a table of all users currently stored in the database.

## Installation
The project requires that Ruby, as well as Sinatra and sqlite3 gems are installed. 

## Usage
You can start the server from one terminal by typing "ruby app.rb" and pass commands via a second
terminal window with curl. Depending on the test location http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users/
might be substituted for http://localhost:8080/

```
GET /
    curl -X GET http://web-XXXXXXXXX.docode.YYYY.qwasar.io/
GET /users
    curl -X GET http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users
POST /users  
    curl -X POST http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -d "firstname=Jane" -d "lastname=Doe" -d "age=25" -d "password=secret" -d "email=unique@mail.com"    
POST /sign_in  
    curl -X POST http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -d "email=unique@mail.com" -d "password=secret" -b cookies.txt -c cookies.txt
PUT /users  
    curl -X PUT http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -d "password=newsecret" -b cookies.txt -c cookies.txt   
DELETE /sign_out 
    curl -X DELETE http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -b cookies.txt -c cookies.txt
DELETE /users
    curl -X DELETE http://web-XXXXXXXXX.docode.YYYY.qwasar.io/users -b cookies.txt -c cookies.txt
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
