create database if not exists testdb;
use testdb;

drop table if exists ImageTag;
drop table if exists likes;
drop table if exists follows;
drop table if exists Comments;
drop table if exists Image;
drop table if exists tags;
drop table if exists User;

CREATE TABLE if not exists User(
    email VARCHAR(32) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    birthday DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    PRIMARY KEY (email)
);

CREATE TABLE if not exists Image(
	imageId INTEGER NOT NULL auto_increment,
	ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	email Varchar(32),
    url VARCHAR(100),
    description VARCHAR(200),
    foreign key (email) references user(email),
    PRIMARY KEY (imageId)
);

create table if not exists tags(
	tagId integer NOT NULL auto_increment,
    tag varchar(16),
    Primary key (tagId),
    constraint check_lowercase check (lower(tag) = tag)
);

create table if not exists follows(
	followerEmail VARCHAR(32) not null,
    followeeEmail VARCHAR(32) not null,
    FOREIGN KEY (followerEmail) References User(email),
    FOREIGN KEY (followeeEmail) References User(email),
    Primary key (followerEmail, followeeEmail),
    constraint self_follow check (FollowerEmail <> FolloweeEmail)
);

Create Table if not exists Comments(
	imageId Integer,
    email VARCHAR(32),
    comment varchar(200),
    FOREIGN KEY (email) REFERENCES User(email),
    FOREIGN KEY (imageId) References image(imageId),
    Primary key(email,imageId)
);

create table if not exists ImageTag(
	imageId Integer,
    tagId integer,
	FOREIGN KEY (imageId) REFERENCES Image(imageId),
    FOREIGN KEY (tagId) References tags(tagId),
    primary key(imageId, tagId)
);

create table if not exists likes(
	email  varchar(32),
    imageId integer,
    likeSwitch boolean,
    Foreign key (email) references user(email),
    Foreign key (imageID) references image(imageid),
    primary key (email, imageId)
);

/*
create view feedPage
create view communityPage
create view profilePage
	On each day, a user can post at most five images. 
	On each day, a user can give at most 3 likes. 
*/
