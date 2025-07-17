# JHU_Placement_Assessment

## Question 1: Scatter Plot of Natural Disasters by Death Toll

This scatterplot shows the deadliest natural disasters of the 20th and 21st centuries, showing when each event happened (horizontal/x axis) and roughly how many people lost their lives (vertical/y axis). Every point on the plot represents a disaster, and its color indicates the type.

The dot’s position shows its year and death toll. The deadliest event is a flood in 1930s, which causes over 2 million deaths. Most disasters are near the bottom of the chart (under 100000 deaths), showing that most catastrophic tolls are relatively rare. Especially in recent decades, the large death tolls become less frequent, demonstrating better systems, infrastructure, and emergency response.


## Question 2: Gradient Descent

For the smallest learning rate, the algorithm makes very tiny steps and converges slowly. After a number of iterations, the result is a bit off the true b. As the learning rate increases to a moderate range, it finds the trade-off, balances speed and stability, so we get the correct value with low final error. When learning rate becomes too large, each update overshoots the minimum and the estimates start to blow up, gradient descent diverges rather than converges, so we get NaN in the result.