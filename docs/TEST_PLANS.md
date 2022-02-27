# Tests

## Unit Tests

Unit tests can be found in the [PeggleCloneTests](../PeggleClone/PeggleCloneTests/).

## UI Tests

- Main Screen
  - The main menu screen should look like [this](./screenshots/main.png).
- Playable levels (after clicking play)
  - The playable levels menu should look like this [this](./screenshots/playable-levels.png).
- Level Designer (after clicking design level)
  - The level designer should look like [this](./screenshots/designer.png)
  - The level designer should have a button selection menu at the top that looks like [this](./screenshots/designer-buttons.png).
  - The level designer should have counters and the board offset at the bottom that looks like [this](./screenshots/designer-counter.png).
  - Once a peg is added/selected, the level designer selection menu should change to [this](./screenshots/designer-peg.png).
  - Once a block is added/selected, the level designer selection menu should change to [this](./screenshots/designer-block.png).
- Saved levels (after click load in level designer)
  - The playable levels menu (after clicking load) should look like [this](./screenshots/saved-levels.png).
- Game (after starting a game either from playable levels or from the level designer)

  - The game view should look like [this](./screenshots/game.png).

- Repeat all the tests above on iPads set to light mode and dark mode so that we can ensure all UI elements show correctly.

## Integration Tests

- Main Menu

  - When clicking the `Play` button, it should open the list of saved levels. Preloaded levels should appear at the top.
  - When clicking the `Design Level` button, it should open the level designer.

- Playable Levels (opened from clicking the play button)

  - When clicking any of the levels in the list, it should immediately start the game with the level selected.
  - There should be screenshots present for non-preloaded levels.
  - Levels that have scrollable height should have the string "(Scrolling Level)" appended to the level name.

- Level Designer

  - Peg image buttons (selected buttons have a higher opacity than de-selected buttons):
    - The image buttons should be scrollable horizontally.
    - Orange peg button:
      - When application is launched, it should be selected by default.
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Blue peg button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Purple peg button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Gray peg button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Yellow peg button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Pink peg button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Orange block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Blue block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Purple block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Gray block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Yellow block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Pink block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Delete peg/block button:
      - When tapped, it should be selected and other peg image buttons should be de-selected.
    - Selecting any of these buttons above should change the action description to the appropriate description found right above the buttons.
  - Level designer board:
    - When orange peg is selected:
      - Tapping on board should create a new orange peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new orange peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new orange peg.
      - After a orange peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a orange peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When blue peg is selected:
      - Tapping on board should create a new blue peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new blue peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new blue peg.
      - After a blue peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a blue peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When purple peg is selected:
      - Tapping on board should create a new purple peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new purple peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new purple peg.
      - After a purple peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a purple peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When gray peg is selected:
      - Tapping on board should create a new gray peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new gray peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new gray peg.
      - After a gray peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a gray peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When yellow peg is selected:
      - Tapping on board should create a new yellow peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new yellow peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new yellow peg.
      - After a yellow peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a yellow peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When pink peg is selected:
      - Tapping on board should create a new pink peg.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new peg does not have enough space on the screen to display itself) should not create a new pink peg.
      - Tapping near other pegs/blocks (such that a new peg does not have enough space on the screen to display itself) should not create a new pink peg.
      - After a pink peg is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a pink peg is added, the sliders to adjust the rotation and radius should appear beside the image buttons.
    - When orange block is selected:
      - Tapping on board should create a new orange block.
      - Long pressing on any peg of any color should delete the peg/block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new orange block.
      - Tapping near other block (such that a new block does not have enough space on the screen to display itself) should not create a new orange block
      - After a orange block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a orange block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - When blue block is selected:
      - Tapping on board should create a new blue block.
      - Long pressing on any block of any color should delete the peg/block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new blue block.
      - Tapping near other blocks (such that a new block does not have enough space on the screen to display itself) should not create a new blue block.
      - After a blue block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a blue block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - When purple block is selected:
      - Tapping on board should create a new purple block.
      - Long pressing on any block of any color should delete the block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new purple block.
      - Tapping near other blocks (such that a new block does not have enough space on the screen to display itself) should not create a new purple block.
      - After a purple block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a purple block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - When gray block is selected:
      - Tapping on board should create a new gray block.
      - Long pressing on any block of any color should delete the block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new gray block.
      - Tapping near other blocks (such that a new block does not have enough space on the screen to display itself) should not create a new gray block.
      - After a gray block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a purple block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - When yellow block is selected:
      - Tapping on board should create a new yellow block.
      - Long pressing on any block of any color should delete the block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new yellow block.
      - Tapping near other blocks (such that a new block does not have enough space on the screen to display itself) should not create a new yellow block.
      - After a yellow block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a purple block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - When pink block is selected:
      - Tapping on board should create a new pink block.
      - Long pressing on any block of any color should delete the block.
      - Tapping on board edges (such that a new block does not have enough space on the screen to display itself) should not create a new pink block.
      - Tapping near other blocks (such that a new block does not have enough space on the screen to display itself) should not create a new pink block.
      - After a pink block is added, the counter found at the bottom of the level designer should increase appropriately.
      - After a purple block is added, the sliders to adjust the rotation, width and height should appear as well as the switch to toggle oscillation.
    - Selecting a peg
      - A peg can be selected any time by tapping on it.
      - A selected peg will have a "lit" image to indicate that it is currently selected.
      - Changing the slider values for rotation should change the rotation. Any rotation amount should be allowed (0 to 360 degrees).
      - Changing the slider values for radius should change the radius.
    - Selecting a block
      - A block can be selected any time by tapping on it.
      - A selected block will have a "lit" image to indicate that it is currently selected.
      - Changing the slider values for rotation should change the rotation. Any rotation amount should be allowed (0 to 360 degrees).
      - Changing the slider values for width should change the width.
      - Changing the slider values for height should change the height.
      - Enabling oscillation
        - Switching on the oscillation switch should enable oscillation.
        - The oscillation radius will be should be shown on the selected block with a gray circle.
        - The oscillation radius can be changed by dragging (either inwards or outwards) one of the four corners of the gray circle. A maximum and minimum radius is present.
    - When delete is selected:
      - Tapping on a peg should delete the peg.
      - Tapping on a block should delete the block.
    - When dragging any peg/block:
      - It should move the peg/block.
      - It should ensure that no two pegs/blocks overlap each other.
      - It should ensure that no peg and block overlap each other.
      - It should ensure that no pegs go out of the game board UI area. The bottom of the UI area is denoted using a solid gray line.
      - Dragging a peg/block quickly such that your finger ends on other peg/block before the dragged peg/block reaches the desired position, the dragged peg should stop at the **nearest valid location**.
    - Actions buttons:
      - When tapping on the trial play button, it should start the game.
      - When tapping on the `Level Name` textfield, it should allow the user to type in a level name. It should also bring up the iOS keyboard if no external keyboards are connected to the iPad.
      - When the `Level Name` textfield is empty, the save button should be disabled.
      - When the `Level Name` textfield is not empty, the save button should be enabled.
      - When tapping on the save button (after entering a level name), it should save the game board to storage after a confirmation alert. Reboot device to confirm that the level is indeed saved to storage.
      - When tapping on the reset button, it should reset the board to a brand new game board where all pegs are cleared (if there were any) and the `Level Name` is reset to being empty (if the user had typed a level name before) after a confirmation alert.
      - When tapping on the load button, it should bring up the Saved levels view after a confirmation alert.
        - Saved levels view
          - There should be preloaded levels present.
          - Preloaded levels can be loaded into the level designer. They can also be modified and saved. However, it should not be possible to overwrite the preloaded levels.
          - Preloaded levels should not have a screen shot.
          - When there are user saved levels, it should show the the levels in a scrollable list view with a game board screenshot and the game level name. Preloaded levels should appear at the top without a screenshot
          - When tapping a saved level, it should load the saved level. It should also dismiss the `Select a level to load` view.
          - When tapping the `Create New Level` button, it should have similar behavior to the reset button. Any pegs and level name will be cleared. It should also dismiss the `Select a level to load` view.
          - After loading a saved level, saving it after making any changes should update the saved level on the `Select a level to load` view. Both the screenshot and the level name should be update accordingly.
    - Creating levels of infinite height
      - Dragging on the designer board using one finger should move the designer up/down depending on the drag direction.
      - When the level is dragged up or down, to indicate the current drag location, a offset counter should increment and decrement accordingly. This offset counter can be found at the bottom left corner of the level designer.
      - It should only be possible to add pegs/blocks in the downward direction.
      - Pegs/Blocks can be added as per normal as mentioned above.
      - Pegs/Blocks can be dragged as per normal as mentioned above.
      - Levels that have a scrollable height should have the string "(Scrolling Level)" appended to their level name in the saved levels view.

- Preloaded Levels

  - There should be 3 preloaded levels.
  - Levels that do not scroll on one iPad should not scroll on iPads of other screen sizes.
  - Preloaded levels as seen in the playable levels and saved levels views should look similar when using iPads with different screen sizes.
  - The aspect ratios should be preserved.
  - The user should be able to load any of these preloaded levels into the level designer and modify them, saving as a new level.
  - The user should not be able to override the preloaded levels.

- Playing the game

  - Main game ball is red in color while helper game balls are dark gray.

  - When dragging on the screen, the cannon should change angle such that it point to your finger.
  - After dragging, the cannon should fire a ball after your finger lifts from the screen.
  - When dragging, it should not be possible to change the angle of the cannon to point upwards.
  - When dragging, there should be a maximum angle that the cannon will rotate to. This is to ensure that the ball always fires downwards.
  - When the screen is tapped (when the cannon is loaded), it should fire towards the tapped location.

  - Ball launch

    - After firing, the ball should be launched from the top-center of the screen.
    - As mentioned in **Playing the game** section, the ball should launch towards the direction of your finger.
    - No matter what you do, it should not be possible to launch the ball upwards. Only downward direction is allowed.
    - After a ball launch, the cannon should be in the unloaded state. This is depicted by a change in a the way the cannon looks.

  - Ball movement

    - When launched, the ball should move according to the laws of physics. There should be reasonable movement.
    - When launched, the ball should be subjected to gravity and the initial launch force.
      The initial force is apparent as it is launched towards your finger.
      Gravity might not be so apparent here because of the initial launch force.
      However, it will be apparent in other tests (for example, when the ball gets stuck on top of a wall of pegs).
    - When the ball is moving, the game should allow you to aim your cannon (the cannon is able to change angle).
    - When the ball is moving, the game should never launch another ball.

  - Ball collision (after a launch) and peg/block lighting

    - When the ball collides with a peg, it should bounce according to the laws of physics. The ball should be bouncy and the movement must be reasonable.
    - When the ball collides with a wall, it should bounce according to the laws of physics. The ball should be bouncy and the movement must be reasonable.
    - When the ball collides with a block, it should bounce according to the laws of physics. The ball should be bouncy and the movement must be reasonable.
    - When the ball touches a peg, it should light up as it indicates a collision.
    - When the ball touches a peg, it should remain lit.
    - When the ball touches a block, it should remain lit.
    - When the ball touches the cannon, there should be no collision, it should pass through it as if it does not exist.

  - Peg/Block removal

    - Once the ball exits the game view, lit pegs should be removed.
    - Once the ball exits the game view, lit block should be un-lit but should not be removed.
    - Once the ball exits the game view, lit pegs should be removed with a fade-out scaling animation.
    - Once the ball exits the game view, the score should be updated.
    - When the game reaches a situation in which the ball is "stuck" and no longer able to move,
      the pegs/blocks causing it to be stuck should be removed prematurely so that the ball can move down.
      This can be tested by creating a level like [this](./screenshots/wall-of-pegs.png).
      Another way is to just add a lot of pegs to the level, the ball is highly likely to get stuck at some point.
    - When the pegs are removed, the game should allow you launch the game again.

  - Bucket

    - The bucket should be at the bottom of the screen.
    - The bucket should move left and right in a deterministic way.
    - There should be a special effect in the game once the ball enters the bucket. The number of balls left should increase by 1 (you get a free ball).
    - Collision between bucket
      - When the spooky ball powerup is activated, the ball that activated the powerup will not be able to enter the bucket. Instead it will just collide normally.

  - Win/Lose Conditions

    - Win the game by clearing all orange pegs. When the game is won a winning alert should pop up showing you your final score.
    - You lose the game by either running out of balls before hitting all orange pegs or your 2 min timer expires. A lose alert should pop up when the game is lost.

  - Powerups

    - KaBoom (activated when ball hits a blue peg)

      - The blue peg explodes.
      - The blue peg that explodes causes nearby pegs close to it to be destroyed.
      - Any other blue peg being destroyed in the blast also explodes, possibly setting off a chain reaction.
      - The explosion should knock the ball off its original trajectory.

    - Spooky Ball (activated when ball hits a purple peg)
      - When the spooky ball powerup is activated, the ball should collide with the bucket instead of entering it.
      - When the ball goes below the gameplay area (when the ball exits the game view), it reappears at the top of the gameplay area at the same x-axis position.

  - Blocks

    - Blocks that are static (decided by the user in the level designer) should not move.
    - Blocks that are springy (decided by the user in the level designer) should move like a damped spring. The springiness can be adjusted by the user in the level designer.
    - Oscillating blocks should exert more force or less force on the ball depending on the status of their oscillations, as compared to stationary blocks.
    - For simplicity, oscillating objects in the game should not collide with each other. They will simply pass through.
    - A level should be able to have both static and oscillating blocks. This is decided by the user in the level designer.

  - Scrolling levels

    - When the level is a scrollable level (level with arbitrary height), the game view should "scroll" accordingly depending on your game ball position.
    - There should be a bucket at the bottom of the scrollable level. The behavior should be the same as described in the **Bucket** section.

- Repeat all the tests above on multiple iPads with different screen sizes, it should produce exactly the same behavior as described above.

Some notes to take note during tests:

1. Saving a empty board is allowed as long as there is a level name
1. Saving multiple boards with the same name is allowed. A "copy" suffix will be added to differentiate the levels.
1. If the user (after launching the application) adds pegs and types in a level name and without saving brings up the load view, going back by clicking the `Create new level` will reset the board and any progress made will be lost as the user did not save it.
1. Landscape orientation is not supported. The application is only intended for portrait use.
