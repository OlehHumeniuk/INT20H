from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_bcrypt import Bcrypt

import re
from sqlalchemy.orm import validates

from werkzeug.security import generate_password_hash, check_password_hash
import requests
from bs4 import BeautifulSoup
import json

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///mydatabase.db'
db = SQLAlchemy(app)

class Language(db.Model):
    __tablename__ = 'language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    LanguageName = db.Column(db.Text, nullable=False)

class University(db.Model):
    __tablename__ = 'university'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    IconURL = db.Column(db.Text, nullable=False)

class UniversityLanguage(db.Model):
    __tablename__ = 'university_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    UniversityId= db.Column(db.BigInteger, db.ForeignKey('university.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    Name = db.Column(db.Text, nullable=False)
    Address = db.Column(db.Text)

class Faculty(db.Model):
    __tablename__ = 'faculty'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

class FacultyLanguage(db.Model):
    __tablename__ = 'faculty_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    FacultyID = db.Column(db.BigInteger, db.ForeignKey('faculty.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    Name = db.Column(db.Text, nullable=False)
    ShortName = db.Column(db.Text, nullable=False)

class Department(db.Model):
    __tablename__ = 'department'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    DepartmentTypeID = db.Column(db.BigInteger, db.ForeignKey('department_type.id'), nullable=False)

class DepartmentLanguage(db.Model):
    __tablename__ = 'department_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    DepartmentID = db.Column(db.BigInteger, db.ForeignKey('department.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    Name = db.Column(db.Text, nullable=False)
    ShortName = db.Column(db.Text, nullable=False)

class DepartmentType(db.Model):
    __tablename__ = 'department_type'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

class DepartmentTypeLanguage(db.Model):
    __tablename__ = 'department_type_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    DepartmentTypeId = db.Column(db.BigInteger, db.ForeignKey('department_type.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    Name = db.Column(db.Text, nullable=False)

class Group(db.Model):
    __tablename__ = 'group'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    FacultyID = db.Column(db.BigInteger, db.ForeignKey('faculty.id'), nullable=False)

class GroupLanguage(db.Model):
    __tablename__ = 'group_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    GroupID = db.Column(db.BigInteger, db.ForeignKey('group.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    Name = db.Column(db.Text, nullable=False)

class PersonType(db.Model):
    __tablename__ = 'person_type'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

class PersonTypeLanguage(db.Model):
    __tablename__ = 'person_type_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    PersonTypeID = db.Column(db.BigInteger, db.ForeignKey('person_type.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    TypeName = db.Column(db.Text, nullable=False)

class Person(db.Model):
    __tablename__ = 'person'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    PersonTypeID = db.Column(db.BigInteger, db.ForeignKey('person_type.id'), nullable=False)

class PersonLanguage(db.Model):
    __tablename__ = 'person_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    Name = db.Column(db.Text, nullable=False)
    MiddleName = db.Column(db.Text)
    SurName = db.Column(db.Text, nullable=False)
    IndividualFaxID = db.Column(db.BigInteger)
    Address = db.Column(db.Text)

    PersonID = db.Column(db.BigInteger, db.ForeignKey('person.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)

class Student(db.Model):
    __tablename__ = 'student'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    PersonID = db.Column(db.BigInteger, db.ForeignKey('person.id'), nullable=False)
    GroupID = db.Column(db.BigInteger, db.ForeignKey('group.id'), nullable=False)

class Teacher(db.Model):
    __tablename__ = 'teacher'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    PersonID = db.Column(db.BigInteger, db.ForeignKey('person.id'), nullable=False)
    FacultyID = db.Column(db.BigInteger, db.ForeignKey('faculty.id'), nullable=False)

class Class(db.Model):
    __tablename__ = 'class'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

class ClassLanguage(db.Model):
    __tablename__ = 'class_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

    Name = db.Column(db.Text, nullable=False)
    Description = db.Column(db.Text)

    ClassID = db.Column(db.BigInteger, db.ForeignKey('class.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)

class Week(db.Model):
    __tablename__ = 'week'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    Name = db.Column(db.Text, nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)

class WeekLanguage(db.Model):
    __tablename__ = 'week_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

    Name = db.Column(db.Text, nullable=False)

    WeekID =db.Column(db.BigInteger, db.ForeignKey('week.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)

class Day(db.Model):
    __tablename__ = 'day'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    WeekID = db.Column(db.BigInteger, db.ForeignKey('week.id'), nullable=False)

class DayLanguage(db.Model):
    __tablename__ = 'day_language'
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)

    Name = db.Column(db.Text, nullable=False)
    FullDayName = db.Column(db.Text, nullable=False) #Monday, Tuesday....
    DayName = db.Column(db.Text, nullable=False) #Mon, Tues Wed
    ShortDayName = db.Column(db.Text, nullable=False) #M, T W TH F S Su

    DayID = db.Column(db.BigInteger, db.ForeignKey('day.id'), nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)

class ClassSession(db.Model):
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    DayID = db.Column(db.BigInteger, db.ForeignKey('day.id'), nullable=False)
    ClassID = db.Column(db.BigInteger, db.ForeignKey('class.id'), nullable=False)
    StartTime = db.Column(db.Text, nullable=False)  # можливо, вам варто використати тип DateTime
    EndTime = db.Column(db.Text, nullable=False)    # можливо, вам варто використати тип DateTime

class Registration(db.Model):
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    ClassID = db.Column(db.BigInteger, db.ForeignKey('class.id'), nullable=False)
    StudentID = db.Column(db.BigInteger, db.ForeignKey('student.id'), nullable=False)
    SessionID = db.Column(db.BigInteger, db.ForeignKey('class_session.id'), nullable=False)

class TeachingAssignments(db.Model):
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    TeacherID = db.Column(db.BigInteger, db.ForeignKey('teacher.id'), primary_key=False)
    ClassID = db.Column(db.BigInteger, db.ForeignKey('class.id'), primary_key=False)

# Додамо зараз лише функції реєстрації та входу для користувачів

def setupDepType():
    # This function should be called within an application context
    # and after the database has been initialized.
    try:
        # Define department types
        department_types = [
            {'id': 1, 'names': [('ukr', 'Навчально-науковий інститут'), ('eng', 'Educational and Scientific Institute')]},
            {'id': 2, 'names': [('ukr', 'Кафедра'), ('eng', 'Department')]}
        ]
        
        # Insert department types and their language-specific names
        for dep_type in department_types:
            type_record = DepartmentType(id=dep_type['id'])
            db.session.add(type_record)
            
            for lang_code, name in dep_type['names']:
                language_id = Language.query.filter_by(LanguageName=lang_code).first().id
                type_lang_record = DepartmentTypeLanguage(
                    DepartmentTypeId=type_record.id,
                    LanguageID=language_id,
                    Name=name
                )
                db.session.add(type_lang_record)
        
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        print(f"An error occurred: {e}")

def setup():
    # Create languages if they do not exist
    try:
        if not Language.query.filter_by(LanguageName='ukr').first():
            ukr_language = Language(id= 1, LanguageName='ukr')
            db.session.add(ukr_language)
        if not Language.query.filter_by(LanguageName='eng').first():
            eng_language = Language(id= 2,LanguageName='eng')
            db.session.add(eng_language)
        
        db.session.flush()  # Explicitly flush the objects to the database
        db.session.commit()
    except Exception as e:
        db.session.rollback()  # Rollback the session in case of error
        raise e
    

    # Get or create the language IDs
    ukr_language_id = Language.query.filter_by(LanguageName='ukr').first().id
    eng_language_id = Language.query.filter_by(LanguageName='eng').first().id

    # Create a University if it does not exist
    if not University.query.first():
        kpi_university = University(id=1, IconURL='UI/Icons/UniversityIcons/KPI.png')
        db.session.add(kpi_university)
        db.session.commit()

        # Get the University ID
        kpi_university_id = kpi_university.id

        # Create language-specific entries for the University
        ukr_university_lang = UniversityLanguage(id= 1, UniversityId=kpi_university_id, LanguageID=ukr_language_id, Name='КПІ', Address='03056, Київ, Берестейський проспект, 37')
        eng_university_lang = UniversityLanguage(id= 2, UniversityId=kpi_university_id, LanguageID=eng_language_id, Name='KPI', Address='03056, Kyiv, 37 Beresteysky prospect')
        db.session.add(ukr_university_lang)
        db.session.add(eng_university_lang)
        db.session.commit()

def get_next_id_for_model(model, field):
    last_record = model.query.order_by(field.desc()).first()
    return last_record.id+ 1 if last_record else 1

# Парсинг даних
def parse_and_insert_fac_dep():
    # Виконуємо запит до веб-сторінки та парсимо HTML
    response = requests.get('https://webometr.kpi.ua/abbreviations')
    soup = BeautifulSoup(response.text, 'html.parser')

    # Знайти всі теги <tr> і парсити дані
    tr_tags = soup.find_all('tr')

    # Отримуємо idдля мов
    ukr_language_id = Language.query.filter_by(LanguageName='ukr').first().id
    eng_language_id = Language.query.filter_by(LanguageName='eng').first().id

    for tr in tr_tags[4:]:  # Skip the first four rows
        td_tags = tr.find_all('td')
        
        if len(td_tags) == 4:
            # Українські дані
            uk_full_name = td_tags[0].text.strip()
            uk_abbreviation = td_tags[1].text.strip()
            # Англійські дані
            en_full_name = td_tags[2].text.strip()
            en_abbreviation = td_tags[3].text.strip()

            faculty = Faculty.query.filter_by(id=uk_abbreviation).first()
            if not faculty:
                faculty_id = get_next_id_for_model(Faculty, Faculty.id)
                faculty = Faculty(id=faculty_id)
                db.session.add(faculty)
                db.session.commit() # Отримуємо idствореного факультету

            faculty_uk = FacultyLanguage.query.filter_by(FacultyID=faculty.id, LanguageID=ukr_language_id).first()
            if not faculty_uk:
                faculty_uk = FacultyLanguage(id= get_next_id_for_model(FacultyLanguage, FacultyLanguage.id),
                                             FacultyID=faculty.id, LanguageID=ukr_language_id, Name=uk_full_name)
                db.session.add(faculty_uk)

            faculty_en = FacultyLanguage.query.filter_by(FacultyID=faculty.id, LanguageID=eng_language_id).first()
            if not faculty_en:
                faculty_en = FacultyLanguage(id= get_next_id_for_model(FacultyLanguage, FacultyLanguage.id),
                                             FacultyID=faculty.id, LanguageID=eng_language_id, Name=en_full_name)
                db.session.add(faculty_en)
            
            # Check if the Department already exists, create it if not, and then create a DepartmentLanguage entry.
            department = Department.query.filter_by(id = uk_abbreviation).first()
            if not department:
                department = Department(id = get_next_id_for_model(Department, Department.id),)
                db.session.add(department)
                db.session.flush()  # Flush to get the newly created DepartmentID

            department_uk = DepartmentLanguage.query.filter_by(DepartmentID=department.id, LanguageID=ukr_language_id).first()
            if not department_uk:
                department_uk = DepartmentLanguage(id= get_next_id_for_model(DepartmentLanguage, DepartmentLanguage.id),
                                                   DepartmentID=department.id, LanguageID=ukr_language_id, Name=uk_abbreviation)
                db.session.add(department_uk)

            department_en = DepartmentLanguage.query.filter_by(DepartmentID=department.id, LanguageID=eng_language_id).first()
            if not department_en:
                department_en = DepartmentLanguage(id= get_next_id_for_model(DepartmentLanguage, DepartmentLanguage.id),
                                                   DepartmentID=department.id, LanguageID=eng_language_id, Name=en_abbreviation)
                db.session.add(department_en)

def parse_group_info(group_string):
    # Використовуємо регулярні вирази для виділення групи та факультету
    match = re.match(r'(\w+-\d+)\s*\((\w+)\)', group_string)
    if match:
        group_name = match.group(1)  # Назва групи
        faculty_abbr = match.group(2)  # Абревіатура факультету
        return group_name, faculty_abbr
    else:
        return None, None

def read_groups_and_create_entries():
    # Відкриваємо файл для читання з правильним кодуванням
    with open('KPI_groups.txt', 'r', encoding='utf-8') as file:
        # Читаємо рядки з файлу
        lines = file.readlines()

    # Get the Language idfor Ukrainian
    ukr_language_id = Language.query.filter_by(LanguageName='ukr').first().id

    # Проходимося по кожному рядку
    for line in lines:
        # Парсимо рядок
        group_name, faculty_abbr = parse_group_info(line)

        if group_name and faculty_abbr:
            # Операції з БД

            # Check if the FacultyLanguage entry exists for the given abbreviation and language
            faculty_lang = FacultyLanguage.query.filter_by(Name=faculty_abbr, LanguageID=ukr_language_id).first()
            
            if faculty_lang:
                # Get the FacultyID from FacultyLanguage entry
                faculty_id = faculty_lang.FacultyID

                # Check if the Group already exists, create it if not
                group = Group.query.filter_by(FacultyID=faculty_id).first()
                if not group:
                    group = Group(FacultyID=faculty_id)
                    db.session.add(group)
                    db.session.flush()

                # Check if GroupLanguage entry exists, create it if not
                group_lang = GroupLanguage.query.filter_by(GroupID=group.id, LanguageID=ukr_language_id).first()
                if not group_lang:
                    group_lang = GroupLanguage(GroupID=group.id, LanguageID=ukr_language_id, Name=group_name)
                    db.session.add(group_lang)

        # Зберігаємо зміни в базі даних
        db.session.commit()
    else:
        print("Неможливо розпізнати рядок групи і факультету.")

def initialize():
    setupDepType()
    setup()
    # parse_and_insert_fac_dep()
    read_groups_and_create_entries()

class User(db.Model):
    id= db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    full_name = db.Column(db.String(150), nullable=True)
    nickname = db.Column(db.String(50), nullable=True)
    date_of_birth = db.Column(db.Date, nullable=True)
    phone = db.Column(db.String(50), nullable=True)
    gender = db.Column(db.String(10), nullable=True)
    accepted_terms = db.Column(db.Boolean, default=False, nullable=False)
    LanguageID = db.Column(db.BigInteger, db.ForeignKey('language.id'), nullable=False)
    
    @validates('email')
    def validate_email(self, key, address):
        if not re.match(r"[^@]+@[^@]+\.[^@]+", address):
            raise ValueError('Invalid email address')
        return address
    
    @validates('phone')
    def validate_phone(self, key, phone_number):
        # You can define your own phone number pattern here. This is a simple example:
        pattern = re.compile(r"^\+?1?\d{9,15}$")
        if not pattern.match(phone_number):
            raise ValueError('Invalid phone number')
        return phone_number

    def set_password(self, password):
        self.password_hash = bcrypt.generate_password_hash(password).decode('utf-8')

    def check_password(self, password):
        return bcrypt.check_password_hash(self.password_hash, password)

@app.route('/register', methods=['POST'])
def register():
    email = request.json.get('email')
    password = request.json.get('password')

    if email is None or password is None:
        return jsonify({'message': 'Missing credentials'}), 400
    if User.query.filter_by(email=email).first():
        return jsonify({'message': 'User already exists'}), 400

    user = User(email=email)
    user.set_password(password)
    db.session.add(user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/login', methods=['POST'])
def login():
    login = request.json.get('login') # Can be either username or email
    password = request.json.get('password')

    if login is None or password is None:
        return jsonify({'message': 'Missing credentials'}), 400

    user = User.query.filter((User.email == login) | (User.nickname == login)).first()
    if user and user.check_password(password):
        return jsonify({'message': 'Logged in successfully'}), 200
    else:
        return jsonify({'message': 'Invalid login or password'}), 401

@app.route('/validate_phone', methods=['POST'])
def validate_phone():
    data = request.json
    phone_number = data.get('phone')

    # Example regex pattern for UA phone numbers
    pattern = r"^\+380\(66|50|63|67|68|96|97|98)\d{3}-\d{2}-\d{2}$"
    if re.match(pattern, phone_number):
        # Logic to check operator and number validity
        return jsonify({'message': 'Phone number is valid'}), 200
    else:
        return jsonify({'message': 'Phone number is invalid'}), 400

@app.route('/update_profile/<int:user_id>', methods=['PUT'])
def update_profile(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'message': 'User not found'}), 404

    data = request.json
    user.full_name = data.get('full_name', user.full_name)
    user.nickname = data.get('nickname', user.nickname)
    user.phone = data.get('phone', user.phone)
    user.gender = data.get('gender', user.gender)
    # Parse the date from string to date object before saving
    date_of_birth = data.get('date_of_birth', None)
    if date_of_birth:
        user.date_of_birth = datetime.strptime(date_of_birth, '%Y-%m-%d').date()

    db.session.commit()
    return jsonify({'message': 'Profile updated successfully'}), 200

if __name__ == '__main__':
    try:
        with app.app_context():  # This pushes an application context
            initialize()  # Now this runs within the context
            app.run(host='0.0.0.0')

    except SystemExit as e:
        print("SystemExit occurred", e)
        raise
