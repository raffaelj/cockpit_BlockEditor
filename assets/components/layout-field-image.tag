<layout-field-image>

    <cp-thumbnail show="{ mode == 'show' }" src="{ (!opts.item.settings.image || !opts.item.settings.image.path) ? '' : (opts.item.settings.image.path.match(/^(http\:|https\:|\/\/)/) ? opts.item.settings.image.path : (SITE_URL+'/'+opts.item.settings.image.path.replace(/^\//, ''))) }" height="{ opts.item.settings.height ? opts.item.settings.height : (!opts.item.settings.width ? 160 : '') }" width="{ opts.item.settings.width || '' }" onclick="{ edit }" class="uk-text-{ opts.item.settings.align || 'center' }"></cp-thumbnail>

    <div show="{ mode == 'edit' }">
        <field-image bind="{ opts.bind }.image"></field-image>
    </div>

    <script>

        var $this = this;

        this.mode = opts.item.settings.image && opts.item.settings.image.path ? 'show' : 'edit';

        this.parent.on('leavecomponent', function() {
            $this.show();
        });

        this.edit = function() {
            this.mode = 'edit';
            this.update();
        }

        this.show = function() {

            if (opts.item.settings.image && opts.item.settings.image.path) {

                this.mode = 'show';
                this.update();
            }
        }

    </script>

</layout-field-image>
