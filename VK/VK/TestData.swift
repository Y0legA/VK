// TestData.swift
// Copyright © RoadMap. All rights reserved.

// тестовый массив
let friends = [
    User(avatarImageName: "1", userName: "Иванова Катерина", likes: 23, isliked: true),
    User(avatarImageName: "2", userName: "Ермолаев Анатоль", likes: 324, isliked: false),
    User(avatarImageName: "3", userName: "Абакумов Трофим", likes: 321, isliked: false),
    User(avatarImageName: "20", userName: "Абакумов Трофим", likes: 23, isliked: true),
    User(avatarImageName: "21", userName: "Петрова Татьяна", likes: 543, isliked: false),
    User(avatarImageName: "22", userName: "Караваев Стас", likes: 1233, isliked: false),
    User(avatarImageName: "24", userName: "Черкасов Юрий", likes: 345, isliked: true),
    User(avatarImageName: "25", userName: "Мамаев Павел", likes: 5664, isliked: false),
    User(avatarImageName: "26", userName: "Измайлова Анастасия", likes: 44, isliked: true),
    User(avatarImageName: "27", userName: "Кривоносов Игорь", likes: 12, isliked: false)
]

let groups = [
    Group(groupName: "4", groupImageName: "Панки в городе!!!"),
    Group(groupName: "5", groupImageName: "Гараж"),
    Group(groupName: "6", groupImageName: "3D-печать"),
    Group(groupName: "7", groupImageName: "Ездим на батарейках"),
    Group(groupName: "8", groupImageName: "IOS Developers"),
    Group(groupName: "9", groupImageName: "Последние новости"),
    Group(groupName: "10", groupImageName: "Кинопоиск"),
    Group(groupName: "11", groupImageName: "Гороскопы"),
    Group(groupName: "12", groupImageName: "Мобильная разработка"),
    Group(groupName: "13", groupImageName: "Общество анонимных алкоголиков"),
    Group(groupName: "14", groupImageName: "Dune, группа последователей"),
    Group(groupName: "15", groupImageName: "Резьба по дереву"),
    Group(groupName: "16", groupImageName: "Общество любителей тишины"),
    Group(groupName: "17", groupImageName: "Секреты автономок"),
    Group(groupName: "18", groupImageName: "Relax")
]

let posts = [
    Post(
        postImageName: "post",
        avatarImageName: "3",
        userName: "Mak",
        date: "21.12.21",
        likes: 123,
        isliked: false,
        postDescription:
        """
        Пять миллионов людей, забывших укрыться от палящего ядерного
        зарева, превратились в радиоактивных бескожих гулей. Многие
        из них, с которыми вам доведётся встретиться, работают и
        действуют почти как настоящие человеческие существа. У некоторых
        длительное воздействие радиации выжгло мозги и они бродят по
        равнинам подобно зомби.
        """
    )
]
