<?php

$this->on('admin.init', function() {

    // Override settings page from LayoutComponents addon
    if (isset($this['modules']['layoutcomponents'])) {
        $this->bind('/layout-components', function() {
            return $this->invoke('BlockEditor\\Controller\\Admin', 'index');
        });
        $this->bind('/layout-components/index', function() {
            return $this->invoke('BlockEditor\\Controller\\Admin', 'index');
        });
    }

    $this->helper('admin')->addAssets([
        'blockeditor:assets/css/style.min.css',

        'blockeditor:assets/components/field-layout.tag',
        'blockeditor:assets/components/field-layout-grid.tag',

        'blockeditor:assets/components/block-heading.tag',
        'blockeditor:assets/components/block-image.tag',
        'blockeditor:assets/components/block-text.tag',
        'blockeditor:assets/components/block-divider.tag',
        'blockeditor:assets/components/block-button.tag',
        'blockeditor:assets/components/block-html.tag',
    ]);

});
