## [Project 27: Core Graphics](https://www.hackingwithswift.com/read/27/overview)
Written by [Paul Hudson](https://www.hackingwithswift.com/about)  ![twitter16](https://github.com/juliangyurov/PH-Project6a/assets/13259596/445c8ea0-65c4-4dba-8e1f-3f2750f0ef51)
  [@twostraws](https://twitter.com/twostraws)

**Description:** Draw 2D shapes using Apple's high-speed drawing framework.

- Setting up

- Creating the sandbox

- Drawing into a `Core Graphics` context with `UIGraphicsImageRenderer`

- Ellipses and checkerboards

- Transforms and lines

- Images and text

- Wrap up
  
## [Review what you learned](https://www.hackingwithswift.com/review/hws/project-27-core-graphics)

**Challenge**

1. Pick any emoji and try creating it using `Core Graphics`. You should find some easy enough, but for a harder challenge you could also try something like the star emoji.

2. Use a combination of `move(to:)` and `addLine(to:)` to create and stroke a path that spells “TWIN” on the canvas.

3. Go back to project 3 and change the way the selected image is shared so that it has some rendered text on top saying “From Storm Viewer”. This means reading the size property of the original image, creating a new canvas at that size, drawing the image in, then adding your text on top.
