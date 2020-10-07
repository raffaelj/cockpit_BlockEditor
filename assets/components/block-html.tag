<block-html>
    <style>
        .uk-invisible,
        .uk-invisible .uk-htmleditor-code,
        .uk-invisible .uk-htmleditor-preview,
        .uk-invisible field-html {
            height: 0 !important; /* leads to wrong height detection in htmleditor.js */
            visibility: hidden;
            margin: 0;
            padding: 0;
        }

        .uk-htmleditor-navbar {
            position: absolute;
            bottom: 100%;
        }
        field-html .uk-htmleditor-preview {
            height: 100% !important; /* force height via css because of wrong inline style with height:0 */
        }
    </style>

    <raw show="{ mode == 'show' }" content="{ opts.item.settings.html }" onclick="{ edit }"></raw>

    <div ref="input" class="{ (mode == 'show') && 'uk-invisible' }">
        <field-html bind="{ opts.bind }.html" class=""></field-html>
    </div>

    <script>

        // https://codemirror.net/doc/manual.html
        // https://getuikit.com/v2/docs/htmleditor.html

        var $this = this;

        this.mode   = opts.item.settings.html ? 'show' : 'edit';
        this.editor = null;
        this.cursor = null;

        App.$(document).on('init-html-editor', function(e, editor) {

            // set height to auto
            editor.options.height = 'auto';
            editor.options.codemirror.height = 'auto';
            editor.options.codemirror.viewportMargin = 'Infinity';
            editor.preview.parent().css('height', 'auto');
            editor.preview.css('height', 'auto');
            editor.code.css('height', 'auto');
            editor.code.find('.CodeMirror').css('height', 'auto');

        });

        this.on('mount', function() {
            this.update();
        });

        this.on('update', function() {

            if (this.editor) return;

            if (!this.refs.input) return;
            var el = this.refs.input.querySelector('.CodeMirror');
            if (!el) return;

            this.editor = el.CodeMirror;

        });

        this.edit = function() {

            this.root.closest('.layout-component').dataset.active = 1;

            this.mode = 'edit';
            this.update();

            this.editor.focus();
            this.editor.setCursor(this.cursor || this.editor.getCursor());

        }

        this.on('component.leave', function() {
            $this.show();
        });

        this.show = function(e) {

            this.root.closest('.layout-component').dataset.active = 0;

            if (this.editor) this.cursor = this.editor.getCursor();
            this.mode = 'show';
            this.update();
        }

        this.parent.on('component.moved', function() {

            // avoid weird cursor reset after first char input in moved codemirror
            // if bind changes, $updateValue of field-html has a force option --> avoid that and avoid setting
            // the value of the editor, which causes the cursor reset to 0,0 after the first input
            var el = $this.refs.input.querySelector('field-html');
            el.__bindField = el._tag.opts.bind;

            // set focus back to editor after component moved
            if ($this.mode == 'edit' && $this.editor) {
                $this.editor.focus();
            }

        });

    </script>

</block-html>
