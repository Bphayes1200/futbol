# Futbol

## What was the most challenging aspect of this project?
- We all struggled with the github workflow. We found it to be extremely stressful when we had only one file to create all the methods in.  A number of methods were deleted from merge conflicts and had to be put back in.  
## What was the most exciting aspect of this project?
- We found that when we started to organize our code within classes, we were able to avoid merge conflicts, which was exciting and allowed us to work more efficiently. 
## Describe the best choice enumerables you used in your project. Please include file names and line numbers. 
- Max_by sorted our hashes to have the highest value be the first key value pair in our hashes all the way down to the lowest key being the last key value pair in our hash. We used this enumerable in the majority of our methods in the season_stats.rb file on lines 16, 54, and 104 and it was extremely helpful. 
## Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
- We created a module called calculable that stored many of our helper methods that we used between our different classes. We chose to use a module because we just had a random assortment of helper methods that would not be fit to organize in a superclass. 
## Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
- The unit test we are most proud of is with our count_of_games_by_season method on line 29 in the game_stats.rb file. This tested just one method to ensure that it would map across the games.csv file and return a hash of games played by season.
- The integration test we are most proud of is the best_season test on line 36 in the the team_stats_spec.rb file. This tested the method best_season, which contains method calls from 4 different methods.
## Is there anything else you would like instructors to know?
### Questions
- Amy: Not quite understanding why there are this many files.  Clearly there needed to be more than one class, but for me it became more challenging to read the files when they were so broken up.   Is it to decrease the the test running time?  Also I was wondering if you could provide some specific examples of the unit/integration test.  Brian asks about it in his question.
- Brian: Can an integration test call only one method that uses helper methods or other method calls inside of it? Or would an integration test be different from our example above?

- Caleb - How come splitting up the single StatTracker file makes the spec_harness run so much faster? Isn’t the same amount of code being run, but just across multiple files now? Is it because of the way Ruby reads code, and it is actually faster for Ruby to jump to a file that is called upon to access the method, rather than having all the methods in one file and starting over for every test?

- Matt: If you have a class that isn’t storing state, is it more appropriate for that to be a module? Is it OK for modules to have more code than the classes they’re included in?

- Matt: What are some refactoring strategies that maintain readability.  How long is too long for variable and method names that need to be descriptive?

- Matt: As far as sample test data, is it common to have to refactor it? What are some ideas to help come up with dummy data that is an appropriate sample of the real data?

