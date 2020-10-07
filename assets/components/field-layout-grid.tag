<field-layout-grid>

    <div class="uk-text-center uk-placeholder" if="{!columns.length}">
        <a class="uk-button uk-button-link" onclick="{ addColumn }">{ App.i18n.get('Add Column') }</a>
    </div>

    <div class="uk-sortable uk-grid uk-grid-match uk-grid-small uk-grid-width-medium-1-{columns.length > 5 ? 1 : columns.length}" show="{columns.length}" ref="columns" data-uk-sortable="animation:false, handleClass:'field-layout-handle'">
        <div class="uk-grid-margin " each="{column,idx in columns}">
            <div class="layout-component" tabindex="0" data-block="grid-column-{ idx }">
                <div>

                    <div class="layout-component-menubar">

                        <div class="layout-component-menubar-left">
                            <i class="field-layout-handle uk-icon-arrows uk-icon-hover" title="{ App.i18n.get('Drag Component') }" data-uk-tooltip></i>
                            <a onclick="{ parent.settings }" title="{ App.i18n.get('Settings') }" data-uk-tooltip><i class="uk-icon-gear uk-icon-hover"></i></a>
                            <a class="" onclick="{ parent.cloneColumn }" title="{ App.i18n.get('Clone Column') }" data-uk-tooltip><i class="uk-icon-clone uk-icon-hover"></i></a>
                            <a class="" onclick="{ parent.addColumn }" title="{ App.i18n.get('Add Column') }" data-uk-tooltip><i class="uk-icon-plus uk-icon-hover"></i></a>
                            <a class="uk-text-danger" onclick="{ parent.remove }" title="{ App.i18n.get('Remove Component') }" data-uk-tooltip><i class="uk-icon-trash-o uk-icon-hover"></i></a>
                        </div><div class="layout-component-menubar-top">
                            <span class="uk-text-muted uk-text-uppercase uk-text-small uk-text-bold"><i class="uk-icon-columns" alt="Column {(idx+1)}"></i> { App.i18n.get('Column') } { (idx+1) }</span>
                        </div>

                    </div>

                    <div class="">
                        <field-layout bind="columns[{idx}].children" child="true" components="{ opts.components }" exclude="{ opts.exclude }" debug="{ opts.debug }"></field-layout>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="uk-modal uk-sortable-nodrag" ref="modalSettings">
        <div class="uk-modal-dialog" if="{settingsComponent}">
            <h3 class="uk-flex uk-flex-middle uk-margin-large-bottom">
                <img class="uk-margin-small-right" riot-src="{App.base('/assets/app/media/icons/settings.svg')}" width="30">
                { App.i18n.get('Column') }
            </h3>
            <field-set class="uk-margin" bind="settingsComponent.settings" fields="{fields}"></field-set>

            <div class="uk-modal-footer uk-text-right">
                <a class="uk-button uk-button-link uk-button-large uk-modal-close">{ App.i18n.get('Close') }</a>
            </div>

        </div>
    </div>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.columns = [];
        this.fields  = [
            {name: "id", type: "text" },
            {name: "class", type: "text" },
            {name: "style", type: "code", options: {syntax: "css", height: "100px"}  }
        ];
        this.settingsComponent = null;

        this.$updateValue = function(value) {

            if (!Array.isArray(value)) {
                value = [];
            }

            if (JSON.stringify(this.columns) !== JSON.stringify(value)) {
                this.columns = value;
                this.update();
            }

        }.bind(this);

        this.$initBind = function() {
            this.root.$value = this.columns;
        };

        this.propagateUpdate = function() {

            var n = this;

            while (n.parent) {
                if (n.parent.root.tagName == 'field-layout' || n.parent.root.getAttribute('data-is') == 'field-layout') {
                    n.parent.$setValue(n.parent.items);
                }
                n = n.parent;
            }
        }

        this.on('mount', function() {

            App.$(this.refs.columns).on('change.uk.sortable', function(e, sortable, el, mode) {

                if (!el) return;

                e.stopPropagation();

                if ($this.refs.columns === sortable.element[0]) {

                    var columns = [];

                    App.$($this.refs.columns).children().each(function() {
                        columns.push(this._tag.column);
                    });

                    $this.$setValue(columns);
                    $this.update();

                    $this.propagateUpdate();
if (opts.debug) console.log('grid - trigger: component.'+mode);
                    $this.parent.trigger('component.'+mode);
                }
            });

            UIkit.modal(this.refs.modalSettings, {modal:false}).on('hide.uk.modal', function(e) {

                if (e.target !== $this.refs.modalSettings) {
                    return;
                }

                $this.$setValue($this.columns);

                setTimeout(function() {
                    $this.settingsComponent = null;
                    $this.update();
                }, 50);
            });

            this.update();
        });

        addColumn() {

            var column = {
                settings: { id: '', 'class': '', style: '' },
                children: []
            };

            this.columns.push(column);
            this.$setValue(this.columns);

            this.propagateUpdate();
        }

        cloneColumn(e) {

            var column = JSON.parse(JSON.stringify(e.item.column)), idx = e.item.idx;

            this.columns.splice(idx + 1, 0, column);
            this.$setValue(this.columns);

            this.propagateUpdate();
        }

        settings(e) {

            this.settingsComponent = e.item.column;

            setTimeout(function() {
                UIkit.modal(this.refs.modalSettings).show();
            }.bind(this));
        }

        remove(e) {
            this.columns.splice(e.item.idx, 1);
        }

    </script>

</field-layout-grid>
