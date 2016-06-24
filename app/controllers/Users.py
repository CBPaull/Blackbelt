from system.core.controller import *


class Users(Controller):
    def __init__(self, action):
        super(Users, self).__init__(action)
        self.load_model('User')
        self.db = self._app.db

    def index(self):
        return self.load_view('index.html')

    def dashboard(self):
        all_users = self.models['User'].show_all_users()
        poked = self.models['User'].count_poked(session['id'])
        usercount = len(poked)
        pokes = self.models['User'].count_pokes(session['id'])
        return self.load_view('dashboard.html', all_users=all_users, poked=poked, usercount=usercount, pokes=pokes)

    def add(self):
        requestform = request.form
        create_status = self.models['User'].add_user(requestform)
        if create_status['status'] == True:
            session['id'] = create_status['user']['id'] 
            session['alias'] = create_status['user']['alias']
            return redirect('users/dashboard')
        else:
            for message in create_status['errors']:
                flash(message, 'regis_errors')
            return redirect('/')

    def login(self):
        requestform = request.form
        login_status = self.models['User'].login_user(requestform)
        if login_status['status'] == True:
            session['id'] = login_status['user']['id'] 
            session['alias'] = login_status['user']['alias']  
            return redirect('users/dashboard')
        else:
            for message in login_status['errors']:
                flash(message, 'login_errors')
            return redirect('/')

    def poke(self):
        requestform = request.form
        self.models['User'].poke(requestform)
        return redirect('users/dashboard')

    def logoff(self):
        session.clear
        return redirect('/')