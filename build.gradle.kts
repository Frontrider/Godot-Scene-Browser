import io.github.frontrider.godle.dsl.versioning.asGodot
import io.github.frontrider.godle.publish.dsl.AssetCategories
import io.github.frontrider.godle.publish.dsl.currentCommitHash

plugins{
    id("io.github.frontrider.godle") version "0.13.0"
    id("io.github.frontrider.godle-publish") version "0.3.1"
}

group = "io.github.frontrider"
version = "2.0.2"

godle{
    asGodot("3.5.1")
    addons {
        clearAddonsBeforeInstall = false
        install{
        }
    }
}

val godotUsername:String by project
val godotPassword:String by project

godlePublish{
    create("scene browser"){
        id.set("1070")
        description = """
            Lets you view scenes inside the folder "assets/components", in a list, then add them to your current scene when you need it to make level editing easier. (not limited to levels alone, but that is the primary intention of the addon)

            Also features additional post-import scripts to make it easier to work with certain model types.

            I recommend "snappy" to provide smooth vertex snapping with this to get a solid level editing experience.
            https://github.com/jgillich/godot-snappy 
        """.trimIndent()
        supportLevel.set("community")
        downloadProvider.set("GitHub")
        category = AssetCategories.Tools
        godotVersion.set("3.5")
        vcsUrl.set("https://github.com/Frontrider/Godot-Scene-Browser/")
        iconUrl.set("https://raw.githubusercontent.com/Frontrider/Godot-Scene-Browser/${currentCommitHash()}/components.png")

        credentials{
            username = godotUsername
            password = godotPassword
        }
    }
}