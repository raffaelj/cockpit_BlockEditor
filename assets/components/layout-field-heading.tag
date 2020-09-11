<layout-field-heading>

    <raw show="{ mode == 'show' }" content="<{opts.item.settings.tag || 'h2'}>{ opts.item.settings.text }</{opts.item.settings.tag || 'h2'}>" onclick="{ edit }"></raw>

    <div ref="input" class="uk-flex uk-flex-middle" show="{ mode == 'edit' }">
        <field-text bind="{ opts.bind }.text" class="uk-flex-item-1"></field-text>
        <field-select bind="{ opts.bind }.tag" options="{ tagsOptions }" class="uk-margin-small-left"></field-select>
    </div>

    <script>

        var $this = this;

        this.mode = opts.item.settings.text ? 'show' : 'edit';

        opts.options.fields.forEach(function(field) {

            if (field.name == 'tag') {

                $this.tagsOptions = field.options.options;

            }
        });

        this.parent.on('leavecomponent', function() {
            $this.show();
        });

        this.edit = function() {

            this.mode = 'edit';
            this.update();
            this.refs.input.querySelector('input').focus();

        }

        this.show = function() {

            if (opts.item.settings.text) {

                this.mode = 'show';
                this.update();
            }
        }

    </script>

</layout-field-heading>
