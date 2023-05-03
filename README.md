# animate_demo

Demo the `flutter_animate` package and integration with state management
package `provider`.

## Getting Started

This project highlights an unusual bug(?) where animations involving the
ScaleEffect behave differently when combined with:

- a FadeEffect
- and whether the ScaleEffect begin offset is zero or anything higher

Use the slider to move that ScaleEffect begin value between 0 and 0.1, and then
hit the Play button a couple of times to see whether both effects behave.

Note that when the ScaleEffect has begin == Offset.zero and it *follows* the
FadeEffect, the combined effect is broken. Any non-zero value for begin is a
workaround - as shown when you set the slider to the right (which uses a token,
small non-zero value).
