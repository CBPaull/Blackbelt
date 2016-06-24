from system.core.model import Model
import re

class User(Model):
    def __init__(self):
        super(User, self).__init__()

    def show_all_users(self):
        query = "SELECT * FROM users"
        all_users = self.db.query_db(query)
        return all_users

    def count_pokes(self, u_id):
        query = "SELECT target_id, COUNT(*) AS pokecount FROM pokes WHERE poker_id = :u_id GROUP BY target_id"
        data = {'u_id': u_id}
        pokes = self.db.query_db(query, data)
        print "this is the pokes", pokes
        return pokes

    def count_poked(self, u_id):
        query = "SELECT poker_name, COUNT(*) AS pokecount FROM pokes WHERE target_id = :u_id GROUP BY poker_name ORDER BY pokecount DESC"
        data = {'u_id': u_id}
        poked = self.db.query_db(query, data)
        print "this is the poked", poked
        return poked

    def login_user(self, requestform):
        info = {
            'email': requestform['email'],
            'password': requestform['password']
        }
        errors = []
        user_query = "SELECT * FROM users WHERE email = :email LIMIT 1"
        user_data = {'email': info['email']}
        user = self.db.query_db(user_query, user_data)
        print user
        print info['password']
        if user:
           # check_password_hash() compares encrypted password in DB to one provided by user logging in
            if self.bcrypt.check_password_hash(user[0]['pw_hash'], info['password']):
                return { "status": True, "user": user[0]}
            else:
                errors.append('Incorrect Email or Password')
                return {"status": False, "errors": errors}
        else:
            errors.append('Incorrect Email or Password')
            return {"status": False, "errors": errors}


    def add_user(self, requestform):
        info = {
    		'name': requestform['name'], 
    		'alias': requestform['alias'], 
    		'email': requestform['email'],
    		'dateofbirth': requestform['dateofbirth'],
    		'password': requestform['password'],
    		'confirmation': requestform['confirmation']

    	}
        EMAIL_REGEX = re.compile(r'^[a-za-z0-9\.\+_-]+@[a-za-z0-9\._-]+\.[a-za-z]*$')
        PASS_REGEX = re.compile(r'\d.*[A-Z]|[A-Z].*\d')
        errors = []
        # Some basic validation
        if not info['name']:
            errors.append('name cannot be blank')
        elif len(info['name']) < 2:
            errors.append('name must be at least 2 characters long')
        if not info['alias']:
            errors.append('Alias cannot be blank')
        if not info['email']:
            errors.append('Email cannot be blank')
        elif not EMAIL_REGEX.match(info['email']):
            errors.append('Email format must be valid!')
        if not info['password']:
            errors.append('Password cannot be blank')
        elif len(info['password']) < 8:
            errors.append('Password must be at least 8 characters long')
        elif not PASS_REGEX.match(info['password']):
            errors.append('Password must contain an uppercase letter and a number')
        elif info['password'] != info['confirmation']:
            errors.append('Password and confirmation must match!')
        # If we hit errors, return them, else return True.
        if errors:
            return {"status": False, "errors": errors}
        else:
            pw_hash = self.bcrypt.generate_password_hash(info['password'])
            insert_query = "INSERT INTO users (name, alias, email, dateofbirth, pw_hash, created_at, updated_at) VALUES (:name, :alias, :email, :dateofbirth, :pw_hash, NOW(), NOW())"
            data = { 'name': info['name'], 'alias': info['alias'], 'email': info['email'], 'dateofbirth': info['dateofbirth'], 'pw_hash': pw_hash }
            print data
            self.db.query_db(insert_query, data)
            get_user_query = "SELECT * FROM users ORDER BY id DESC LIMIT 1"
            users = self.db.query_db(get_user_query)
            return { "status": True, "user": users[0]}

    def poke(self, requestform):
        info = {
            'target_id' : requestform['target_id'],
    		'poker_id' : requestform['poker_id'],
    		'poker_name' : requestform['poker_name']
        }
        poke_query = "INSERT INTO pokes (target_id, poker_id, poker_name) VALUES (:target_id, :poker_id, :poker_name)"
        data = {'target_id': info['target_id'], 'poker_id': info['poker_id'], 'poker_name': info['poker_name']}
        self.db.query_db(poke_query, data)
        return info['poker_id']



