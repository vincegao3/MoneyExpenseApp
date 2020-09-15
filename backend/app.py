import flask.json as json
from flask import Flask, request, jsonify,redirect,url_for
from flask_cors import CORS
from werkzeug.exceptions import HTTPException
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from passlib.apps import custom_app_context as pwd_context


app = Flask(__name__)

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:@localhost:3306/expense"


db = SQLAlchemy(app)
ma = Marshmallow(app)

db.init_app(app)

# swagger = Swagger(app)

class Expense(db.Model):
    __tablename__ = "expenses"
    record_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255) , nullable=False)
    created_at = db.Column(db.DateTime,default=datetime.now,nullable=False)
    amount = db.Column(db.Float, nullable=False)
    category = db.Column(db.String(255),nullable=False)
    #user_id = db.Column(db.Integer,nullable=False)

    def __init__(self, name,amount,created_at,category,user_id):
        self.name = name
        self.amount = amount
        self.created_at = created_at
        self.category = category
        # self.user_id = user_id


class ExpenseSchema(ma.Schema):
    class Meta:
        fields = ('record_id','name','amount','created_at','category')

expense_schema = ExpenseSchema()
expenses_schema = ExpenseSchema(many=True)
# class User(db.Model):
#     __tablename__ = "expenseapp"
#     id = db.Column(db.Integer, primary_key=True)
#     name = db.Column(db.String(255) , nullable=False)
#     username = db.Column(db.String(255) , nullable=False)
#     email = db.Column(db.String(255) , nullable=False)
#     password = db.Column(db.String(255) , nullable=False)
#     created_at = db.Column(db.DateTime,default=datetime.now,nullable=False)


#     def hash_password(self, password):
#         self.password = pwd_context.encrypt(password)
    
#     def verify_password(self, password):
#         return pwd_context.verify(password, self.password)

#     def __init__(self,username,name,email,password):

# @app.route('/api/user',post=["post"])
# def new_user():
#     username = request.json['username']
#     name = request.json['name']
#     password = request.json['password']
#     email = request.json['email']
#     if not username and not password and not email:
#         return {"error": True, "success": False, "data": None, 'msg': 'please specify the data'}
#     if User.query.filter_by(username = username).first():
#         return {"error": True, "success": False, "data": None, 'msg': 'Used username'}
#     if User.query.filter_by(email = email).first():
#         return {"error": True, "success": False, "data": None, 'msg': 'Used email'}

# @app.route('/api/auth', methods=["post"])
# def auth():
#     data = request.get_json()
#     if not data:
#         return {"error": True, "success": False, "data": None, 'msg': 'please specify the data'}
#     else:
#         user = request.json['username']
#         password = request.json['password']

@app.route('/api/create')
def index():
    db.create_all()
    return "OK"


@app.route('/api/expense', methods=["POST"])
def create_Expense():
    data = request.get_json()
    if not data:
        return {"error": True, "success": False, "data": None, 'msg': 'please specify the data'}
    
    name = request.json['name']
    amount = request.json['amount']
    created_at = request.json['created_at']
    category = request.json['category']
    # user_id =  request.json['user_id']
    listcat  = ["financials","home","leisure","others"]
    if(amount > 0 and category in listcat):
        new_expense = Expense(name,amount,created_at,category)
        db.session.add(new_expense)
        db.session.commit()
        return expense_schema.jsonify(new_expense)
    else:
        return jsonify({"msg":"Wrong Input"})


@app.route('/api/expenses',methods=["GET"])
def get_List():
    page = request.args.get('page')
    per_page = request.args.get('per_page')
    if page and per_page:
        expenses_data = Expense.query.order_by(Expense.created_at.desc()).paginate(int(page),int(per_page),error_out=False)
        result = {"data":expenses_schema.dump(expenses_data.items),"error": False,"success": True,"msg": "successfully created..."}
    return jsonify(result)


@app.route('/api/expense/<record_id>',methods=["GET"])
def get_Detail(record_id):
    expense = Expense.query.get(record_id)
    return expense_schema.jsonify(expense)

@app.route('/api/expense/<record_id>',methods=["PUT"])
def edit_record(record_id):
    data = request.get_json()
    expense = Expense.query.get(record_id)
    if data and expense:
        name = request.json['name']
        amount = request.json['amount']
        category = request.json['category']

        expense.name = name
        expense.amount = amount
        expense.category = category

        db.session.commit()

    
    return expense_schema.jsonify(expense)

@app.route('/api/expense/<record_id>',methods=["DELETE"])
def delete_record(record_id):
    expense = Expense.query.get(record_id)
    db.session.delete(expense)
    db.session.commit()
    return expense_schema.jsonify(expense)

@app.errorhandler(HTTPException)
def handle_exception(e):
    response = e.get_response()
    response.data = json.dumps({
        "code": e.code,
        "name": e.name,
        "description": e.description,
    })
    response.content_type = "application/json"
    return response

if __name__ == "__main__":
    app.run(debug=True)

