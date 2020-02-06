/*:
## Empty Canvas 2

Use this space to try out ideas.

*/

// Required frameworks
import PlaygroundSupport    // Allows playground to show live view
import SpriteKit            // Provides 2D graphics classes
import AVFoundation         // Provides classes to play audio files

// Define the animation size, scene, and scene color
let frame = CGRect(x: 0, y: 0, width: 400, height: 300)
var scene = SKScene(size: frame.size)

// Define, configure, and present the scene
let view = SKView(frame: frame)
view.showsNodeCount = true
view.presentScene(scene)

// Show the view in the live view area
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
### Useful Resources

#### Sprites

The [Sprite Database](http://spritedatabase.net/) has spritesheets for a wide variety of classic video games.

Of course, you can also draw sprites yourself (using an iPad, or by hand-drawing images and scanning or photographing them).

Note that [using copyrighted assets is permissable for personal use in Canada](https://en.wikipedia.org/wiki/Fair_dealing_in_Canadian_copyright_law), but if you wish to publish your work in any fashion – you need to find image assets with [compatible licensing terms](https://search.creativecommons.org).

[Open Game Art](https://opengameart.org) is another good option for graphics assets for your games or animations.

#### Decompiling Sprite Sheets

To use arrays of images you'd get very bored very quickly slicing up a spritesheet manually.

Programs exist that do this automatically for you.

1. Download and [install Adobe Air](https://get.adobe.com/air/).
2. Download and [install Shoebox](http://renderhjs.net/shoebox/).

After those programs are installed, you can [use a sprite sheet like this one](http://spritedatabase.net/files/snes/541/Sprite/MarioLuigi.gif), and [feed it into Shoebox like this](http://renderhjs.net/shoebox/extractSprites.htm) to extract the individual images.

#### Sound Assets

[The Sounds Resource](https://www.sounds-resource.com) has sound effects (like for a ray gun blast, jump sound effect, et cetera). Use the search box to find what you need.

[RetroTracks](https://retro.sx) is a great resource for full-length background music from classic video games.

[Audacity](https://www.fosshub.com/Audacity.html) is a reasonably capable open source app that is helpful for editing sound file clips, if needed.

#### Some Advice About Art and Music Assets

It's easy to go down a big rabbit hole – that is, spend a lot of time – looking for the "perfect" sound or music asset.

Try to avoid this. I suggest sticking with the links given above, or creating your own art and music assets, if that is an area you are skilled in.

Know that there are many, many free art and music assets out there.

Visual and audio artists do important work and deserve to be compensated fairly for that work – but you should not look to pay for art or music assets to complete a quick assignment for this class.

It would be a different converstaion – paying a reasonable sum for royalty free music or art assets – if you were looking to complete a larger project – especially if you were aiming to publish your work on the App Store.
 
 */

