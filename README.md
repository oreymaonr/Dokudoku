# Dokudoku

This is the basic sudoku game application without ads p.s I'm done with ads.

## Todo features
- Layout management
- selection of choice if right or wrong
- check  if all blanks are `cleared and correct`
- timer
- replay
- pause
- notifications
- animations
## Current Features
- Generates Board / renders board
- removes n and returns board
- shows options
- changes colors(almost)
- A heading card to show the possible parallel tasks
  
## Workflow 
1. tries to load existing board if not Generation of a new sudoku board with the new level (easy,medium,hard)
2. removing n digits from the sudoku board depending on N
3. click on each column shows the possible values, click on the choice gets the value there
4. if choice wrong, removes chance and color red. else color gets green checks if board completed
5.  finally, all chance over, then replay (#2) or game win
6.  when the user quits, game and timer is saved to a local file, which is created on spot when not found in place

### Parallel tasks
1. **Timer**
  - Timer runs which saves into the best 5 list with level
  - timer turns off when in background or app closed and restarts when picked up
  - new game == new timer
2. **Replay** a.k.a new game
    - Possible anytime of the game
    - asks the user a suggestion `are they sure?`
3. **Pause**
    - user can pause but a dialoge box comes in front of the board so they can't see the board
    - same as quit/resume but the UI open
4. **Notifications**
    - when the user is not playing he gets notified
      
