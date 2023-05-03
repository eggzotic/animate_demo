# animate_demo

Demo the `flutter_animate` package and integration with state management
package `provider`.

## What's it all about?

This project has been developed and tested on Flutter-web for:

- Windows-chrome
- MacOs-chrome

This project highlights an unusual behaviour (bug?) where animations involving
the `ScaleEffect` behave differently when combined with:

- a `FadeEffect` (order-dependent)
- and whether the `ScaleEffect`'s `begin` offset is zero or anything higher

Use the slider to move that `ScaleEffect` `begin` value between `0` and `0.1`, and then
hit the Play button a couple of times to see whether both effects behave.

Note that when the `ScaleEffect` has `begin == Offset.zero` and it *follows*
the `FadeEffect`, the combined effect is broken (`ScaleEffect` does not arrive
back at `end == 2`). Using any non-zero value for `begin` is a workaround - as shown
when you set the slider to the right (which uses a token, small non-zero
value of `0.1`).
