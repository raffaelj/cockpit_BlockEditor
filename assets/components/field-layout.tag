<field-layout>

    <div class="uk-sortable layout-components {!items.length && 'empty'}" ref="components" data-uk-sortable="animation:250, group:'field-layout-items', handleClass:'field-layout-handle'">

        <div class="layout-component" tabindex="0" each="{ item,idx in items }" data-idx="{idx}" data-block="{ components[item.component] ? components[item.component].block : item.component }">

            <div if="{ components[item.component] }">

                <div class="layout-component-menubar">

                    <div class="layout-component-menubar-left">
                        <i class="field-layout-handle uk-icon-arrows uk-icon-hover" title="{ App.i18n.get('Drag Component') }" data-uk-tooltip></i>
                        <a onclick="{ parent.settings }" title="{ App.i18n.get('Settings') }" data-uk-tooltip><i class="uk-icon-gear uk-icon-hover"></i></a>
                        <a class="" onclick="{ parent.cloneComponent }" title="{ App.i18n.get('Clone Component') }" data-uk-tooltip><i class="uk-icon-clone uk-icon-hover"></i></a>
                        <a class="" onclick="{ parent.addComponent }" title="{ App.i18n.get('Add Component') }" data-uk-tooltip><i class="uk-icon-plus uk-icon-hover"></i></a>
                        <a class="uk-text-danger" onclick="{ parent.remove }" title="{ App.i18n.get('Remove Component') }" data-uk-tooltip><i class="uk-icon-trash-o uk-icon-hover"></i></a>
                    </div><div class="layout-component-menubar-top">
                        <img class="" riot-src="{ parent.components[item.component].icon ? App.base('/assets/app/media/icons/' + parent.components[item.component].icon) : App.base('/assets/app/media/icons/component.svg')}" width="16">
                        <span class="uk-text-muted uk-text-uppercase uk-text-small uk-text-bold">{ item.name || parent.components[item.component].label || App.Utils.ucfirst(item.component) }</span>
                    </div>

                </div>

                <div class="" if="{parent.components[item.component].children}">
                    <field-layout bind="items[{idx}].children" child="true" parent-component="{parent.components[item.component]}" components="{ parent.components }" exclude="{ opts.exclude }" restrict="{ opts.restrict }" debug="{ opts.debug }"></field-layout>
                </div>

                <div class="" if="{item.component == 'grid'}">
                    <field-layout-grid bind="items[{idx}].columns" components="{ parent.components }" exclude="{ opts.exclude }" restrict="{ opts.restrict }" debug="{ opts.debug }"></field-layout-grid>
                </div>

                <div data-is="block-{ components[item.component].block || item.component }" bind="items[{idx}].settings" item="{ item }" options="{ components[item.component] }" if="{ blocks.indexOf('block-'+(components[item.component].block || item.component)) > -1 }"></div>

                <div data-no-block class="uk-grid uk-grid-small uk-grid-match" if="{ isMountProcessFinished && ( blocks.indexOf('block-'+(components[item.component].block || item.component)) == -1 ) }">

                    <div class="uk-width-medium-{field.width || '1-1' }" each="{field,idy in (this.components[item.component].fields || []).concat(this.generalSettingsFields)}" if="{ !field.group || field.group == 'Main' || field.group == 'main' }" no-reorder>

                        <label class="uk-text-small uk-text-bold"><i class="uk-icon-pencil-square uk-margin-small-right"></i> { field.label || field.name }</label>

                        <div class="uk-margin-small-top uk-text-small uk-text-muted" show="{field.info}">{ field.info }</div>

                        <div class="uk-margin-small-top">
                            <cp-field type="{field.type || 'text'}" bind="items[{idx}].settings.{field.name}" opts="{ field.options || {} }"></cp-field>
                        </div>


                    </div>
                </div>

            </div>
            <div if="{ !components[item.component] }">
                <div class="uk-flex uk-flex-middle layout-component-topbar">

                    <div class="uk-flex-item-1 ">
                        <i class="uk-icon-warning"></i>
                        <span class="uk-text-muted uk-text-uppercase uk-text-small uk-text-bold uk-text-warning">{ App.i18n.get('Unknown component') }</span>
                    </div>
                    <div class="">
<!--                         <a onclick="{ parent.settings }" title="{ App.i18n.get('Settings') }"><i class="uk-icon-gear"></i></a> -->
                        <a class="uk-margin-small-left" onclick="{ parent.cloneComponent }" title="{ App.i18n.get('Clone Component') }"><i class="uk-icon-clone"></i></a>
                        <a class="uk-margin-small-left" onclick="{ parent.addComponent }" title="{ App.i18n.get('Add Component') }"><i class="uk-icon-plus"></i></a>
                        <a class="uk-margin-small-left uk-text-danger" onclick="{ parent.remove }"><i class="uk-icon-trash-o"></i></a>
                    </div>
                </div>
                <pre><code>{ JSON.stringify(item, false, 2); }</code></pre>
            </div>
        </div>
    </div>

    <div class="uk-margin uk-text-center">
        <a class="uk-text-primary { !opts.child && 'uk-button uk-button-outline uk-button-large'}" onclick="{ addComponent.bind(this, true) }" title="{ App.i18n.get('Add component') }" data-uk-tooltip="pos:'bottom'"><i class="uk-icon-plus-circle"></i></a>
    </div>

    <div class="uk-modal uk-sortable-nodrag" ref="modalComponents">
        <div class="uk-modal-dialog">
            <h3 class="uk-flex uk-flex-middle uk-text-bold">
                <img class="uk-margin-small-right" riot-src="{App.base('/assets/app/media/icons/component.svg')}" width="30">
                { App.i18n.get('Components') }
            </h3>

            <ul class="uk-tab uk-tab-noborder uk-margin-bottom uk-flex uk-flex-center uk-noselect" show="{ App.Utils.count(componentGroups) > 1 }">
                <li class="{ !componentGroup && 'uk-active'}"><a class="uk-text-capitalize" onclick="{ toggleComponentGroup }">{ App.i18n.get('All') }</a></li>
                <li class="{ group==parent.componentGroup && 'uk-active'}" each="{items,group in componentGroups}" show="{ items.length }"><a class="uk-text-capitalize" onclick="{ toggleComponentGroup }">{ App.i18n.get(group) }</a></li>
            </ul>

            <div class="uk-grid uk-grid-match uk-grid-small uk-grid-width-medium-1-4">
                 <div class="uk-grid-margin" each="{component,name in components}" show="{ isComponentAvailable(name) }">
                    <div class="uk-panel uk-panel-framed uk-text-center">
                        <img riot-src="{ component.icon ? App.base('/assets/app/media/icons/' + component.icon) : App.base('/assets/app/media/icons/component.svg')}" width="30">
                        <p class="uk-text-small">{ component.label || App.Utils.ucfirst(name) }</p>
                        <a class="uk-position-cover" onclick="{ add }"></a>
                    </div>
                </div>
            </div>

            <div class="uk-modal-footer uk-text-right">
                <a class="uk-button uk-button-link uk-button-large uk-modal-close">{ App.i18n.get('Close') }</a>
            </div>
        </div>
    </div>

    <div class="uk-modal uk-sortable-nodrag" ref="modalSettings">
        <div class="uk-modal-dialog { components[settingsComponent.component].dialog=='large' && 'uk-modal-dialog-large' }" if="{settingsComponent}">

            <a class="uk-modal-close uk-close"></a>

            <div class="uk-margin-large-bottom">
                <div class="uk-grid uk-grid-small">
                    <div>
                        <img riot-src="{ components[settingsComponent.component].icon ? App.base('/assets/app/media/icons/' + components[settingsComponent.component].icon) : App.base('/assets/app/media/icons/settings.svg')}" width="30">
                    </div>
                    <div class="uk-flex-item-1">
                        <h3 class="uk-margin-remove">{ components[settingsComponent.component].label || App.Utils.ucfirst(settingsComponent.component) }</h3>
                        <input type="text" class="uk-form-blank uk-width-1-1 uk-text-primary" bind="settingsComponent.name" placeholder="Name" >
                    </div>
                </div>
            </div>

            <ul class="uk-tab uk-margin-bottom uk-flex uk-flex-center">
                <li class="{ !settingsGroup && 'uk-active'}"><a class="uk-text-capitalize" onclick="{ toggleGroup }">{ App.i18n.get('All') }</a></li>
                <li class="{ group==parent.settingsGroup && 'uk-active'}" each="{items,group in settingsGroups}" show="{ items.length }"><a class="uk-text-capitalize" onclick="{ toggleGroup }">{ App.i18n.get(group) }</a></li>
            </ul>

            <div class="uk-grid uk-grid-small uk-grid-match">

                <div class="uk-grid-margin uk-width-medium-{field.width}" each="{field,idx in settingsFields}" show="{!settingsGroup || (settingsGroup == field.group) }" no-reorder>

                    <div class="uk-panel">

                        <label class="uk-text-small uk-text-bold"><i class="uk-icon-pencil-square uk-margin-small-right"></i> { field.label || field.name }</label>

                        <div class="uk-margin-small-top uk-text-small uk-text-muted" show="{field.info}">{ field.info }</div>

                        <div class="uk-margin-small-top">
                            <cp-field type="{field.type || 'text'}" bind="settingsComponent.settings.{field.name}" opts="{ field.options || {} }"></cp-field>
                        </div>
                    </div>

                </div>
            </div>

            <div class="uk-modal-footer uk-text-right">
                <a class="uk-button uk-button-link uk-button-large uk-modal-close">{ App.i18n.get('Close') }</a>
            </div>

        </div>
    </div>

    <script>

        var $this = this;

        riot.util.bind(this);

        this.blocks = Object.keys(riot.tags).filter(function(key) {
            return (/^block-/).test(key);
        });

        this.isSorting = false;
//         this.isModalOpen = false;

        this.mode = 'edit';
        this.items = [];
        this.settingsComponent = null;
        this.componentGroups = {'Core':[]};
        this.generalSettingsFields  = [
            {name: "id", type: "text", group: "General" },
            {name: "class", type: "text", group: "General" },
            {name: "style", type: "code", group: "General", options: {syntax: "css", height: "100px"}}
        ];

        this.components = {
            "section": {
                "group": "Core",
                "children":true
            },

            "grid": {
                "group": "Core"
            },

            "text": {
                "group": "Core",
                "icon": "text.svg",
                "dialog": "large",
                "fields": [
                    {"name": "text", "type": "wysiwyg", "default": ""}
                ]
            },

            "html": {
                "group": "Core",
                "icon": "code.svg",
                "dialog": "large",
                "fields": [
                    {"name": "html", "type": "html", "default": ""}
                ]
            },

            "heading": {
                "group": "Core",
                "icon": "heading.svg",
                "fields": [
                    {"name": "text", "type": "text", "default": "Header"},
                    {"name": "tag", "type": "select", "options":{"options":['h1','h2','h3','h4','h5','h6']}, "default": "h1"}
                ]
            },

            "image": {
                "group": "Core",
                "icon": "photo.svg",
                "fields": [
                    {"name": "image", "type": "image", "default": {}},
                    {"name": "width", "type": "text", "default": ""},
                    {"name": "height", "type": "text", "default": ""},
                    {"name": "align", "type": "select", "default": "", "options": {"options": ["left", "center", "right"]}}
                ]
            },

            "gallery": {
                "group": "Core",
                "icon": "gallery.svg",
                "fields": [
                    {"name": "gallery", "type": "gallery", "default": []}
                ]
            },

            "divider": {
                "group": "Core",
                "icon": "divider.svg",
            },

            "button": {
                "group": "Core",
                "icon": "button.svg",
                "fields": [
                    {"name": "text", "type": "text", "default": ""},
                    {"name": "url", "type": "text", "default": ""}
                ]
            }
        };

        if (window.CP_LAYOUT_COMPONENTS && App.Utils.isObject(window.CP_LAYOUT_COMPONENTS)) {
            this.components = App.$.extend(true, this.components, window.CP_LAYOUT_COMPONENTS);
        }

        if (opts.parentComponent && opts.parentComponent.options) {
            opts = App.$.extend(true, {}, opts.parentComponent.options, opts);
        }

        this.emphasizeComponent = function(e) {
            if ($this.isSorting) return;
            e.stopPropagation();
            e.currentTarget.classList.add('layout-component-active');
        };

        this.deemphasizeComponent = function(e) {
            if ($this.isSorting) return;
            e.currentTarget.classList.remove('layout-component-active');
        };

        this.focusComponent = function(e) {
            $this.emphasizeComponent(e);
            $this.trigger('component.focus', e);
        };

        this.leaveComponent = function(e) {

            e.stopPropagation();

if (opts.debug) console.log('leaveComponent', e.currentTarget.dataset.block);


            if (e.relatedTarget && e.relatedTarget.closest('.uk-modal')) {
                console.log('left focus to any modal');
                return;
            }

            if (e.relatedTarget && e.currentTarget.contains(e.relatedTarget) && !isWrapperComponent(e.relatedTarget)) {
                if (opts.debug) console.log('left focus to inner element');
                return;
            }

            if ($this.refs.modalSettings.contains(e.relatedTarget)) {
                if (opts.debug) console.log('left focus to settings modal');
            }

            $this.deemphasizeComponent(e);

            var block = e.currentTarget.querySelector('[data-is=block-'+e.currentTarget.dataset.block+']');
// if (opts.debug) console.log('block:', block);
            if (block && block._tag) {
                block._tag.trigger('component.leave', e);
            }
            else {
// if (opts.debug) console.log('no block');
            }

        };

        this.addActiveStateEvents = function() {
            App.$('.layout-component:not([id])')
                .attr('id', 'component_'+Math.ceil(Math.random()*10000000))
                .mouseover($this.emphasizeComponent)
                .mouseout($this.deemphasizeComponent)
                .focusin($this.focusComponent)
                .focusout($this.leaveComponent);
        };

        this.on('update', function() {
            // avoid "this.refs.input is undefined" in custom components if they use an existing block template
            // bug seems to be somewhere inside the cp-field component
            if (this.isMounted) this.isMountProcessFinished = true;
        });

        this.on('mount', function() {

            App.trigger('field.layout.components', {components:this.components, opts:opts});

            if (opts.components && App.Utils.isObject(opts.components)) {
                this.components = App.$.extend(true, this.components, opts.components);
            }

            Object.keys(this.components).forEach(function(k) {

                if (Array.isArray(opts.exclude) && opts.exclude.indexOf(k) > -1) return;
                if (Array.isArray(opts.restrict) && opts.restrict.indexOf(k) == -1) return;

                $this.components[k].group = $this.components[k].group || 'Misc';

                var g = $this.components[k].group;

                if (!$this.componentGroups[g]) {
                    $this.componentGroups[g] = [];
                }

                $this.componentGroups[g].push(k);
            });

            window.___moved_layout_item = null;

            // set mouse events for active state
            this.addActiveStateEvents();

//             var editors = {};
            App.$(this.refs.components).on('start.uk.sortable', function(e, sortable, el, placeholder) {
if (opts.debug) console.log('start', el);
                if (!el) return;
                e.stopPropagation();
                window.___moved_layout_item = {idx: el._tag.idx, item: el._tag.item, src: $this};

                $this.isSorting = true;

                $this.trigger('component.move.before', el);

            }).on('stop.uk.sortable', function(e, sortable, el, placeholder) {
if (opts.debug) console.log('stop');
                $this.isSorting = false;

            });

            App.$(this.refs.components).on('change.uk.sortable', function(e, sortable, el, mode) {
if (opts.debug) console.log('change', mode);
                if (!el) return;

                e.stopPropagation();

                var item = window.___moved_layout_item;

                if ($this.refs.components === sortable.element[0]) {

                    switch(mode) {

                        case 'moved':
                            var items = [];

                            App.$($this.refs.components).children().each(function() {
                                items.push(this._tag.item);
                            });

                            $this.$setValue(items);
                            $this.update();

                            break;

                        case 'removed':

                            $this.items.splice(item.idx, 1);
                            $this.$setValue($this.items);
                            break;

                        case 'added':

                            $this.items.splice(el.index(), 0, item.item);
                            $this.$setValue($this.items);
                            el.remove();

                            $this.addActiveStateEvents();

                            if (opts.child) {
                                $this.propagateUpdate();
                            }
                            break;
                    }
if (opts.debug) console.log('trigger: component.'+mode);
                    $this.trigger('component.'+mode);
                }
            });

            UIkit.modal(this.refs.modalSettings, {modal:false}).on('show.uk.modal', function(e) {

if (opts.debug) console.log('open settings modal');
//                 $this.isModalOpen = true;
//                 $this.update();

            }).on('hide.uk.modal', function(e) {

                if (e.target !== $this.refs.modalSettings) {
                    return;
                }

                $this.$setValue($this.items);

//                 $this.isModalOpen = false;

                setTimeout(function(){
                    $this.settingsComponent = null;
                    $this.update();

                    if (opts.child) {
                        $this.propagateUpdate();
                    }
                }, 50);
            });

            this.isMounted = true;

            this.update();
        });

        this.$initBind = function() {
            this.root.$value = this.items;
        };

        this.$updateValue = function(value) {

            if (!Array.isArray(value)) {
                value = [];
            }

            if (JSON.stringify(this.items) != JSON.stringify(value)) {
                this.items = value;
                this.update();
            }

        }.bind(this);

        this.propagateUpdate = function() {

            var n = this;

            while (n.parent) {
                if (n.parent.root.getAttribute('data-is') == 'field-layout') {
                    n.parent.$setValue(n.parent.items);
                }
                n = n.parent;
            }
        }

        isComponentAvailable(name) {

            if (Array.isArray(opts.exclude) && opts.exclude.indexOf(name) > -1) return false;
            if (Array.isArray(opts.restrict) && opts.restrict.indexOf(name) == -1) return false;

            return !this.componentGroup || (this.componentGroup == this.components[name].group);
        }

        addComponent(e, push) {
            this.componentGroup = null;
            this.refs.modalComponents.afterComponent = !push && e.item && e.item.item ? e.item.idx : false;
            UIkit.modal(this.refs.modalComponents, {modal:false}).show();
        }

        cloneComponent(e) {

            var item = JSON.parse(JSON.stringify(e.item.item)), idx = e.item.idx;

            this.items.splice(idx + 1, 0, item);
            this.$setValue(this.items);

            this.addActiveStateEvents();

            setTimeout(function() {
                if (opts.child) $this.propagateUpdate();
            }.bind(this));
        }

        add(e) {

            var item = {
                component: e.item.name,
                settings: { id: '', 'class': '', style: '' }
            };

            var settings = this.components[e.item.name];

            if (Array.isArray(settings.fields)) {

                settings.fields.forEach(function(field) {
                    item.settings[field.name] = field.options && field.options.default || null;
                })
            }

            if (this.components[e.item.name].children) {
                item.children = [];
            }

            if (e.item.name == 'grid') {
                item.columns = [];
            }

            if (App.Utils.isNumber(this.refs.modalComponents.afterComponent)) {
                this.items.splice(this.refs.modalComponents.afterComponent + 1, 0, item);
                this.refs.modalComponents.afterComponent = false;
            } else {
                this.items.push(item);
            }

            this.$setValue(this.items);

            this.addActiveStateEvents();

            setTimeout(function() {

                UIkit.modal(this.refs.modalComponents).hide();

                if (opts.child) {
                    $this.propagateUpdate();
                }

            }.bind(this));
        }

        remove(e) {
            this.items.splice(e.item.idx, 1);

            if (opts.child) {
                this.parent.update()
            }
        }

        settings(e) {

            var component = e.item.item;

            this.settingsComponent = e.item.item;

            this.settingsFields    = (this.components[component.component].fields || []).concat(this.generalSettingsFields);
            this.settingsFieldsIdx = {};
            this.settingsGroups    = {main:[]};
            this.settingsGroup     = 'main';

            // fill with default values
            this.settingsFields.forEach(function(field){

                $this.settingsFieldsIdx[field.name] = field;

                if (component.settings[field.name] === undefined) {
                    component.settings[field.name] = field.options && field.options.default || null;
                }

                if (field.group && !$this.settingsGroups[field.group]) {
                    $this.settingsGroups[field.group] = [];
                } else if (!field.group) {
                    field.group = 'main';
                }

                $this.settingsGroups[field.group || 'main'].push(field);
            });

            if (!this.settingsGroups[this.settingsGroup].length) {
                this.settingsGroup = Object.keys(this.settingsGroups)[1];
            }

            setTimeout(function() {
                UIkit.modal(this.refs.modalSettings, {modal:false}).show();
            }.bind(this));
        }

        toggleGroup(e) {
            e.preventDefault();
            this.settingsGroup = e.item && e.item.group || false;
        }

        toggleComponentGroup(e) {
            e.preventDefault();
            this.componentGroup = e.item && e.item.group || false;
        }

        rebuildEditors() {

            var editorElements = $this.refs.components.find('field-wysiwyg textarea, [data-is=field-wysiwyg] textarea');

            editorElements.forEach(function(el) {
                var editorId = el.id;
                $this.rebuildEditor(editorId);
            });
        }

        rebuildEditor(editorId) {

            var editor = tinymce.get(editorId);
            if (!editor) {
                setTimeout(function() {
                    $this.rebuildEditor(editorId);
                }, 50);
                return;
            }
if (opts.debug) console.log('rebuild editor', editorId);
            var editorSettings = editor.settings;
                tinymce.EditorManager.execCommand('mceRemoveEditor', false, editorId);
                new tinymce.Editor(editorId, editorSettings, tinymce.EditorManager).render();
        }

        this.on('component.moved', function() {
            $this.rebuildEditors();
        });
        this.on('component.added', function() {
            setTimeout(function() {
                $this.rebuildEditors();
            });
        });
        this.on('component.removed', function() {
            setTimeout(function() {
                $this.rebuildEditors();
            });
        });

        function isComponent(el) {
            return el.classList.contains('layout-component') && el.id;
        }
        function isWrapperComponent(el) {
            return el.dataset.block && (($this.components[el.dataset.block] && $this.components[el.dataset.block].children) || el.dataset.block == 'grid' );
        }

    </script>

</field-layout>
