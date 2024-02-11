-- 4 форма нормалізації
CREATE TABLE IF NOT EXISTS University (
    UniversityID BIGINT PRIMARY KEY,
    Name TEXT NOT NULL,
    Address TEXT
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
);

CREATE TABLE IF NOT EXISTS Faculty (
    FacultyID BIGINT PRIMARY KEY,
    UniversityID BIGINT,
    Name TEXT NOT NULL,
    FOREIGN KEY (UniversityID) REFERENCES University (UniversityID)
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
);

CREATE TABLE IF NOT EXISTS Group (
    GroupID BIGINT PRIMARY KEY,
    FacultyID BIGINT,
    Name TEXT NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty (FacultyID)
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
);

CREATE TABLE IF NOT EXISTS PersonType (
    PersonTypeID BIGINT PRIMARY KEY,
    TypeName TEXT NOT NULL -- Типи можуть бути "Викладач", "Студент", "Ментор", "Вільний слухач"
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
);

CREATE TABLE IF NOT EXISTS Person (
    PersonID BIGINT PRIMARY KEY,
    PersonTypeID BIGINT,
    FirstName TEXT NOT NULL,
    MiddleInitial TEXT,
    LastName TEXT NOT NULL,
    IndividualFaxID BIGINT,
    Address TEXT,
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    FOREIGN KEY (PersonTypeID) REFERENCES PersonType (PersonTypeID)
);

CREATE TABLE IF NOT EXISTS Student (
    StudentID BIGINT PRIMARY KEY,
    PersonID BIGINT,
    GroupID BIGINT,
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID),     
    FOREIGN KEY (PersonID) REFERENCES Person (PersonID),
    FOREIGN KEY (GroupID) REFERENCES Group (GroupID)
);

CREATE TABLE IF NOT EXISTS Teacher (
    TeacherID BIGINT PRIMARY KEY,
    PersonID BIGINT,
    FacultyID BIGINT,
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    FOREIGN KEY (PersonID) REFERENCES Person (PersonID),
    FOREIGN KEY (FacultyID) REFERENCES Faculty (FacultyID)
);

CREATE TABLE IF NOT EXISTS Class (
    ClassID BIGINT PRIMARY KEY,
    ClassName TEXT NOT NULL,
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    Description TEXT
);

CREATE TABLE IF NOT EXISTS WeekRange (
    WeekRangeID BIGINT PRIMARY KEY,  --- 1 week, 2 week 3 week
    WeekName TEXT NOT NULL
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
);

CREATE TABLE IF NOT EXISTS Day (
    DayID BIGINT PRIMARY KEY,
    LanguageNameID  BIGINT 
    WeekID BIGINT,
    FullDayName TEXT NOT NULL, -- Monday, Tuesday....
    DayName TEXT NOT NULL, ---Mon, Tues Wed
    ShortDayName TEXT NOT NULL; --M, T W TH F S Su
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    FOREIGN KEY (WeekID) REFERENCES Week (WeekID)
);
--session time зробити клас
CREATE TABLE IF NOT EXISTS ClassSession (
    ClassSessionID BIGINT PRIMARY KEY,
    DayID BIGINT,
    ClassID BIGINT,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
        LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    FOREIGN KEY (DayID) REFERENCES Day (DayID),
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

-- Модифікація таблиці Registration для підтримки зв'язків many-to-many
CREATE TABLE IF NOT EXISTS Registration (
    RegistrationID BIGINT PRIMARY KEY,
    ClassID BIGINT,
    StudentID BIGINT,
    ClassSessionID BIGINT,
    LanguageNameID  BIGINT,
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    FOREIGN KEY (ClassSessionID) REFERENCES ClassSession (ClassSessionID)
);

-- Потенційно нова таблиця для викладачів, які викладають класи
CREATE TABLE IF NOT EXISTS TeachingAssignments (
    TeachingAssignmentsID  BIGINT PRIMARY KEY,
    TeacherID BIGINT,
    ClassID BIGINT,
    LanguageNameID  BIGINT,
    FOREIGN KEY (TeacherID) REFERENCES Teacher (TeacherID), 
    FOREIGN KEY (TeacherID) REFERENCES Teacher (TeacherID),
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID),
    FOREIGN KEY (LanguageNameID) REFERENCES LanguageName(LanguageNameID), 
    PRIMARY KEY (TeachingAssignmentsID)
);

CREATE TABLE IF NOT EXISTS LanguageName (
    LanguageNameID  BIGINT PRIMARY KEY,
    LanguageName TEXT,
);
