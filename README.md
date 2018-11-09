# hawkDoveBet

This is a betting contract where two individuals bet on some future outcome. They must each deposit a `stakeAmount` and a `betAmount`. Once the outcome has occured, the individuals each report whether they won or lost the bet. If one reports a win and the other reports a loss, the winner receives both individuals' bet amounts as well as the winner's refunded stake amount. If both individuals report a loss, then they each get to withdraw all of their respective funds. If both players report a win, however, all funds are burned. 

### Rationale

This is a situation akin to territorial behavior, where an individual will defend his or her property even if that fight is very costly to the individual. A potential attacker, taking this into consideration, will be less likely to try to take another individual's territory.


This was inspired by David D. Friedman's [A Positive Account of Property Rights](http://www.daviddfriedman.com/Academic/Property/Property.html). 
