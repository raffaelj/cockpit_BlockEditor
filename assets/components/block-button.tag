<block-button>

    <style>
        input[type=text].button-input {
            font-size: 14px;
            font-weight: normal;
            background-color: rgba(255,255,255,0.9);
            padding-left: 0.5em;
            padding-right: .5em;
        }
        input[type=text].button-input:focus {
            background-color: rgba(255,255,255,0.9);
        }
        .uk-button.button-editable {
            cursor: default;
        }
    </style>

    <div class="uk-text-center" show="{ mode == 'show' }">
        <a class="uk-button uk-button-primary uk-button-large" href="{ opts.item.settings.url || '' }" title="{ opts.item.settings.url || '' }" target="_blank" onclick="{ edit }">{ opts.item.settings.text || '' }</a>
    </div>

    <div ref="input" class="uk-container-center uk-text-center uk-width-large-2-3 uk-width-xlarge-1-2" show="{ mode == 'edit' }">

        <div class="uk-button uk-button-primary uk-button-large button-editable">
            <input type="text" bind="{ opts.bind }.text" class="button-input" title="{ App.i18n.get('Text') }" />
        </div>
        <input type="text" bind="{ opts.bind }.url" class="uk-margin-small-left" title="{ App.i18n.get('Url') }" />

    </div>

    <script>

        var $this = this;

        this.mode = opts.item.settings.text ? 'show' : 'edit';

        this.parent.on('component.leave', function() {
            $this.show();
        });

        this.edit = function(e) {

            if (e) e.preventDefault();

            this.root.closest('.layout-component').dataset.active = 1;

            this.mode = 'edit';
            this.update();
            this.refs.input.querySelector('input').focus();

        }

        this.show = function() {

            this.root.closest('.layout-component').dataset.active = 0;

            if (opts.item.settings.text) {

                this.mode = 'show';
                this.update();
            }
        }

    </script>

</block-button>
