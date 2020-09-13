# Block editor addon for Cockpit CMS

This addon replaces the layout and the layout-grid fields of [Cockpit CMS][1] with a visual block editor.

**draft/experimental**

I always liked the data structure of the core layout field, but the visual experience wasn't very intuitive. Also editing everything in modals didn't feel right and after each try I stopped using it.

So, with the [Gutenberg][5] block editor from WordPress in mind, I started to rewrite the layout field and it works pretty well in my first tests.

It should be compatible with the [LayoutComponents addon][2] and with the [CustomComponents addon][3].

It shares the same data structure with the core layout field. So if you don't like the block editor, just remove this addon and continue working with the core field.

The current development state is a draft and you will see some `console.log()` output in your browser console.

Please report bugs and send feedback in the issues section or in the [Cockpit community forum][4].

## Installation

Copy this repository into `/addons` and name it `BlockEditor` or

```bash
cd path/to/cockpit
git clone https://github.com/raffaelj/cockpit_BlockEditor.git addons/BlockEditor
```

[1]: https://github.com/agentejo/cockpit
[2]: https://github.com/agentejo/LayoutComponents
[3]: https://github.com/pauloamgomes/Cockpit-CustomComponents
[4]: https://discourse.getcockpit.com/
[5]: https://wordpress.org/gutenberg/
