# Scene Browser
A small Godot addon that makes it easier to make levels within the editor by giving you better access to the scenes you need for that.

I recommend the snappy addon as a good companion.
https://github.com/jgillich/godot-snappy

Feedback is appriciated, I won't make any promises but I actively use this tool, so I have good incentives at least.

# Usage
## Adding scenes
When the addon is eanbled, it will create a folder called `res://assets/components/`. You can place scenes in this folder, and they will show up in the browser. This is done to separate them from other sub-scenes that you would not add to your levels directly (say a projectile emitter).

## Grouping scenes
You can place scenes in the created `components` folder, but you can create subfolders to group them together. The `CategoryList` dropdown can be used to select between the categories. You can not create nested categories, the addon will only load folders up to one level.

## Custom icons

There is a default icon for your components, but you can place a png file with the same name as the scene in the same folder to use that (if the scene is `res://assets/components/example/example_component.tscn`, the image should be `res://assets/components/example/example_component.png`), and it will be displayed instead.

## Adding them to the scene

When you doubleclick an item in the component list it will be added as a child of the currenty selected node.


# Import scripts

Some assets like `*.obj` files need extra scripts to be compatible out of the box, the addon comes with a few import scripts for those.




Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
