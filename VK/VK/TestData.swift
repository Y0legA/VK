// TestData.swift
// Copyright © RoadMap. All rights reserved.

// тестовые данные
let photoNames = ["30", "31", "32", "33", "34", "35"]

let friends = [
    User(avatarImageName: "1", photoNames: photoNames, userName: "Иванова Катерина", likeCount: 23, isliked: true),
    User(avatarImageName: "2", photoNames: photoNames, userName: "Ермолаев Анатоль", likeCount: 324, isliked: false),
    User(avatarImageName: "3", photoNames: photoNames, userName: "Абакумов Трофим", likeCount: 321, isliked: false),
    User(avatarImageName: "20", photoNames: photoNames, userName: "Абакумов Трофим", likeCount: 23, isliked: true),
    User(avatarImageName: "21", photoNames: photoNames, userName: "Петрова Татьяна", likeCount: 543, isliked: false),
    User(avatarImageName: "22", photoNames: photoNames, userName: "Караваев Стас", likeCount: 1233, isliked: false),
    User(avatarImageName: "24", photoNames: photoNames, userName: "Черкасов Юрий", likeCount: 345, isliked: true),
    User(avatarImageName: "25", photoNames: photoNames, userName: "Мамаев Павел", likeCount: 5664, isliked: false),
    User(avatarImageName: "26", photoNames: photoNames, userName: "Измайлова Анастасия", likeCount: 44, isliked: true),
    User(avatarImageName: "27", photoNames: photoNames, userName: "Кривоносов Игорь", likeCount: 12, isliked: false)
]

let groups = [
    Group(groupName: "Панки в городе!!!", groupImageName: "4"),
    Group(groupName: "Гараж", groupImageName: "5"),
    Group(groupName: "3D-печать", groupImageName: "6"),
    Group(groupName: "Ездим на батарейках", groupImageName: "7"),
    Group(groupName: "Ездим на батарейках", groupImageName: "8"),
    Group(groupName: "Последние новости", groupImageName: "9"),
    Group(groupName: "Кинопоиск", groupImageName: "10"),
    Group(groupName: "Гороскопы", groupImageName: "11"),
    Group(groupName: "Мобильная разработка", groupImageName: "12"),
    Group(groupName: "Общество анонимных алкоголиков", groupImageName: "13"),
    Group(groupName: "Dune, группа последователей", groupImageName: "14"),
    Group(groupName: "Резьба по дереву", groupImageName: "15"),
    Group(groupName: "Общество любителей тишины6", groupImageName: "16"),
    Group(groupName: "Секреты автономок", groupImageName: "17"),
    Group(groupName: "Relax", groupImageName: "18")
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
