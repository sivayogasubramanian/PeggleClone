# CS3217 Problem Set 4

**Name:** Ruppa Nagarajan Sivayoga Subramanian

**Matric No:** A0217379U

## Developer Guide

The developer guide can be found [here](./docs/DEVELOPER_GUIDE.md).

## Rules of the Game

Please write the rules of your game here. This section should include the
following sub-sections. You can keep the heading format here, and you can add
more headings to explain the rules of your game in a structured manner.
Alternatively, you can rewrite this section in your own style. You may also
write this section in a new file entirely, if you wish.

### Cannon Direction

The player moves the cannon by either dragging on the screen. When the player drags on the screen, the cannon will point towards the location of the user's finger. When the user lifts the finger, a ball should fire.

Alternatively, tapping on the screen will immediately point the cannon towards the direction of the user's finger. A ball will also fire if the user chooses to tap.

When the game is active (a ball is shot), the cannon is still can be aimed using the methods above.

### Win and Lose Conditions

To win, the user needs to clear all orange pegs. A game should therefore have at least one orange peg to be considered playable (without auto-winning when the game starts).

You lose the game if you run out of red balls (game balls). You start with 10 game balls. Every shot decreases that amount by 1. Note that if the ball enters the bucket the user will get a free ball (number of balls left increases by 1).

You also can lose the game if the timer for the game expires. You will have 5 minutes to clear all orange pegs to win the game.

Once the game is won, a winning alert and sound is played. The user can tap on the `Okay` button to go back to the previous page.

Once the game is lost, a losing alert and sound is played. The user can tap on the `Okay` button to go back to the previous page.

## Level Designer Additional Features

### Scrolling levels

A level with arbitrary height can be created by scrolling up/down in the level designer.

Drag with one finger to scroll.

A offset counter is shown in the level designer at the bottom left to indicate the current offset.

A offset of zero indicates that the level the level cannot be scrolled further down.

A level can be infinitely high but it is recommended to create a level that is winnable within 5 mins due to the game timer.

### Peg/Block Rotation

Tapping on the peg/block should bring up a rotation slider at the top of the level designer.

Dragging that slider will allow you to rotate the pegs/blocks from 0 to 360 degrees.

### Peg Resizing

- Pegs

  - Tapping on the peg should bring up a radius slider at the top of the level designer.
  - Dragging that slider will allow you to change the radius of the pegs. You can increase the radius by 2 times (i.e. 4 times the area).

- Blocks

  - Tapping on the block should bring up a width and height slider at the top of the level designer.
  - Dragging that slider will allow you to change the width and height of the blocks. You can increase the width and height by 2 times each. The maximum area will therefore be 4 times the original area.

### Oscillating blocks

When a block is tapped, it can be make to oscillate using the oscillate switch found at the top right of the level designer.

Once oscillation is activated, a gray circle will be shown on top of the current selected block. The 4 corners will have small circles that can be dragged to adjust the springiness of the block.

The larger this radius, the "looser" the springiness will be.

## Bells and Whistles

- Sound effect and music

  - A background music for the level designer and main menu.
  - A background music for the gameplay.
  - Two click sounds that get played when various UI elements are tapped.
  - Cannon shoot sound.
  - A sound when a peg is hit.
  - A sound when a block is hit.
  - A sound when the bucket is hit (free ball sound effect).
  - A sound when the game is won.
  - A sound when the game is lost.
  - A explosion sound effect when a blue peg is hit (Ka-Boom powerup).
  - A ghostly sound effect when the spooky ball reappears at the top.
  - A shape shift sound effect if the shape shift powerup activates when hitting the gray ball.
  - A flash sound effect if the flash powerup activates when hitting the yellow ball.
  - A rain fire sound effect if the rain fire powerup activates when hitting the pink ball.

  - Note that for all these sounds, the sound will only be played if the same sound effect is not already being played.
    For example, if the game ball hits one yellow peg (causing one flash sound effect to be played) and hits another yellow peg,
    the sound effect for the second yellow peg flash powerup might not play as the previous sound effect might still be playing.

  - For all powerup sound effects, it will only be played if the powerup is activated.

- Score system

  - Pink Peg: 1 point
  - Blue Peg: 10 point
  - Gray Peg: 50 point
  - Orange Peg: 100 point
  - Purple Peg: 500 point
  - Yellow Peg: 1000 point
  - Multiplier is exactly the same as in the problem set website under the [appendix section](https://cs3217.github.io/cs3217-docs/problem-sets/problem-set-4#scoring-system).

- Displaying the number of pegs remaining during gameplay

- Displaying the number of balls left (red balls) remaining during gameplay

- Displaying the number of pegs/blocks added in the level designer

- A timer that results in a lost game when it expires. (Set to 5 minutes)

- Additional Powerups

  - Flash
    - The game ball has a change to have its speed doubled if a yellow peg is hit for the first time.
    - This powerup only activates if the ball is not already travelling too fast.
  - Shape Shift
    - The game ball has a change to have its size changed when a gray peg is hit for the first time.
    - Note that the change in size might not be noticeable sometimes depending on the random size chosen.
  - Rain Fire
    - 4 additional helper game balls (dark gray in color) will be spawned if the main game ball (red in color) hits a pink peg.
    - Note that there can only be 4 helper game balls at any given time. So if the game ball happens to hit multiple pink pegs, the powerup might not activate depending on the number of game ball present.
    - The helper game balls disappear when the main game ball exits the game screen.
    - Helper game balls can activate some powerups like spooky ball and ka boom.
    - If the helper ball activates the spooky ball powerup, the main ball becomes spooky (i.e. the main ball will reappear at the top after it exits).
    - Helper game balls cannot activate rain fire because of point 2.
    - Helper game balls can fall into the bucket. If they do, all balls will be removed (including the main ball) and you get a free ball and you can shoot again.
    - Helper game balls themselves cannot get affected by shape shift and flash power ups.
    - All helper game balls activated powerups will affect the main ball.

## Tests

The test plans can be found [here](./docs/TEST_PLANS.md).

## Written Answers

### Reflecting on your Design

> Do you think you have designed your code in the previous problem sets well enough?

Firstly, I believe that the MVVM architecture that I implemented sort of captures the idea. However, I believe that I can do better. One of the mistakes that I did in these problem set is to have views with state. Ideally views should never have state. Views being stateless and having its associated view model handle all states simplifies the complexity of code greatly. This is because in the future, views can be regarded as something that is responsible for showing something on the screen while what to show is determined by the view model. For example, in a lot of views, the views are responsible for determining when to show various alerts to the user. Even though this achieves the desired purpose, it would be better if these logic reside in the view model layer for better separation of concerns.

My physics engine in PS3 was not designed very well. Therefore, I had to refactor much of it in this problem set. I believe that the physics engine in this problem set is much cleaner than PS3. Firstly, the problem with the physics engine in the previous problem set is that it was not properly abstracted. To resolve some collision between 2 objects, the 2 critical information you need is the collision normal as well as the depth of collision. This can be easily determined for rigid bodies and abstracted into a `CollisionManifold` which then gets passed into the `CollisionResolver` to resolve.

Lastly I believe that it might be better to have the game engine decide what to do with a collision. Currently, all object gets resolved in the physics engine depending on if they collide with each other. However, for games it might not be the case that all objects will collide with each other. Therefore, a better way is to have collision be detected in the physics engine which then notifies the game engine and the game engine decides what to do with it. It might pass it back to the physics engine to resolve collisions, do some game specific logic, etc. For example, if a game as a powerup rune that needs to be collected by a player, it might be better to have the game engine decide what to do with a player-rune collision instead of resolving it in the physics engine.

> Is there any technical debt that you need to clean in this problem set?

Firstly, I believe that having colors represented as an enum is not the right way of doing things. This is because it introduces a lot of if/switch statements throughout the codebase to determine which logic to perform depending on the peg color. Instead a better way is to have a Peg protocol, and have multiple colored peg object that conform to this protocol. This is to have color use polymorphism on color specific logic instead of having many if/switch statements.

Secondly, my physics engine has 3 kinds of objects. Circle, Line and Polygon. The intersection and resolvers use these basic shapes to detect and resolve collisions. However, I was not able to come up with a n-polygon physics body shape that represents all kinds of polygons (triangle, square, rectangle, etc). Instead I had to break them apart even though they are similar. Ideally all polygons should only have one kind of physics body. Some refactoring can be done to achieve this in the future.

Lastly, I did not have time to implement some kinds of collision detection and resolution such as line vs line collisions. This made it so that the I had to exhaustively list out the possible pairs of collision in `IntersectionDetector` instead of relying on polymorphism to achieve the same thing.

> If you were to redo the entire application, is there anything you would have done differently?

I think that I would start with the physics engine as my first module. This is because when I start with the physics engine first, I do not have any information about the game logic and I am forced create a abstracted physics engine. In this project, I believe that the physics engine is the most critical part of the application as everything will fall into place given a well designed physics engine.

I would not have used SwiftUI. From discussing with my friends, I believe that SwiftUI is not really a good choice for non-CRUD based apps like a game. In a game, having as much control over the views is critical to have the best user experience. However, I am currently limited with what I can do because of the lack of control exposure in SwiftUI. Furthermore, some errors are very cryptic and very hard to debug for SwiftUI. I think using storyboards for this application is a better choice as it gives more control over the views.
