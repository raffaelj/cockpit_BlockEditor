# Block editor addon for Cockpit CMS

**This addon is not compatible with Cockpit CMS v2.**

See also [Cockpit CMS v1 docs](https://v1.getcockpit.com/documentation), [Cockpit CMS v1 repo](https://github.com/agentejo/cockpit) and [Cockpit CMS v2 docs](https://getcockpit.com/documentation/), [Cockpit CMS v2 repo](https://github.com/Cockpit-HQ/Cockpit).

---

This addon replaces the layout and the layout-grid fields of [Cockpit CMS][1] with a visual block editor.

**draft/experimental**

I always liked the data structure of the core layout field, but the visual experience wasn't very intuitive. Also editing everything in modals didn't feel right and after each try I stopped using it.

So, with the [Gutenberg][5] block editor from WordPress in mind, I started to rewrite the layout field and it works pretty well in my first tests.

It should be compatible with these addons:

* [LayoutComponents][2]
* [CustomComponents][3] (obsolete since Cockpit version 0.11.0 - [commit][7])
* [EditorFormats][6]

It shares nearly the same data structure with the core layout field. So if you don't like the block editor, just remove this addon and continue working with the core field.

**The current development state is a draft and you <del>will</del> might see some `console.log()` output in your browser console.**
To see all debug output, set `{"debug":true"}` in the field options of your layout field.

Please report bugs and send feedback in the [issues section][8] or in the [Cockpit community forum][4].

## Installation

Copy this repository into `/addons` and name it `BlockEditor` or use the cli.

### via git

```bash
cd path/to/cockpit
git clone https://github.com/raffaelj/cockpit_BlockEditor.git addons/BlockEditor
```

### via cp cli

```bash
cd path/to/cockpit
./cp install/addon --name BlockEditor --url https://github.com/raffaelj/cockpit_BlockEditor/archive/master.zip
```

### via composer

Make sure, that the path to cockpit addons is defined in your projects' `composer.json` file.

```json
{
    "name": "my/cockpit-project",
    "extra": {
        "installer-paths": {
            "addons/{$name}": ["type:cockpit-module"]
        }
    }
}
```

```bash
cd path/to/cockpit-root
composer create-project --ignore-platform-reqs aheinze/cockpit .
composer config extra.installer-paths.addons/{\$name} "type:cockpit-module"

composer require --ignore-platform-reqs raffaelj/cockpit-blockeditor
```

## Overwrite block templates

Create your own blocks in `path/to/cockpit/config/tags` with the file naming schema `block-<block name>.tag`.

Example for divider block:

Copy `addons/BlockEditor/assets/components/block-divider.tag` to `config/tags/block-divider.tag` and modify it.

Before (grey, solid 1px line):

```html
<block-divider>
    <hr>
</block-divider>
```

After (dashed 2px line with scissors on the left side):

```html
<block-divider class="uk-flex">
    <style>
        hr {
            width: 100%;
            margin: .5em 0.2em 0;
            border-top: 2px dashed #ccc;
        }
    </style>

    <i class="uk-icon-scissors uk-text-muted"></i>
    <hr>
</block-divider>
```

## Use existing block templates with a custom component

<del>This doesn't work with the LayoutComponents addon, because it doesn't provide the option to create custom block options.</del>

I wrote an improved settings page for the LayoutComponents addon in which you can set the `block` key.

You can define your custom components in the field options instead with the key `"block": "text"`. Now the component will use the text block template.

In the following example I also used the EditorFormats addon to define a wysiwyg field with minimal editing options.

field type: `layout`

options:

```json
{
  "components": {
    "textminimal": {
      "label": "Text (minimal)",
      "block": "text",
      "fields": [
        {
          "name": "text",
          "type": "wysiwyg",
          "options": {
            "editor": {
              "format": "Minimal"
            }
          }
        }
      ]
    }
  }
}
```

## License, credits and third party resources

License: MIT, author: Raffael Jesche

I used the following codes as a base and changed a lot of the code inside them:

* [layout field][9] from Cockit CMS, author: Artur Heinze, MIT licensed
* [layout-grid field][9] from Cockit CMS, author: Artur Heinze, MIT licensed
* settings page from [LayoutComponents addon][2], author: Artur Heinze, MIT licensed



[1]: https://github.com/agentejo/cockpit
[2]: https://github.com/agentejo/LayoutComponents
[3]: https://github.com/pauloamgomes/Cockpit-CustomComponents
[4]: https://discourse.getcockpit.com/t/new-addon-blockeditor-layout-field-with-visual-block-editor-draft-experimental/1639
[5]: https://wordpress.org/gutenberg/
[6]: https://github.com/pauloamgomes/CockpitCms-EditorFormats
[7]: https://github.com/agentejo/cockpit/commit/d440ae7b5344d5eb24987f2391a84529224528c2
[8]: https://github.com/raffaelj/cockpit_BlockEditor/issues
[9]: https://github.com/agentejo/cockpit/blob/next/modules/Cockpit/assets/components/field-layout.tag
