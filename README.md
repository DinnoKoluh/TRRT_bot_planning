# The implementation of the T-RRT algorithm for path planning in a configurational space based on cost maps

## About

This project deals with path planning for robot manipulators using sampling-based algorithms in a
configuration space equipped by a specific cost function. The key algorithm used for path planning
is the T-RRT algorithm which is a modification of the basic RRT algorithm. The T-RRT algorithm
searches for a path which spans over the regions of the configuration space costmap which represent
“passes”, “canyons” and “valleys” i.e. regions which have a low cost, while it tends to bypass high
cost regions. Using a convenient cost function, which models the problem’s criterion, with the T-
RRT algorithm we get paths which fulfill the stated criterion while the RRT algorithm, in the general
case, is not able to carry out such a task. An example of a criterion which we are going to use is the
requirement for the tip of the manipulator to be at the furthest possible distance from the obstacles
in the working space which ensures its safety.
The parameters which are integrated inside the T-RRT algorithm influence its performance and the
final shape of the path so a great number of simulations was conducted, with various types of robot
manipulators, to analyze the influence of individual parameters on the path. These examples were
compared with the shapes of paths obtained with the RRT algorithm. All the algorithms have been
implemented within the Matlab programming package.

<p align="center">
  <img alt="Light" src="Images\SVGfigures\matTRRT1_iter8464_full.svg" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="Images\SVGfigures\matMi2_iter98.svg" width="45%">
</p>

<p align="center">
  <img alt="Light" src="Images\SVGfigures\botMat2SPR_TRRT_CS.svg" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="Images\SVGfigures\botMat2SPR_TRRT_WS.svg" width="45%">
</p>