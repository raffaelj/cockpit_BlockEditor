<block-text>

    <raw show="{ mode == 'show' }" content="{ opts.item.settings.text }" onclick="{ edit }"></raw>

    <div ref="input" show="{ mode == 'edit' }">
        <field-wysiwyg bind="{ opts.bind }.text" editor="{ editorOptions }"></field-wysiwyg>
    </div>

    <script>

        var $this = this;

        this.mode = opts.item.settings.text ? 'show' : 'edit';
        this.wasMoved = false;

        this.editorOptions = {};


        opts.options.fields.forEach(function(field) {

            if (field.type == 'wysiwyg' && field.options && field.options.editor) {

                $this.editorOptions = field.options.editor;

            }
        });

        this.on('update', function() {
// console.log('layout-field-text update', opts.bind);
        });

        // https://www.tiny.cloud/docs-4x/advanced/events/#blur
        App.$(document).on('init-wysiwyg-editor', function(e, editor) {
            editor.on('blur', function (e) {
// console.log('editor blur', e);
                $this.show(e);
//                 $this.parent.trigger('leavecomponent');
            });

            // enable autoresize
            editor.settings.height = null;
            editor.settings.resize = false;
            editor.settings.autoresize_on_init = true;
            editor.settings.autoresize_overflow_padding = 0;
            editor.settings.autoresize_bottom_margin = 0;
            editor.settings.autoresize_min_height = 40;
            if (!editor.settings.plugins.match(/autoresize/)) {
                editor.settings.plugins = editor.settings.plugins + ' autoresize';
            }
// console.log(editor.settings);
        });

        this.edit = function() {
            this.mode = 'edit';
            this.update();
        }

        this.parent.on('leavecomponent', function() {
            $this.show();
        });

        this.show = function(e) {

            // wait a moment until activeElement is available again
            setTimeout(function() {
                if (opts.item.settings.text
                    && !$this.refs.input.contains(document.activeElement)
                    && !(document.activeElement.classList.contains('layout-component')
                        && document.activeElement.contains($this.refs.input))
                ) {
                    $this.mode = 'show';
                    $this.update();
                }
            });

        }

        this.parent.on('componentmoved', function() {

            // destroy and recreate wysiwyg editor when component moved
            var editorId = $this.refs.input.querySelector('textarea').id,
                editor   = tinymce.get(editorId),
                editorSettings = editor.settings;

            tinymce.EditorManager.execCommand('mceRemoveEditor', false, editorId);
            new tinymce.Editor(editorId, editorSettings, tinymce.EditorManager).render();

        });

    </script>

</block-text>
