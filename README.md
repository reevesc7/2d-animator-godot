# 2D Animator

A simple 2D animation system, implemented in Godot v4.2 for maximum flexibility.


## Features

This animation system includes a variety of tools for moving elements around on the screen and reporting their properties as they move.


### Props

Props are the center of the animation system, the waypoints for each other element.

Props are, at their most basic, points in a 2D space. They can be moved by Animators, included as points along PathVisuals, etc. They can have sprites attached to them to make their locations visible, and Reports use their properties as references.


### Animators

Animators move Props.

All Animators can target an arbitrary number of Props and will affect each target in the same way, at the same time when triggered.

The current list of Animators is as follows:
* **ToPointAnimator**: Moves targets to either an absolute point or an offset relative to the starting location of each target.
* **FollowAnimator**: Moves targets along a path defined by a set of Props, either absolutely or relative to the starting location of each target.
* **ResetAnimator**: Moves targets to their locations in the editor.


### Targeters

Targeters are the main way for elements to reference one or more Props.

All elements that can reference an arbitrary number of Props (e.g., Animators, PathVisuals) do so via a Targeter. Any Props the Targeter targets will be affected by any elements which reference the Tergeter. For example, if a user wanted to move a set of 4 Props to a common location, they could assign each of the Props as a child of a Targeter and then reference that Targeter with a ToPointAnimator. If the user also wanted to reset the locations of those Props, they could reference the same Targeter with a ResetAnimator.

Props can be referenced by multiple Targeters, but elements which reference Targeters can not reference multiple Targeters. If Props need to be referenced as a set as well as subsets, a different Targeter must be used for each set and subset.


### Reports

Reports display information about the properties of various elements.

The current list of Reports is as follows:
* **PositionReport**: Displays the scaled position of the targeted Prop.
* **AngleReport**: Displays the signed angle between a an initial and terminal Prop, relative to a vertex Prop.
* **LengthReport**: Displays the total scaled length of the distance between each of the targeted props, in order.


### Misc

* **DragButton**: A button which, when clicked and held, causes the targeted Prop to follow the mouse.
* **Offsetter**: Offsets the position of a Prop by the scaled numerical value of a Report.
* **Connector**: Connects all of the targeted Props to one another with PathVisuals.


## TODO

- [ ] Allow for more felxible target ordering by Targeters.
- [ ] Implement a Minimum Spanning Tree (MST) algorithm for Connectors.
