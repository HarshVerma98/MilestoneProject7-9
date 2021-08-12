# MilestoneProject7-9
Hacking With Swift Solution

Challenge
This is the first challenge that involves you creating a game. You’ll still be using UIKit, though, so it’s a good chance to practice your app skills too.

The challenge is this: make a hangman game using UIKit. As a reminder, this means choosing a random word from a list of possibilities, but presenting it to the user as a series of underscores. So, if your word was “RHYTHM” the user would see “??????”.

The user can then guess letters one at a time: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect letter, they inch closer to death. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.

That’s the game: can you make it? Don’t underestimate this one: it’s called a challenge for a reason – it’s supposed to stretch you!

The main complexity you’ll come across is that Swift has a special data type for individual letters, called Character. It’s easy to create strings from characters and vice versa, but you do need to know how it’s done.

First, the individual letters of a string are accessible simply by treating the string like an array – it’s a bit like an array of Character objects that you can loop over, or read its count property, just like regular arrays.

When you write for letter in word, the letter constant will be of type Character, so if your usedLetters array contains strings you will need to convert that letter into a string, like this:

Note: unlike regular arrays, you can’t read letters in strings just by using their integer positions – they store each letter in a complicated way that prohibits this behavior.

Once you have the string form of each letter, you can use contains() to check whether it’s inside your usedLetters array.

That’s enough for you to get going on this challenge by yourself. As per usual there are some hints below, but it’s always a good idea to try it yourself before reading them.

You already know how to load a list of words from disk and choose one, because that’s exactly what we did in tutorial 5.
You know how to prompt the user for text input, again because it was in tutorial 5. Obviously this time you should only accept single letters rather than whole words – use someString.count for that.
You can display the user’s current word and score using the title property of your view controller.
You should create a usedLetters array as well as a wrongAnswers integer.
When the player wins or loses, use UIAlertController to show an alert with a message.


This project is based on Paul Hudson (Twitter @twostraws) Hacking with Swift MilestoneProject 7-9. It contains my solutions to his challenges during Day 41 of the 100 Days of Swift initiative (https://www.hackingwithswift.com/100/41).


![Screenshot 2021-08-11 at 8 47 06 PM](https://user-images.githubusercontent.com/49474526/129057224-bd333f7d-2e6e-44c6-b7db-cf3fd9002942.png)
![Screenshot 2021-08-11 at 8 47 32 PM](https://user-images.githubusercontent.com/49474526/129057227-4e3dacb9-e07a-47a2-a02c-1ad9d54adc6c.png)
![Screenshot 2021-08-11 at 8 47 43 PM](https://user-images.githubusercontent.com/49474526/129057230-c6fa950e-b3e4-4182-ba83-3a6276a835a4.png)
![Screenshot 2021-08-11 at 8 47 54 PM](https://user-images.githubusercontent.com/49474526/129057234-375f765d-9c07-4c02-a1e0-3ec27df3a38b.png)
![Screenshot 2021-08-11 at 8 48 53 PM](https://user-images.githubusercontent.com/49474526/129057237-beafd775-4467-4da9-85b3-c8f5cc012565.png)
