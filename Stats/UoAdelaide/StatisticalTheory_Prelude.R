'#Learning Statistics with R - University of Adelaide

## Part IV - Statistical Theory

### Prelude

**Statistical inference** is primarily about *learning from data.* The goal is no longer merely to *describe* our 
data, but to *use* the data to draw conclusions about the world. 

**The Riddle of Induction** - a philisophical puzzle that speaks to an issue that will pop up over and over again
  * statistical inference relies on **assumptions.** 
  * This sounds like a bad thing. In everyday life people say to never make assumptions, and psychology classes often talk
about assumptions and biases as bad things we should try to avoid. 
  * From bitter personal experience I have learned never to say such things around philosophers.

All of life is a guessing game of 1 form or another, and getting by on a day to day basis requires us to make good 
guesses. Suppose you and I are observing the Wellesley-Croker competition, and after every 3 hills you and I have
to predict who will win the next one, Wellesley. After 3 hills, our data set looks like this: WWW

One might say 3 in a row doesn't mean much. You suppose Wellesley might be better at this than Croker, but it might 
just be luck. Still, as a bit of a gambler, bet on Wellesley. Others agree that 3 in a row isn't informative, and 
others see no reason to prefer Wellesley's guesses over Croker's. Others can't justify betting at this stage. Your 
gamble paid off: 3 more hills go by, and Wellesley wins all 3 Going into the next round of our game the score is 1-0
in favour of you, and our data set looks like this: WWW WWW.

Described above is sometimes referred to as the **riddle of induction**: it seems entirely reasonable to think that 
a 12-0 winning record by Wellesley is pretty strong evidence he will win the 13th game, but it is not easy to 
provide a proper *logical* justification for this belief. On the contrary, despite the obviousness of the answer, 
it's not actually possible to justify betting on Wellesley without relying on some assumption that you don't have 
any logical justification for.

Assumptions and biases are unavoidable if you want to learn anything about the world, and it is just as true for 
statistical inference as it is for human reasoning. 
  * "Common sense" = implicit assumption that there exists some difference in skill between Wellesley and Croker, 
    and you were trying to work out what that difference in skill level would be. 
  * "logical analysis" rejects that assumption entirely, and accepts accept there are sequences of wins and losses, 
    and that we did not know which sequences would be observed, insisting that all logically possible data sets were
    equally plausible at the start of the Wellesely-Croker game
  * sounds perfectly sensible on its own terms. In fact, it even sounds like the hallmark of good *deductive*
    reasoning --> rule out that which is impossible, in the hope that what would be left is the truth. 
  * Yet, *ruling out the impossible never led me to make a prediction.* 
  * An inability to make any predictions is the logical consequence of making "no assumptions". 

2 things to ultimately take away from this. 
  * Firstly, you cannot avoid making assumptions if you want to learn anything from your data.
  * Secondly, once you realise  assumptions are necessary, it becomes important to make sure you make the *right*
    ones! 

A data analysis that relies on *few* assumptions is not necessarily better than one that makes *many* assumptions. 
It all depends on whether those assumptions are good ones for your data.'