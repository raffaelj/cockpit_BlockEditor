<?php

$this->on('admin.init', function() {

    $this->helper('admin')->addAssets([
        'blockeditor:assets/css/style.min.css',

        'blockeditor:assets/components/field-layout.tag',
        'blockeditor:assets/components/field-layout-grid.tag',
        'blockeditor:assets/components/layout-field-heading.tag',
        'blockeditor:assets/components/layout-field-image.tag',
        'blockeditor:assets/components/layout-field-text.tag',
        'blockeditor:assets/components/layout-field-divider.tag',
        'blockeditor:assets/components/layout-field-button.tag',
        'blockeditor:assets/components/layout-field-html.tag',
    ]);

});
